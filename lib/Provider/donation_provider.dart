import 'dart:collection';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

import '../Constants/functions.dart';
import '../Service/device_info.dart';
import '../Service/time_service.dart';
import '../User/screens/Prc_Success_screen.dart';
import '../User/screens/payment_success_screen.dart';
import '../models/timeStamp_model.dart';
import '../models/upi_model.dart';

class DonationProvider extends ChangeNotifier  {
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  FirebaseFirestore db = FirebaseFirestore.instance;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static const platformChanel = MethodChannel('payuGateway');


  /// controllers


  var outputDayNode = DateFormat('d/MM/yyy');
  var outputDayNode3 = DateFormat('dd/MM/yyyy');
  var outputDayNode2 = DateFormat('h:mm a');
  String generateRandomString(int length) {
    final random = Random();
    const availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    final randomString = List.generate(length,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();
    return randomString;
  }

  Future<void> upiIntent(BuildContext context,String amount,String type,String phone,String app,String appver,
      String grade,String fromId,String tree,String distributionId,String userName,int installment,String txnID) async {
  // String txnID=DateTime.now().millisecondsSinceEpoch.toString() + generateRandomString(2);
  UpiModel upiModel= await getUpiUri(app, amount.replaceAll(',', ''),txnID);
  var arguments={'Uri':upiModel.uri,};
  if(Platform.isAndroid){
    String status=await platformChanel.invokeMethod(app,arguments);
// status = "Success";
    if(status!='NoApp'){

      if(status!='FAILED'){
        print("Status success : "+status);
        upDatePayment("SUCCESS", status, context, txnID, app,upiModel.upiId,appver,amount,type,phone,grade,fromId,tree,distributionId,userName,installment);


      }else{
        print("Status failed : "+status);
        // upDatePayment("SUCCESS", status, context, txnID, app,upiModel.upiId,appver,amount,type,phone,grade,fromId,tree,distributionId,userName,installment);

        upDatePayment("FAILED", "no response", context, txnID, app,upiModel.upiId,appver,amount,type,phone,grade,fromId,tree,distributionId,userName,installment);

        // callNextReplacement(const PaymentSuccessScreen(status: "FAILDE"), context);

        // callNextReplacement(Paymen, context)
      }

    }
    else{
      String url='';
      if(app=='BHIM'){
        url='https://play.google.com/store/apps/details?id=in.org.npci.upiapp&hl=en_IN&gl=US';
      }else if(app=='GPay'){
        url='https://play.google.com/store/apps/details?id=com.google.android.apps.nbu.paisa.user&hl=en_IN&gl=US';
      }else if(app=='Paytm'){
        url='https://play.google.com/store/apps/details?id=net.one97.paytm&hl=en_IN&gl=US';
      }else if(app=='PhonePe'){
        url='https://play.google.com/store/apps/details?id=com.phonepe.app&hl=en_IN&gl=US';
      }
      _launchURL(url);
    }
  }

}

  Future<void> prcUpiIntent(BuildContext context,String amount,String phone,String app,String appver,
      String fromId,String distributionId,String userName,String txnID) async {
    // String txnID=DateTime.now().millisecondsSinceEpoch.toString() + generateRandomString(2);
    UpiModel upiModel= await getUpiUri(app, amount.replaceAll(',', ''),txnID);
    var arguments={'Uri':upiModel.uri,};
    if(Platform.isAndroid){
      String status=await platformChanel.invokeMethod(app,arguments);
      print("Status : "+status);
      // status = "Success";
      if(status!='NoApp'){

        if(status!='FAILED'){
          upDatePrcPayment("SUCCESS", status, context, txnID, app,upiModel.upiId, appver,amount,phone,fromId,distributionId,userName);


        }else{

          upDatePrcPayment("FAILED", "no response", context, txnID, app,upiModel.upiId,appver,amount, phone,fromId,distributionId,userName);

          // upDatePrcPayment("SUCCESS", "no response", context, txnID, app,upiModel.upiId,appver,amount, phone,fromId,distributionId,userName);

        }

      }
      else{
        String url='';
        if(app=='BHIM'){
          url='https://play.google.com/store/apps/details?id=in.org.npci.upiapp&hl=en_IN&gl=US';
        }else if(app=='GPay'){
          url='https://play.google.com/store/apps/details?id=com.google.android.apps.nbu.paisa.user&hl=en_IN&gl=US';
        }else if(app=='Paytm'){
          url='https://play.google.com/store/apps/details?id=net.one97.paytm&hl=en_IN&gl=US';
        }else if(app=='PhonePe'){
          url='https://play.google.com/store/apps/details?id=com.phonepe.app&hl=en_IN&gl=US';
        }
        _launchURL(url);
      }
    }

  }

  upDatePayment(String status, String response, BuildContext context, String orderID,
      String app, String upiIdP,String appVersion, String amount,String type,String phoneNumber,
      String grade,String fromId,String tree,String distributionId,String userName,int installment
      ) async {


    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
    DateTime now =DateTime.now();
    String timeString ="";
    TimeStampModel? timeStampModel=await TimeService().getTime();
    if(timeStampModel!=null){
      now = timeStampModel.datetime.toLocal();
      timeString = outputDayNode.format(now).toString();
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageVersion = packageInfo.version;
    String? strDeviceID = "";
    try {
      strDeviceID = await UniqueIdentifier.serial;
    } on PlatformException {
      strDeviceID = 'Failed to get Unique Identifier';
    }
    HashMap<String, Object> map = HashMap();
    map["RESPONDS"] = response;
     map["PHONE_NUMBER"] =userProvider.userPhone;
    map["TIME"] = now.millisecondsSinceEpoch.toString();
    if (status == "SUCCESS") {
      map["PAYMENT_STATUS"] = "SUCCESS";
    } else {
      map["PAYMENT_STATUS"] = "FAILED";
    }
    // String strDeviceID = await DeviceInfo().fun_initPlatformState();
    map["DEVICE_ID"] = strDeviceID!;
    map["PACKAGE_VERSION"] = packageVersion;
    map["AMOUNT"] = double.parse(amount);
    map["USER_NAME"]=userProvider.userName;
    map["FROM_USER_ID"]=fromId;
    map["GRADE"]=grade;
    map["TREE"]=tree;
    map["PAYMENT_MODE"]="APP_PAYMENT";
    map["PAYMENT_TYPE"]=type;
    map["PAYMENT_APP"] = app;
    map["PAYMENT_TIME"]=now;
    map["APP_VERSION"]=appVersion;
    map["DISTRIBUTION_ID"]=distributionId;
    map["INSTALLMENT"]=installment.toString();
    db.collection("ATTEMPTS").doc(orderID).set(map,SetOptions(merge: true));
    if (status == "SUCCESS") {

        db.collection("DISTRIBUTIONS")
          .where("FROM_ID",isEqualTo: fromId)
          .where("GRADE",isEqualTo: grade)
          .where("TREE",isEqualTo: tree)
          .where("STATUS",whereNotIn:["PAID"] ).get().then((gradeValue)  async {
        if(gradeValue.docs.length==1){
          String newGrade = await userProvider.findNextLevel(grade,fromId,tree);

          db.collection("USERS").doc(fromId).get().then((userValue) async {
            Map<dynamic,dynamic> fromUserMap = userValue.data() as Map;
            if(tree=="MASTER_CLUB") {
              await userProvider.generateNextBasicDistributions(grade, fromId, tree, fromUserMap["DOCUMENT_ID"]);
              if(type=="PMC") {
                db.collection("USERS").doc(fromId).set({
                  "GRADE":newGrade,
                  "TOTAL_PMC":FieldValue.increment(double.parse(amount)),
                },SetOptions(merge: true));
                db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
                  "PMC":FieldValue.increment(double.parse(amount)),
                  "PMC_COUNT": FieldValue.increment(1),
                },SetOptions(merge: true));
              }
              else{
                db.collection("USERS").doc(fromId).set({
                  "GRADE":newGrade,
                  "TOTAL_CMF":FieldValue.increment(double.parse(amount)),
                },SetOptions(merge: true));
                db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
                  "CMF":FieldValue.increment(double.parse(amount)),
                  "CMF_COUNT": FieldValue.increment(1),
                },SetOptions(merge: true));
              }
            }
            else if(tree=="STAR_CLUB"){
              await userProvider.generateNextOneDistributions(grade, fromId, tree, fromUserMap["DOCUMENT_ID"]);
              if(type=="PMC") {
                db.collection("USERS").doc(fromId).set({
                  "AUTO_ONE_GRADE":newGrade,
                  "TOTAL_PMC":FieldValue.increment(double.parse(amount)),
                },SetOptions(merge: true));
                db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
                  "PMC":FieldValue.increment(double.parse(amount)),
                  "PMC_COUNT": FieldValue.increment(1),
                },SetOptions(merge: true));
              }else{
                db.collection("USERS").doc(fromId).set({
                  "AUTO_ONE_GRADE":newGrade,
                  "TOTAL_CMF":FieldValue.increment(double.parse(amount)),
                },SetOptions(merge: true));
                db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
                  "CMF":FieldValue.increment(double.parse(amount)),
                  "CMF_COUNT": FieldValue.increment(1),
                },SetOptions(merge: true));
              }
            }
            else{
              await userProvider.generateNextTwoDistributions(grade, fromId, tree, fromUserMap["DOCUMENT_ID"]);
              if(type=="PMC") {
                db.collection("USERS").doc(fromId).set({
                  "AUTO_TWO_GRADE":newGrade,
                  "TOTAL_PMC":FieldValue.increment(double.parse(amount)),
                },SetOptions(merge: true));
                db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
                  "PMC":FieldValue.increment(double.parse(amount)),
                  "PMC_COUNT": FieldValue.increment(1),
                },SetOptions(merge: true));
              }
              else{
                db.collection("USERS").doc(fromId).set({
                  "AUTO_TWO_GRADE":newGrade,
                  "TOTAL_CMF":FieldValue.increment(double.parse(amount)),
                },SetOptions(merge: true));
                db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
                  "CMF":FieldValue.increment(double.parse(amount)),
                  "CMF_COUNT": FieldValue.increment(1),
                },SetOptions(merge: true));
              }
            }
            String newId = now.millisecondsSinceEpoch.toString()+generateRandomString(2);
            // toList.add(map["TO_ID"].toString());
            HashMap<String, Object> notificationMap = HashMap();
            notificationMap["CONTENT"] = "Well done! You've been promoted to $newGrade level.";
            notificationMap["FROM_ID"] = fromId;
            notificationMap["TO_ID"] = [fromId];
            notificationMap["NOTIFICATION_ID"] = newId;
            notificationMap['REG_DATE'] = now;
            notificationMap["VIEWERS"] = [];
            notificationMap["DATE"] = outputDayNode3.format(now).toString();
            notificationMap["TIME"] = outputDayNode2.format(now).toString();
            db.collection('NOTIFICATIONS').doc(newId).set(notificationMap);

            db.collection(tree).doc(userValue.get("DOCUMENT_ID").toString())
                .set({"GRADE":newGrade},SetOptions(merge: true));
          });
          callNext(PaymentSuccessScreen(status: status, memberId: fromId, grade: grade, tree: tree, isNewGrade: true, memberPhone: phoneNumber,), context);
        }
        else{
          if(type=="PMC") {
            db.collection("USERS").doc(fromId).set({
              "TOTAL_PMC":FieldValue.increment(double.parse(amount)),
            },SetOptions(merge: true));
            db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
              "PMC":FieldValue.increment(double.parse(amount)),
              "PMC_COUNT": FieldValue.increment(1),
            },SetOptions(merge: true));
          }else{
            db.collection("USERS").doc(fromId).set({
              "TOTAL_CMF":FieldValue.increment(double.parse(amount)),
            },SetOptions(merge: true));
            db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({"CMF":FieldValue.increment(double.parse(amount)), "CMF_COUNT": FieldValue.increment(1),
            },SetOptions(merge: true));
          }
          notifyListeners();
          callNext(PaymentSuccessScreen(status: status, memberId: fromId, grade: grade,
            tree: tree, isNewGrade: false, memberPhone: phoneNumber,), context);
        }
        db.collection('TRANSACTIONS').doc(orderID).set(map);
        db.collection('PAYMENTS').doc(orderID).set(map);
        db.collection('DISTRIBUTIONS').doc(distributionId).set({"STATUS":"PAID"},SetOptions(merge: true));
      });


    }else{
      callNext(PaymentSuccessScreen(status: status, memberId: fromId, grade: grade,
        tree: tree, isNewGrade: false, memberPhone: phoneNumber,), context);
    }
    notifyListeners();
  }

  void clearIssueClearence(){
     prcClearanceMemberId = '';
     prcClearanceDistributionId = '';
     prcClearanceDistributionAmount = '';
     prcClearanceUserName = '';
     prcClearancePhoneNumber = '';
     prcClearanceDistributionStatus = '';
     prcClearanceUserFcmValue = '';
     prcClearPhoneCt.clear();
     prcClearTransactionCt.clear();

  }
  TextEditingController prcClearPhoneCt =TextEditingController();
  TextEditingController prcClearTransactionCt =TextEditingController();
  String prcClearanceMemberId = '';
  String prcClearanceDistributionId = '';
  String prcClearanceDistributionAmount = '';
  String prcClearanceUserName = '';
  String prcClearanceUserFcmValue = '';
  String prcClearancePhoneNumber = '';
  String prcClearanceDistributionStatus = '';

  getPrcClearanceDetails(String issuePhoneNumber,String issueOrderId) async {

    var issueValue = await db.collection("USERS").where("PHONE",isEqualTo: issuePhoneNumber).get();
      if(issueValue.docs.isNotEmpty){
        Map<dynamic, dynamic> issueMap = issueValue.docs.first.data() as Map;
        prcClearanceMemberId = issueMap["MEMBER_ID"].toString();
        prcClearanceUserName = issueMap["NAME"].toString();
        prcClearanceUserFcmValue = issueMap["FCM_ID"].toString();
        prcClearancePhoneNumber = issuePhoneNumber;
        notifyListeners();
        var issueDistributionValue = await db.collection("DISTRIBUTIONS")
            .where("FROM_ID",isEqualTo: prcClearanceMemberId)
            .where("TYPE",isEqualTo: "PRC")
            .get();
        if(issueDistributionValue.docs.isNotEmpty){
          Map<dynamic, dynamic> issueDistributionMap = issueDistributionValue.docs.first.data() as Map;
          prcClearanceDistributionId = issueDistributionValue.docs.first.id;
          prcClearanceDistributionStatus = issueDistributionMap["STATUS"].toString();
          prcClearanceDistributionAmount = issueDistributionMap["AMOUNT"].toString();
          notifyListeners();
        }
      }
  }

  clearPrcIssue(BuildContext context, String orderID) async {
    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
    DateTime now =DateTime.now();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageVersion = packageInfo.version;
    HashMap<String, Object> map = HashMap();
    map["RESPONDS"] = "Issue Clearance Portal";
    map["PHONE_NUMBER"] =prcClearancePhoneNumber;
    map["TIME"] = now.millisecondsSinceEpoch.toString();
    map["PAYMENT_STATUS"] = "SUCCESS";
    map["DEVICE_ID"] = "";
    map["PACKAGE_VERSION"] = packageVersion;
    map["AMOUNT"] = double.parse(prcClearanceDistributionAmount);
    map["USER_NAME"]=prcClearanceUserName;
    map["FROM_USER_ID"]=prcClearanceMemberId;
    map["GRADE"]="";
    map["TREE"]="MASTER_CLUB";
    map["PAYMENT_MODE"]="APP_PAYMENT";
    map["PAYMENT_TYPE"]="PRC";
    map["PAYMENT_APP"] = "GPay";
    map["PAYMENT_TIME"]=now;
    map["APP_VERSION"]=userProvider.appBuildVersion.toString();
    map["DISTRIBUTION_ID"]=prcClearanceDistributionId;
    map["INSTALLMENT"]="1";
    db.collection("ATTEMPTS").doc(orderID).set(map,SetOptions(merge: true));

      print("reached 11");
      await userProvider.prcIssuePlaceMemberInTree(prcClearanceMemberId,prcClearanceUserFcmValue, context);

      await db.collection('TRANSACTIONS').doc(orderID).set(map);
      await db.collection('PAYMENTS').doc(orderID).set(map);
      await db.collection('DISTRIBUTIONS').doc(prcClearanceDistributionId).set({"STATUS":"PAID"},SetOptions(merge: true));


      print("reached 22");
      await db.collection('USERS').doc(prcClearanceMemberId).set({
        "STATUS":"ACTIVE",
        "ACTIVE_DATE":now,
        "TREES":["MASTER_CLUB"],
        // "TOTAL_PMC":FieldValue.increment(double.parse(amount)),
      },SetOptions(merge: true));
      print("reached 31");
      await db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
        "MEMBERS": FieldValue.increment(1),
        "PRC_COUNT": FieldValue.increment(1),
        "PRC": FieldValue.increment(double.parse(prcClearanceDistributionAmount)),
      },SetOptions(merge: true));
    approveExchange(context);
    notifyListeners();
  }

  prcIssuePlaceMemberOnly(BuildContext context, String orderID) async {
    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
      print("reached 11");
      await userProvider.prcIssuePlaceMemberInTree(prcClearanceMemberId,prcClearanceUserFcmValue, context);
    approveExchange(context);
    notifyListeners();
  }



  approveExchange(
      BuildContext context,
      ) {
    final width = MediaQuery.of(context).size.width;
    AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        content: Container(

          // height: height*0.26,
            width: width / 5.5,
            height: 200,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFFEBEBEB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x1C000000),
                  blurRadius: 11,
                  offset: Offset(0, 9),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Issue Cleared",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF252525),
                        fontSize: 16,
                        fontFamily: 'PoppinsRegular',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                     Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: InkWell(
                              onTap: () {
                                clearIssueClearence();
                                finish(context);
                              },
                              child: Container(
                                width: 120,
                                height: 39,
                                alignment: Alignment.center,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF2F7DC1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(62),
                                  ),
                                ),
                                child: const Text(
                                  "OK",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFFFFCF8),
                                    fontSize: 16,
                                    fontFamily: 'PoppinsRegular',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      )

                  ],
                ),
              )
            ])));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  upDatePrcPayment(String status, String response, BuildContext context, String orderID,
      String app, String upiIdP,String appVersion, String amount,String phoneNumber,
      String fromId,String distributionId,String userName
      ) async {

    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
    DateTime now =DateTime.now();
    String timeString ="";
    TimeStampModel? timeStampModel=await TimeService().getTime();
    if(timeStampModel!=null){
      now = timeStampModel.datetime.toLocal();
      timeString = outputDayNode.format(now).toString();
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageVersion = packageInfo.version;
    String? strDeviceID = "";
    try {
      strDeviceID = await UniqueIdentifier.serial;
    } on PlatformException {
      strDeviceID = 'Failed to get Unique Identifier';
    }
    HashMap<String, Object> map = HashMap();
    map["RESPONDS"] = response;
    map["PHONE_NUMBER"] =phoneNumber;
    map["TIME"] = now.millisecondsSinceEpoch.toString();
    if (status == "SUCCESS") {
      map["PAYMENT_STATUS"] = "SUCCESS";
    } else {
      map["PAYMENT_STATUS"] = "FAILED";
    }
    // String strDeviceID = await DeviceInfo().fun_initPlatformState();
    map["DEVICE_ID"] = strDeviceID!;
    map["PACKAGE_VERSION"] = packageVersion;
    map["AMOUNT"] = double.parse(amount);
    map["USER_NAME"]=userName;
    map["FROM_USER_ID"]=fromId;
    map["GRADE"]="";
    map["TREE"]="MASTER_CLUB";
    map["PAYMENT_MODE"]="APP_PAYMENT";
    map["PAYMENT_TYPE"]="PRC";
    map["PAYMENT_APP"] = app;
    map["PAYMENT_TIME"]=now;
    map["APP_VERSION"]=appVersion;
    map["DISTRIBUTION_ID"]=distributionId;
    map["INSTALLMENT"]="1";
    db.collection("ATTEMPTS").doc(orderID).set(map,SetOptions(merge: true));
    if (status == "SUCCESS") {
      print("reached 11");
      await userProvider.placeMemberInTree(fromId, context);
      await db.collection('TRANSACTIONS').doc(orderID).set(map);
      await db.collection('PAYMENTS').doc(orderID).set(map);
      await db.collection('DISTRIBUTIONS').doc(distributionId).set({"STATUS":"PAID"},SetOptions(merge: true));


        print("reached 22");
      await db.collection('USERS').doc(fromId).set({
          "STATUS":"ACTIVE",
          "ACTIVE_DATE":now,
          "TREES":["MASTER_CLUB"],
          // "TOTAL_PMC":FieldValue.increment(double.parse(amount)),
        },SetOptions(merge: true));
        print("reached 31");
      await db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
          "MEMBERS": FieldValue.increment(1),
          "PRC_COUNT": FieldValue.increment(1),
          "PRC": FieldValue.increment(double.parse(amount)),
        },SetOptions(merge: true));

        callNext(PrcSuccessScreen(status: status, memberId: fromId,  memberPhone: phoneNumber,), context);

    }else{
      callNext(PaymentSuccessScreen(status: status, memberId: fromId, grade: "",
        tree: "MASTER_CLUB", isNewGrade: false, memberPhone: phoneNumber,), context);
    }
    notifyListeners();
  }



  Future<UpiModel> getUpiUri(String app,String amount,String txnID) async {
    double amt=0;

    try{
      amt=double.parse(amount);

    }catch(e){}

    if(amt<2000){
      app=app+'2000';
    }

    var snapshot = await mRoot.child("0").child("AccountDetails").child('PaymentGateway').child(app).once();
    Map<dynamic, dynamic> map = snapshot.snapshot.value as Map;
    String upiId=map['UpiId'];
    String upiName=map['UpiName'];
    String upiAdd=map['UpiAdd'];
    // UpiModel upiModel=UpiModel(upiId, 'upi://pay?pa=$upiId&pn=$upiName&am=$amount&cu=INR&mc=8651&m&purpose=00&tn=kx ${txnID}$upiAdd');
    UpiModel upiModel=UpiModel(upiId, 'upi://pay?pa=$upiId&pn=$upiName&am=$amount&cu=INR&mc=8651&tr=$txnID&tn=li $txnID$upiAdd');
    return upiModel ;
  }

  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }



}