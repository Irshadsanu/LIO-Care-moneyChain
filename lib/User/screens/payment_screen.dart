import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lio_care/Provider/donation_provider.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:lio_care/User/screens/payment_success_screen.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:provider/provider.dart';

import '../../constants/my_colors.dart';

class PaymentScreen extends StatelessWidget {
  final String distributionId;
final  String userUpgradeProfileImage;
final String userUpgradeName;
final String userUpgradeId;
final  String userUpgradeNumber;
final  String userUpgradeAmount;
final  String userUpgradeStatus;
final  String userUpgradeUpiID;
final String userPaymentType;
final String userUpgradeGrade;
final String userUpgradeTree;

   const PaymentScreen({Key? key,
     required this.distributionId,
     required this.userUpgradeProfileImage,
        required this.userUpgradeName,
        required this.userUpgradeId,
        required this.userUpgradeNumber,
     required this.userUpgradeAmount,
     required this.userUpgradeStatus,
     required this.userPaymentType,
     required this.userUpgradeUpiID, required this.userUpgradeGrade, required this.userUpgradeTree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;

    return Scaffold(
      // backgroundColor: bxkclr,
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: myWhite,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: (){
              finish(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios,color: textColor,),
                  Image.asset("assets/bluelogo.png",scale: 18,),
                ],
              ),
            )),
      ),
      body: Container(
        height: height,
        width:width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                textColor,
                myWhite
              ],
              begin: Alignment.topCenter,
              end: Alignment.center
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height*0.01,),
              // Align(
              //   alignment: Alignment.center,
              //     child: Image.asset("assets/liocareLogo.png",scale: 1.2,)),
              // const Text("Lio Care",
              //   style: TextStyle(
              //     color: cl1746A2,
              //       fontSize: 28,
              //       fontFamily: "PoppinsRegular",
              //       fontWeight: FontWeight.w700,
              //
              //   ),),
              // const Text("Online Helping Platform",
              //   style: TextStyle(
              //     color: clFF731D,
              //       fontSize: 10,
              //       fontFamily: "PoppinsRegular",
              //       fontWeight: FontWeight.w700,
              //
              //   ),),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: width,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 1,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ],
                      borderRadius: BorderRadius.circular(27)),
                  child: Column(
                    children:  [
                       Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0,left: 20,bottom: 10),
                          child: Text(userPaymentType,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "PoppinsRegular",),),
                        ),
                      ),
                      userUpgradeProfileImage!="" ? CircleAvatar(
                        radius: 58,
                        backgroundImage: NetworkImage(
                            userUpgradeProfileImage),
                      ):const CircleAvatar(
                        radius: 58,
                        child: Icon(Icons.person),
                      ),
                      const SizedBox(height: 10,),
                       Text(userUpgradeName,
                        style: const TextStyle(
                            fontSize: 21,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontFamily: "PoppinsRegular"
                        ),),
                      const SizedBox(height: 5,),
                       Text(userUpgradeNumber,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black
                        ),
                        textAlign: TextAlign.center,),
                       Text(userUpgradeId,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.black,
                        ),
                        textAlign: TextAlign.center,),
                      const SizedBox(height: 16,),
                      Text("Payable Amount",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: clFF731D,
                            fontFamily: "PoppinsRegular"
                        ),),
                       Text(userUpgradeAmount,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),),

                      const SizedBox(height: 10,)
                    ],
                  ),
                ),
              ),
              const Text("Choose Payment App",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black,fontFamily: "PoppinsRegular"),),
              const SizedBox(height: 15,),
              Consumer<UserProvider>(
                builder: (context,value3,child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          value3.launchGooglePay("GPAY");
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          radius: 30,
                          // backgroundImage:  const AssetImage(
                          //   "assets/GooglePay.png",
                          // ),
                          child: Image.asset("assets/GooglePay.png",scale: 3.1),
                        ),
                      ),
                    const SizedBox(width: 15,),
                      InkWell(
                        onTap: (){
                          value3.launchGooglePay("PAYTM");

                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          radius: 30,
                          backgroundImage: const AssetImage(
                            "assets/paytm.png",
                          ),
                        ),
                      ),
                      const SizedBox(width: 15,),
                      InkWell(
                        onTap: (){
                          value3.launchGooglePay("PHONEPAY");

                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          radius: 30,
                          backgroundImage: const AssetImage(
                            "assets/phonepe.png",
                          ),
                        ),
                      ),
                  ],);
                }
              ),
              const SizedBox(height: 60,),
              Consumer<UserProvider>(
                builder: (context2,value31,child) {
                  return InkWell(
                    onTap: (){
                      if(userUpgradeUpiID!=""){
                        value31.notifyCopyBool();
                        Clipboard.setData(ClipboardData(text: userUpgradeUpiID)).then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            backgroundColor: Colors.black,
                            content: Text(
                              "Copied",
                              style: TextStyle(color: Colors.white),
                            ),
                          ));
                        });}
                    },
                    child: userUpgradeUpiID!=""?  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.copy_rounded,size: 16,color:value31.upiCopyBool?greenNew: cl5F5F5F,),
                        Text(value31.upiCopyBool?"UPI ID Copied":"Click here to copy",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color:value31.upiCopyBool?greenNew: cl5F5F5F,
                            fontFamily: "PoppinsRegular"
                        ),),
                      ],
                    ):const SizedBox(),
                  );
                }
              ),
              const SizedBox(height: 5,),
              Consumer<UserProvider>(
                  builder: (context2,value39,child) {
                   return InkWell(
                     onTap: (){
                   if(userUpgradeUpiID!=""){
                     value39.notifyCopyBool();
                       Clipboard.setData(ClipboardData(text: userUpgradeUpiID)).then((_) {
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                           backgroundColor: Colors.black,
                           content: Text(
                             "Copied",
                             style: TextStyle(color: Colors.white),
                           ),
                         ));
                       });}
                     },
                     child: Text(userUpgradeUpiID!=""?"UPI ID:$userUpgradeUpiID":"UPI ID",
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: cl1746A2
                                 ),),
                   );
                 }
               ),

              Consumer<UserProvider>(
                builder: (context,val,child) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                      onTap: (){
                        val.showBottomSheet2(context,distributionId,"RECEIPT",userUpgradeName,userUpgradeNumber,"","", userUpgradeId,userUpgradeProfileImage,"",userPaymentType,userUpgradeTree,userUpgradeGrade);
                       // callNext(const PaymentSuccessScreen(), context);
                      },
                      child: Container(
                        height: 45,
                        width: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        color: cl1746A2,
                        ),
                        child:  const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_upward_rounded,color: Colors.white,),
                            Text("Attach Receipt",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 12),),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
