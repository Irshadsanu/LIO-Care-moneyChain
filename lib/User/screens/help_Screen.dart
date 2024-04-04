import 'package:flutter/material.dart';
import 'package:lio_care/User/screens/payment_processing_screen.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:provider/provider.dart';
import '../../Provider/donation_provider.dart';
import '../../Provider/user_provider.dart';
import '../../constants/my_colors.dart';

class PMCPaymentScreen extends StatelessWidget {
  final String name;
  final String amount;
  final String grade;
  final String tree;
  final String fromId;
  final String distributionId;
  final String userName;
  final String phoneNumber;
  final String txnID;
  final int installment;

  const PMCPaymentScreen(
      {Key? key,
      required this.name,
      required this.amount,
      required this.grade,
      required this.tree,
      required this.fromId,
      required this.distributionId,
      required this.userName,
      required this.phoneNumber,
      required this.installment,
      required this.txnID,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> reportsText = [
      "G Pay",
      "Paytm",
      "BHIM",
    ];
    List<String> images = [
      "assets/gpayasset.png",
      "assets/paytm.png",
      "assets/bharat-interface.png",
    ];

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgrnd,
      appBar: AppBar(
        backgroundColor: backgrnd,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              finish(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: textColor,
            )),
        centerTitle: true,
        title: Text(
          "$name Payment",
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 20, color: textColor),
        ),
      ),
      body: Consumer<UserProvider>(builder: (context9, value, child) {
        return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Container(
                      // height: height / 6.6,
                      width: MediaQuery.of(context).size.width / 1.1,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage("assets/bgContainer.png"),
                              fit: BoxFit.cover),
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          gradient: LinearGradient(
                            colors: [
                              textColor,
                              cl2FC1BC,

                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              child: Text(
                            name,
                            style: TextStyle(
                                color: clFF731D,
                                fontSize: 31,
                                fontWeight: FontWeight.w700),
                          )),
                          SizedBox(
                              child: Column(
                            children: [
                              // const Text(
                              //   "Registration Fees",
                              //   style: TextStyle(
                              //       color: Colors.white,
                              //       fontSize: 12,
                              //       fontWeight: FontWeight.w400),
                              // ),
                              Text(
                                "₹ $amount",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Divider(
                                color: Colors.white24,
                                thickness: 1,
                                indent: 30,
                                endIndent: 30,
                              )
                            ],
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (name=="PMC") Container(
                      // height: height / 4.5,
                      width: MediaQuery.of(context).size.width / 1.1,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8, left: 20),
                            child: Text(
                              "PMC Details",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                          const Divider(
                            color: Color(0xff2F95BF),
                            thickness: 1,
                          ),
                          // const SizedBox(height: 10),
                           Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                const Text(
                                  "PMC           ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 23,
                                ),
                                const Text(
                                  ":",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                const Spacer(),
                                Text(
                                  "₹${value.amount.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                const SizedBox(width: 30)
                              ],
                            ),
                          ),
                           Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                const Text(
                                  "SGST(9%) ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                const Text(
                                  ":",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                const Spacer(),
                                Text(
                                  "₹${value.gst.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                const SizedBox(width: 30)
                              ],
                            ),
                          ),
                           Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                const Text(
                                  "CGST(9%) ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                const Text(
                                  ":",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                const Spacer(),
                                Text(
                                  "₹${value.gst.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                const SizedBox(width: 30)
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            height: 0.0001,
                            color: Color(0XFF2F95BF),
                            thickness: 1,
                          ),
                          Container(
                            height: 35,
                            color: const Color(0xffE5F9FF),
                            child:   Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),

                                  Row(
                                    children: [
                                      const Text(
                                        "Total ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        width: 60,
                                      ),
                                      const Text(
                                        ":",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "₹$amount",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(width: 30)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ) else const SizedBox()
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
              child: Text(
                "Payment Method",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ),
            Consumer<DonationProvider>(builder: (context5, value3, child)  {
                return SizedBox(
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    InkWell(
                      onTap: (){
                        if(!value.gatewayHider){
                          print("fffffffff  $txnID");
                          callNext(const PaymentProcessing(), context);
                          String payAmount = amount;
                          // String payAmount = "1";
                          value.gatewayHideFun();
                          value3.upiIntent(context, payAmount, name, phoneNumber, "GPay", value.appBuildVersion.toString(),
                              grade, fromId, tree, distributionId, userName,installment,txnID);
                        }


                      },
                      child: Container(
                        height: height / 16,
                        width: MediaQuery.of(context).size.width / 1.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade200,
                                radius: 23,
                                backgroundImage: const AssetImage(
                                  "assets/gpayasset.png",
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "GPay",
                                style: TextStyle(
                                  color: Color(0xFF252525),
                                  fontSize: 13,
                                  fontFamily: 'PoppinsRegular',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 7,),

                    InkWell(
                      onTap: (){
                        if(!value.gatewayHider){
      String payAmount = amount;

      value3.upiIntent(
          context,
          payAmount,
          name,
          phoneNumber,
          "BHIM",
          value.appBuildVersion.toString(),

          grade,
          fromId,
          tree,
          distributionId,
          userName,installment,txnID);

    }
                      },
                      child: Container(
                        height: height / 16,
                        width: MediaQuery.of(context).size.width / 1.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade200,
                                radius: 23,
                                child: const CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                    "assets/bharat-interface.png",
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20,),
                              child: Image.asset("assets/bhimtext.png",scale: 4,),
                            )
                          ],
                        ),
                      ),
                    ),


                  ],),
                );
              }
            ),
          ],
        );
      }),
    );
  }
}
