import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../../Constants/functions.dart';
import '../../constants/my_colors.dart';
import 'PRC_Payment_Screen.dart';
import 'home_Screen.dart';

class PRCScreen extends StatelessWidget {
  final String userName;
  final String phoneNumber;
  final String email;
  final String upiId;
  final String referral;
  const PRCScreen({super.key,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.upiId,
    required this.referral,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child:  Scaffold(
        backgroundColor: clFCF9F5,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ///stack in lio logo
              SizedBox(
                height: 140,
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                textColor,
                                cl001969,
                              ])
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFFFFFCF8),
                        radius: 40,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.asset("assets/bluelogo.png",scale: 10),
                        ) ,
                      ),
                    ),
                  ],
                ),
              ),

              ///Just height sized box
              const SizedBox(height:20),


              ///Last trasaction details
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                height: 120,
                width: width*.90,
                decoration: BoxDecoration(
                  color: myWhite, //myWhite
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(
                        0.2,
                        0.2,
                      ),
                      blurRadius: 0.2,
                      spreadRadius: 0.2,
                    ),
                  ],
                  image: const DecorationImage(
                      image: AssetImage("assets/Vector 2.png"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topRight),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Consumer<UserProvider>(
                    builder: (context5, value78, child) {
                      return value78.lastTransactionList.isNotEmpty
                          ? RecentTransactions(list:value78.lastTransactionList )
                          : const SizedBox();
                    }),
              ),


              ///Just height sized box
              const SizedBox(height:30),


              ///Please Complete PRC..Text
               const Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Please Complete",
                      style: TextStyle(
                        color: cl252525,
                        fontSize: 16,
                        fontFamily: 'PoppinsRegular',
                        fontWeight: FontWeight.w400,
                        // height: 0.10,
                      ),
                    ),

                    TextSpan(
                      text: " PRC",
                      style: TextStyle(
                        color: cBlack,
                        fontSize: 16,
                        fontFamily: 'PoppinsRegular',
                        fontWeight: FontWeight.w600,
                        // height: 0.10,
                      ),
                    ),
                  ]
                )

                // 'Please Complete PRC',
                // textAlign: TextAlign.center,
                // style: TextStyle(
                //   color: cl252525,
                //   fontSize: 16,
                //   fontFamily: 'PoppinsRegular',
                //   fontWeight: FontWeight.w400,
                //   // height: 0.10,
                // ),
              ),


              ///Just height sized box
              const SizedBox(height:2),


              // ///Amount rich text rupee with value
              // const Text.rich(
              //   TextSpan(
              //     children: [
              //       TextSpan(
              //         text: "₹",
              //         style: TextStyle(
              //           color: cl2F7DC1,
              //           fontSize: 35,
              //           fontWeight: FontWeight.w700,
              //           letterSpacing: 2,
              //         ),
              //       ),
              //
              //       TextSpan(
              //           text: "100",
              //          style: TextStyle(
              //           color: cl2F7DC1,
              //           fontSize: 35,
              //           fontFamily: 'PoppinsMedium',
              //           fontWeight: FontWeight.w700,
              //           letterSpacing: 0.70,
              //         ),
              //       ),
              //     ]
              //   )
              //   // textAlign: TextAlign.center,
              //   // style: TextStyle(
              //   //   color: Color(0xFF2F7DC1),
              //   //   fontSize: 35,
              //   //   fontFamily: 'PoppinsMedium',
              //   //   fontWeight: FontWeight.w700,
              //   //   letterSpacing: 0.70,
              //   // ),
              // ),

              ///Just height sized box
              const SizedBox(height: 5,),

              ///You have to pay the... text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child:  Text(
                  "Kindly pay PRC amount to become an active member",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: cl757575,
                    fontSize: 14,
                    fontFamily: 'PoppinsRegular',
                    fontWeight: FontWeight.w400,
                    // height: 0.11,
                  ),
                ),
              ),

              ///Just height sized box
              const SizedBox(height: 20),

              ///contribute button
              Consumer<UserProvider>(
                builder: (context2,value2,child) {
                  return InkWell(
                    onTap: (){

                      if(value2.prcDistributionsList.isNotEmpty){
                        String txnID=DateTime.now().millisecondsSinceEpoch.toString() + generateRandomString(2);
                        value2.gstCalc(double.parse(
                            value2.prcDistributionsList[0].amount));
                        value2.gatewayShowFun();
                        callNext(
                            PRCPaymentScreen(amount: value2.prcDistributionsList[0].amount,
                                fromId: value2.prcDistributionsList[0].fromId, distributionId: value2.prcDistributionsList[0].distributionId,
                                userName:userName, phoneNumber:phoneNumber, txnID: txnID,),
                            context);
                        value2.attemptPrc(context, txnID,value2.prcDistributionsList[0].amount,
                            value2.prcDistributionsList[0].fromId, value2.prcDistributionsList[0].distributionId);
                        print("contribute Name :$userName");
                        print("contribute Phone :$phoneNumber");
                      }
                    },
                    borderRadius: BorderRadius.circular(62),
                    child: Container(
                      alignment: Alignment.center,
                      width: width*.80,
                      height: 52,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: clFF731D,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(62),
                        ),
                      ),
                      child: const Text(
                        'Contribute',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: clFFFCF8,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }
              ),

              const SizedBox(height: 55,),

              const Text(
                'My Details',
                style: TextStyle(
                  color: cl252525,
                  fontSize: 20,
                  fontFamily: 'PoppinsRegular',
                  fontWeight: FontWeight.w600,
                  height: 0,
                  letterSpacing: 0.40,
                ),
              ),

              const SizedBox(height: 15,),

              Center(
                child: Container(
                  width: width*.90,
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEBEBEB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child:   Text(
                    userName,
                    maxLines: 1,
                    style: const TextStyle(
                      color: cl252525,
                      fontSize: 16,
                      fontFamily: 'PoppinsRegular',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),

              //phone number
              Center(
                child: Container(
                  width: width*.90,
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEBEBEB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child:   Text(
                    phoneNumber,
                    maxLines: 1,
                    style: TextStyle(
                      color: cl252525,
                      fontSize: 16,
                      fontFamily: 'PoppinsRegular',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),

              //email
              Center(
                child: Container(
                  width: width*.90,
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEBEBEB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child:   Text(
                    email,
                    maxLines: 1,
                    style: TextStyle(
                      color: cl252525,
                      fontSize: 16,
                      fontFamily: 'PoppinsRegular',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),

              //upid
              Center(
                child: Container(
                  width: width*.90,
                  // height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEBEBEB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child:   Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "UPI ID :",
                        style: TextStyle(
                          color: cl252525,
                          fontSize: 16,
                          fontFamily: 'PoppinsRegular',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      SizedBox(
                        width: width*.65,
                        child: Text(
                          " $upiId",
                          maxLines: 2,
                          style: const TextStyle(
                            color: cl252525,
                            fontSize: 16,
                            fontFamily: 'PoppinsRegular',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Referral
              Center(
                child: Container(
                  width: width*.90,
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEBEBEB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child:   Text(
                    "Referral :  $referral",
                    maxLines: 1,
                    style: const TextStyle(
                      color: cl252525,
                      fontSize: 16,
                      fontFamily: 'PoppinsRegular',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),


      ),
    );
  }
}
String generateRandomString(int length) {
  final random = Random();
  const availableChars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  final randomString = List.generate(length,
          (index) => availableChars[random.nextInt(availableChars.length)])
      .join();
  return randomString;
}