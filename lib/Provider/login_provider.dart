import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/functions.dart';
import '../User/screens/bottomNavigation.dart';

import '../User/screens/prc_screen.dart';
import '../User/screens/user_income_screen.dart';
import '../admin/screens/admin_homeScreen.dart';
import '../view/loginScreen.dart';


class LoginProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController userLoginPhoneCT = TextEditingController();
  TextEditingController userLoginPasswordCT = TextEditingController();
  bool hidePassword = true;

  Future<void> userAuthorized(String from ,String? phoneNumber,var token, BuildContext context) async {

    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);

    String loginUserid='';
    String loginUserType='';
    String loginUserName='';
    String loginUserPhone='';
    String loginUserStatus='';
    String loginUserEmail='';
    String loginUserReferral='';
    String loginUserUpiId='';
    int loginUserChildCount=0;
    int loginUserDaysLeft=0;
    int joinDate = 0;
    int totalDays = 30;
    try {

      var phone = phoneNumber!.substring(3,13);

        db.collection("USERS")
            .where("PHONE",isEqualTo:phone )
            .get().then((value) async {
          if(value.docs.isNotEmpty){
            print("data exist");
            Map<dynamic,dynamic> map = value.docs.first.data();
            loginUserStatus=map["STATUS"]??"";
            loginUserType=map["TYPE"]??"";
            loginUserid=value.docs.first.id;
            loginUserPhone=map["PHONE"]??"";
            if(loginUserStatus=="ACTIVE"){
              print("active data exist");
              loginUserChildCount = int.parse(map["CHILD_COUNT"].toString());
              Duration difference = DateTime.now().difference(map["REG_DATE"].toDate());
              loginUserDaysLeft = totalDays - (joinDate = difference.inDays);
              FirebaseMessaging.instance.getToken().then((fcmValue) {
                if(loginUserChildCount<2&&loginUserDaysLeft<1&&loginUserType=="MEMBER"){
                  db.collection("USERS").doc(loginUserid).set({'STATUS': "BLOCKED",'FCM_ID': fcmValue.toString()},SetOptions(merge: true));
                }else {
                  db.collection("USERS").doc(loginUserid).set({'FCM_ID': fcmValue.toString()},SetOptions(merge: true));
                }
              });
              await userProvider. clearStreamSubscriptions();
              userProvider. getUserDetails(loginUserid);
              // userProvider. fetchUserAllGrades(loginUserid);
              userProvider. fetchFirstNotification(loginUserid);
              userProvider.fetchUserReferences(loginUserPhone);
              userProvider. fetchInTransactions(loginUserid);
              userProvider. fetchInReferralTransactions(loginUserid);
              userProvider. fetchReferralTransactions(loginUserid);
              userProvider. fetchMyTasks(loginUserid);
              userProvider. getMessages(loginUserid);
              userProvider. fetchParentList(loginUserid);
              userProvider.fetchMyInvitationCount(loginUserid,loginUserType);

              callNextReplacement(BottomNavigationScreen(Userid: loginUserid), context);
            }
            else if(loginUserStatus=="IN_ACTIVE"){
              print("active data exist");
              loginUserName=map["NAME"]??"";
              loginUserUpiId=map["UPI_Id"]??"";
              loginUserEmail=map["EMAIL"]??"";
              loginUserReferral=map["REFERENCE_NUMBER"]??"";
              userProvider.fetchPrcPayment(loginUserid);
              callNextReplacement( PRCScreen(userName: loginUserName, phoneNumber: phone,
                  email: loginUserEmail, upiId: loginUserUpiId, referral: loginUserReferral), context);
            }

            if(from=="LOGIN"){
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('appwrite_token', token);
              prefs.setString('phone_number', phoneNumber);
            }


          }
          else {
            auth.signOut();
            callNextReplacement( LoginScreen(referralId: '',), context);
          }
        });


    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Sorry , Some Error Occurred'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void adminAuthorized(String? phoneNumber, String? password, BuildContext context){
    print("ytrtesrdfgthjklygufh");
    print(password);
    const snackBar = SnackBar(
      content: Text('Sorry , Some Error Occurred'),
    );
    const snackBar2 = SnackBar(
      content: Text('Wrong password...'),
    );
    AdminProvider adminProvider =
    Provider.of<AdminProvider>(context, listen: false);
    adminProvider.adminName = '';
    adminProvider.adminPhone = '';
    adminProvider.adminImage = '';
    adminProvider.adminId = '';
    adminProvider.adminPassword = '';
    adminProvider.adminPrivilegeList.clear();
    try{
      db.collection("ADMINS")
          .where("PHONE_NUMBER",isEqualTo: phoneNumber)
          .where("STATUS",isEqualTo: "ACTIVE")
          .where("PASSWORD",isEqualTo: password).get().then((adminValue) async {

        if(adminValue.docs.isNotEmpty){
          Map<dynamic,dynamic> adminMap = adminValue.docs.first.data();
          adminProvider.adminName = adminMap["NAME"].toString();
          adminProvider.adminPhone = adminMap["PHONE_NUMBER"].toString();
          adminProvider.adminImage = adminMap["PROFILE_IMAGE"].toString();
          adminProvider.adminId = adminValue.docs.first.id;
          adminProvider.adminPassword = password!;
          if(adminMap["PRIVILEGE"]!=null){
            adminProvider.adminPrivilegeList = adminMap["PRIVILEGE"];
          }
          adminProvider. fetchAdminsDetails(adminProvider.adminId);
          notifyListeners();
          FirebaseMessaging.instance.getToken().then((fcmValue) {
            db.collection("ADMINS").doc(adminProvider.adminId).set(
                {'FCM_ID': fcmValue.toString()},SetOptions(merge: true));
          });
          SharedPreferences userPreference = await SharedPreferences.getInstance();
          userPreference.setString("PHONE_NUMBER",phoneNumber!);
          userPreference.setString("PASSWORD",password);
          adminProvider.fetchAdminLeaders();
          adminProvider.adminHomeDetails();
          adminProvider.fetchReferralLedger(true);
          adminProvider.fetchPendingRegistrations(true);

          callNextReplacement( const AdminHomeScreen(), context);
        }
        else{
          print("dcfghbjnkml,;");
          db.collection("USERS")
              .where("PHONE", isEqualTo: phoneNumber)
              .where("TYPE", isEqualTo: "ADMIN LEADER")
              .where("PASSWORD", isEqualTo: password)
              .get()
              .then((QuerySnapshot<Map<String, dynamic>> adminValue) async {
            if (adminValue.docs.isNotEmpty) {
              Map<String, dynamic> map = adminValue.docs[0].data();
              SharedPreferences userPreference = await SharedPreferences.getInstance();
              userPreference.setString("PHONE_NUMBER",phoneNumber!);
              userPreference.setString("PASSWORD",password!);
              callNext(IncomeScreen(loginId: map["MEMBER_ID"],admin: true,), context);
            }else{
              ScaffoldMessenger.of(context).showSnackBar(snackBar2);
            }
          });


        }

      });
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  }

   showHidePassword(){
    if(hidePassword){
      hidePassword = false;
      notifyListeners();
      Timer(const Duration(milliseconds: 1000), () {
        hidePassword = true;
        notifyListeners();
      });
    }else{
      hidePassword = true;
      notifyListeners();
    }
  }

}


