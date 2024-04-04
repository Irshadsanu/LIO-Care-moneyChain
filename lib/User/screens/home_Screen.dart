import 'dart:async';

// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:lio_care/User/screens/confirmation_screen.dart';
import 'package:lio_care/User/screens/payment_screen.dart';
import 'package:lio_care/User/screens/lastTransactions_screen.dart';
import 'package:lio_care/User/screens/pmc_distribtions.dart';
import 'package:lio_care/User/screens/ptcf_distributions.dart';
import 'package:lio_care/User/screens/user_income_screen.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:lio_care/help_tree/tree_provider.dart';
import 'package:lio_care/models/distributionModel.dart';
import 'package:lio_care/models/lastTrasactionModel.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../admin/screens/admin_login_fixed_screen.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_texts.dart';
import 'DistributionSeeMore_Screen.dart';
import 'approveImageScreen.dart';
import 'help_Screen.dart';
import 'invitesScreen.dart';
import 'make_dynamic_Link_Screen.dart';
import 'messageSendRecieve.dart';
import 'message_screen.dart';
import 'myInvitationsScreen.dart';
import 'myTasks_Screen.dart';
import 'my_referrals.dart';
import 'newDistribution_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'new_pmc_screen.dart';
import 'new_ptcf_screen.dart';
import 'notification_Screen.dart';

class CircleBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final gradient = SweepGradient(
      colors: [
        cWhite, // Light color at the start
        clFF731D, // Darker color at the end
      ],
    );

    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawCircle(center, radius - 4.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

///

class HomeScreen extends StatelessWidget {
  String userID;

  HomeScreen({Key? key, required this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userIdcijsejjD='';

    final FirebaseFirestore db = FirebaseFirestore.instance;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bck,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: bck,
        title: Image.asset(
          "assets/bluelogo.png",
          scale: 18,
        ),
        actions: [
          Consumer<TreeProvider>(builder: (context1, value3, child) {
            return InkWell(
                onTap: () {
                  alertSupport(context);
                },
                child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(2.6),
                    width: 75,
                    height: 32,
                    decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(colors: [
                          cl4389C5,
                          cl22A2B1,
                        ])),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.support_agent, color: cl22A2B1),
                          Text(
                            "Support",
                            style: TextStyle(
                                color: cl22A2B1,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          )
                        ],
                      ),
                    )));
          }),
          const SizedBox(
            width: 8,
          ),
          Consumer<UserProvider>(builder: (context1, value3, child) {
            return InkWell(
                onTap: () {
                  // callNext( MessageScreen(memberId: value3.registerID), context);
                  value3.addMessageViewers(value3.registerID);
                  // value3.getMessages(value3.registerID);
                  value3.getSendedMessage(value3.registerID);
                  callNext(
                      MessageSendRecieve(
                          memberID: value3.registerID,
                          registerDocID: value3.registerDocID,
                          userName: value3.userName),
                      context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/message1.png",
                        scale: 3,
                      ),
                      value3.youHaveMessage
                          ? Positioned(
                              right: 0,
                              child: Icon(
                                Icons.circle,
                                color: clFF731D,
                                size: 14,
                              ))
                          : const SizedBox()
                    ],
                  ),
                ));
          }),
          const SizedBox(
            width: 8,
          ),
          Consumer<UserProvider>(builder: (context2, value2, child) {
            return InkWell(
              onTap: () {
                // value2.fetchNotification(
                //   value2.registerID,
                //   true,
                // );
                value2.addNotToViewers(
                  value2.registerID,
                );
                callNext(const NotificationScreen(), context);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/notification.png",
                      scale: 3,
                    ),
                    value2.haveNotification
                        ? Positioned(
                            right: 0,
                            child: Icon(
                              Icons.circle,
                              color: clFF731D,
                              size: 14,
                            ))
                        : const SizedBox()
                  ],
                ),
              ),
            );
          }),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Consumer<UserProvider>(builder: (context, va, _) {
                return Container(
                  width: width,
                  // height: 180,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF000000).withOpacity(0.1),
                        // 0x1C in hexadecimal is equal to 0.1 in opacity
                        offset: const Offset(0, 9),
                        blurRadius: 11,
                      ),
                    ],
                    gradient: const LinearGradient(
                      colors: [
                        cl2F7DC1,
                        cl2FC1BC,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            va.userProfileImage != ""
                                ? Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: va.userGrade=="VIOLET"?VIOLET
                                    :va.userGrade=="INDIGO"?INDIGO
                                    :va.userGrade=="BLUE"?BLUE
                                    :va.userGrade=="GREEN"?GREEN
                                    :va.userGrade=="YELLOW"?YELLOW
                                    :va.userGrade=="ORANGE"?ORANGE
                                    :va.userGrade=="RED"?RED
                                    :va.userGrade=="MASTER ACHIEVER"?MASTERACHIEVER:Colors.grey,width: 3),
                                image: DecorationImage(
                                    image:
                                    NetworkImage(va.userProfileImage),
                                    fit: BoxFit.fill),
                              ),
                            )
                                : Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: va.userGrade=="VIOLET"?VIOLET
                                      :va.userGrade=="INDIGO"?INDIGO
                                      :va.userGrade=="BLUE"?BLUE
                                      :va.userGrade=="GREEN"?GREEN
                                      :va.userGrade=="YELLOW"?YELLOW
                                      :va.userGrade=="ORANGE"?ORANGE
                                      :va.userGrade=="RED"?RED
                                      :va.userGrade=="MASTER ACHIEVER"?MASTERACHIEVER:Colors.grey,width: 4),
                                  image: const DecorationImage(
                                    image:
                                    AssetImage("assets/profile2.png"),
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                              width: width/1.45,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width/1.4,
                                    child: Column(
                                      children: [
                                        Text(
                                          va.userName,
                                          style: const TextStyle(
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,overflow: TextOverflow.ellipsis,),
                                          maxLines: 2,
                                          textAlign: TextAlign.center,

                                        ),
                                        Text(
                                          va.userPhone,
                                          style: const TextStyle(
                                              fontFamily: 'PoppinsRegular',
                                              fontSize: 12,
                                              // height: .02,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFFE8E8E8)),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // SizedBox(
                                  //   width: width/3,
                                  //   child: va.userGrade.isNotEmpty
                                  //       ?Column(
                                  //     mainAxisAlignment: MainAxisAlignment.center,
                                  //     children: [
                                  //       Text(
                                  //         va.userGrade,
                                  //         style: const TextStyle(
                                  //             fontFamily: 'PoppinsRegular',
                                  //             fontSize: 16,
                                  //             fontWeight: FontWeight.w800,
                                  //             color: Colors.white),
                                  //       ),
                                  //       va.userAutoOneGrade.isNotEmpty
                                  //           ?Text(
                                  //         va.userAutoOneGrade,
                                  //         style: const TextStyle(
                                  //             fontFamily: 'PoppinsRegular',
                                  //             fontSize: 12,
                                  //             // height: .02,
                                  //             fontWeight: FontWeight.w600,
                                  //             color: Color(0xFFE8E8E8)),
                                  //       ):const SizedBox(),
                                  //       va.userAutoTwoGrade.isNotEmpty
                                  //           ?Text(
                                  //         va.userAutoTwoGrade,
                                  //         style: const TextStyle(
                                  //             fontFamily: 'PoppinsRegular',
                                  //             fontSize: 12,
                                  //             // height: .02,
                                  //             fontWeight: FontWeight.w600,
                                  //             color: Color(0xFFE8E8E8)),
                                  //       ):const SizedBox(),
                                  //     ],
                                  //   )
                                  //       :const SizedBox(),
                                  // ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          callNext(
                                              MyTasksScreen(
                                                userID: userID,
                                              ),
                                              context);
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 107,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: cWhite),
                                              color: clFFFCF8,
                                              borderRadius:
                                              BorderRadius.circular(26)),
                                          child: const Center(
                                            child: Text(
                                              "My Tasks",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                  fontFamily: "PoppinsRegular",
                                                  color: cl2F7DC1),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Consumer<UserProvider>(
                                          builder: (context4, val3, child) {
                                            return InkWell(
                                              onTap: () async {
                                                String generatedDeepLink =
                                                await FirebaseDynamicLinkService
                                                    .createDynamicLink(
                                                    true, val3.userPhone);
                                                Share.share(
                                                    '${"Lio club"}:\nDownload Lio club to read more and be updated $generatedDeepLink \nID: ${val3.userPhone}',
                                                    subject: 'Look what I made!');
                                              },
                                              child: Container(
                                                height: 25,
                                                width: 107,
                                                decoration: BoxDecoration(
                                                    color: clFF731D,
                                                    borderRadius:
                                                    BorderRadius.circular(26)),
                                                child: const Center(
                                                  child: Text(
                                                    "Invite Member",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                        height: 0,
                                                        fontFamily: "PoppinsRegular",
                                                        color: cWhite),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     va.userProfileImage != ""
                        //         ? Container(
                        //             height: 70,
                        //             width: 70,
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(18),
                        //               image: DecorationImage(
                        //                   image:
                        //                       NetworkImage(va.userProfileImage),
                        //                   fit: BoxFit.fill),
                        //             ),
                        //           )
                        //         : Container(
                        //             height: 70,
                        //             width: 70,
                        //             decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(18),
                        //                 image: const DecorationImage(
                        //                   image:
                        //                       AssetImage("assets/profile2.png"),
                        //                   fit: BoxFit.fill,
                        //                 )),
                        //           ),
                        //     const SizedBox(
                        //       width: 8,
                        //     ),
                        //     Column(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           va.userName,
                        //           style: const TextStyle(
                        //               fontFamily: 'PoppinsRegular',
                        //               fontSize: 16,
                        //               fontWeight: FontWeight.w800,
                        //               color: Colors.white),
                        //         ),
                        //         Text(
                        //           va.userPhone,
                        //           style: const TextStyle(
                        //               fontFamily: 'PoppinsRegular',
                        //               fontSize: 12,
                        //               // height: .02,
                        //               fontWeight: FontWeight.w600,
                        //               color: Color(0xFFE8E8E8)),
                        //         ),
                        //
                        //         // SizedBox(width: 15,),
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             InkWell(
                        //               onTap: () {
                        //                 callNext(
                        //                     MyTasksScreen(
                        //                       userID: userID,
                        //                     ),
                        //                     context);
                        //               },
                        //               child: Container(
                        //                 height: 25,
                        //                 width: 107,
                        //                 decoration: BoxDecoration(
                        //                     border: Border.all(color: cWhite),
                        //                     color: clFFFCF8,
                        //                     borderRadius:
                        //                         BorderRadius.circular(26)),
                        //                 child: const Center(
                        //                   child: Text(
                        //                     "My Tasks",
                        //                     style: TextStyle(
                        //                         fontSize: 12,
                        //                         fontWeight: FontWeight.w500,
                        //                         height: 0,
                        //                         fontFamily: "PoppinsRegular",
                        //                         color: cl2F7DC1),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             const SizedBox(
                        //               width: 20,
                        //             ),
                        //             Consumer<UserProvider>(
                        //                 builder: (context4, val3, child) {
                        //               return InkWell(
                        //                 onTap: () async {
                        //                   String generatedDeepLink =
                        //                       await FirebaseDynamicLinkService
                        //                           .createDynamicLink(
                        //                               true, val3.userPhone);
                        //                   Share.share(
                        //                       '${"Lio club"}:\nDownload Lio club to read more and be updated $generatedDeepLink \nID: ${val3.userPhone}',
                        //                       subject: 'Look what I made!');
                        //                 },
                        //                 child: Container(
                        //                   height: 25,
                        //                   width: 107,
                        //                   decoration: BoxDecoration(
                        //                       color: clFF731D,
                        //                       borderRadius:
                        //                           BorderRadius.circular(26)),
                        //                   child: const Center(
                        //                     child: Text(
                        //                       "Invite Member",
                        //                       style: TextStyle(
                        //                           fontSize: 12,
                        //                           fontWeight: FontWeight.w500,
                        //                           height: 0,
                        //                           fontFamily: "PoppinsRegular",
                        //                           color: cWhite),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               );
                        //             }),
                        //           ],
                        //         ),
                        //       ],
                        //     )
                        //   ],
                        // ),
                        const SizedBox(height: 5,),
                        Container(
                          width: width,
                          // height: 76,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19),
                            gradient: LinearGradient(
                              colors: [
                                cl2FC1BC.withOpacity(.2),
                                cl2F7DC1.withOpacity(.2),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Total Help Received",
                                        style: TextStyle(
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 10.12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFE8E8E8)),
                                      ),
                                      Text(
                                        "₹ ${va.userTotalEarnings}",
                                        style: const TextStyle(
                                            // fontFamily: 'PoppinsRegular',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Referred By",
                                        style: TextStyle(
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 10.12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFE8E8E8)),
                                      ),
                                      Text(
                                        va.userReferredBy,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 12,
                                            // height: .02,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Total Give Help",
                                        style: TextStyle(
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 10.12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFE8E8E8)),
                                      ),
                                      Text(
                                        "₹ ${va.userTotalDonation}",
                                        style: const TextStyle(
                                            // fontFamily: 'PoppinsRegular',
                                            fontSize: 12,
                                            // height: .02,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Reference Amount",
                                        style: TextStyle(
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 10.12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFE8E8E8)),
                                      ),
                                      Text(
                                        "₹ ${va.userReferenceAmount}",
                                        style: const TextStyle(
                                            // fontFamily: 'PoppinsRegular',
                                            fontSize: 12,
                                            // height: .02,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                      ]),
                );
              }),
              const SizedBox(height: 15),
              InkWell(
                onTap: () async {
                  UserProvider userProvider =
                      Provider.of<UserProvider>(context, listen: false);
                  // await userProvider.fetchLastTransactionList(true);
                  callNext(const LastTransactionsScreen(), context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  // height: 120,
                  //height / 6
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
                    // Row(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           const SizedBox(width: 15),
                    //           CustomPaint(
                    //             painter: CircleBorderPainter(),
                    //             child: Container(
                    //               margin: const EdgeInsets.all(2),
                    //               width: 60,
                    //               height: 60,
                    //               decoration: const BoxDecoration(
                    //                 color: cWhite,
                    //                 shape: BoxShape.circle,
                    //               ),
                    //               child: LastTransactionProfile(list:value78.lastTransactionList ),
                    //             ),
                    //           ),
                    //           const SizedBox(width: 30),
                    //           Container(
                    //             alignment: Alignment.center,
                    //             // height: 97,
                    //             width: width / 2,
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceAround,
                    //               children: [
                    //                 const Text(
                    //                   "Last Transactions",
                    //                   textAlign: TextAlign.center,
                    //                   style: TextStyle(
                    //                     color: cl252525,
                    //                     fontSize: 14,
                    //                     fontFamily: 'PoppinsRegular',
                    //                     fontWeight: FontWeight.w400,
                    //                   ),
                    //                 ),
                    //                 // Text(
                    //                 //   value78.lastTransactionList[0].topperName,
                    //                 //   textAlign: TextAlign.center,
                    //                 //   maxLines: 2,
                    //                 //   style: const TextStyle(
                    //                 //     color: cl252525,
                    //                 //     fontSize: 18,
                    //                 //     fontFamily: 'PoppinsRegular',
                    //                 //     height: 1,
                    //                 //     fontWeight: FontWeight.w600,
                    //                 //   ),
                    //                 // ),
                    //                 SizedBox(
                    //                   height: 30,
                    //                   width: width / 2,
                    //                   child: AnimatedTextKit(
                    //                     animatedTexts: [
                    //                       for (var text in value78.lastTransactionList)
                    //                         RotateAnimatedText(duration:const Duration(seconds: 5),
                    //                           text.topperName,
                    //                           textStyle: const TextStyle(
                    //                             overflow: TextOverflow.ellipsis,
                    //                             color: cl252525,
                    //                             fontSize: 18,
                    //                             fontFamily: 'PoppinsRegular',
                    //                             height: 1,
                    //                             fontWeight: FontWeight.w600,
                    //                           ),
                    //                         ),
                    //                     ],
                    //                     isRepeatingAnimation: true,
                    //                     // totalRepeatCount: 10,
                    //                     pause: const Duration(seconds: 0),
                    //                   ),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 30,
                    //                   child: AnimatedTextKit(
                    //                     animatedTexts: [
                    //                       for (var text in value78
                    //                           .lastTransactionList)
                    //                         RotateAnimatedText(duration:const Duration(seconds: 5),
                    //                           "₹"+text.topperAmount,
                    //                           textStyle: const TextStyle(
                    //                             color: Color(0xFFFF731D),
                    //                             fontSize: 21,
                    //                             // fontFamily:
                    //                             //     'PoppinsRegular',
                    //                             height: 1,
                    //                             fontWeight: FontWeight.w600,
                    //                           ),
                    //                         ),
                    //                     ],
                    //                     isRepeatingAnimation: true,
                    //                     // totalRepeatCount: 10,
                    //                     pause: const Duration(seconds: 0),
                    //                   ),
                    //                 ),
                    //
                    //                 // RichText(
                    //                 //   text: TextSpan(children: [
                    //                 //     TextSpan(
                    //                 //       text: "₹",
                    //                 //       style: TextStyle(
                    //                 //           fontWeight: FontWeight.w600,
                    //                 //           color: clFF731D,
                    //                 //           fontSize: 21),
                    //                 //     ),
                    //                 //     TextSpan(
                    //                 //       text: value78.lastTransactionList[0]
                    //                 //           .topperAmount,
                    //                 //       style: const TextStyle(
                    //                 //         color: Color(0xFFFF731D),
                    //                 //         fontSize: 21,
                    //                 //         fontFamily: 'PoppinsRegular',
                    //                 //         height: 1,
                    //                 //         fontWeight: FontWeight.w600,
                    //                 //       ),
                    //                 //     ),
                    //                 //   ]),
                    //                 // ),
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       )
                        : const SizedBox();
                  }),
                ),
              ),

              // Container(
              //   padding: const EdgeInsets.all(10),
              //   width: width,
              //   decoration: BoxDecoration(
              //     image: const DecorationImage(
              //       image: AssetImage(
              //         "assets/backgroundimage.png",
              //       ),
              //       fit: BoxFit.fill,
              //     ),
              //     borderRadius: BorderRadius.circular(20),
              //     gradient: const LinearGradient(
              //       colors: [
              //         cl2F7DC1,
              //         cl2FC1BC,
              //       ],
              //       begin: Alignment.topLeft,
              //       end: Alignment.bottomRight,
              //     ),
              //   ),
              //   child: Column(
              //     children: [
              //       Consumer<UserProvider>(builder: (context3, value2, child) {
              //         return Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Expanded(
              //               flex: 1,
              //               child: SizedBox(
              //                 child: Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       const Text(
              //                         'Total Help Received',
              //                         style: TextStyle(
              //                           color: cWhite,
              //                           fontSize: 14,
              //                           height: 1,
              //                           fontFamily: 'PoppinsRegular',
              //                           fontWeight: FontWeight.w400,
              //                         ),
              //                       ),
              //                       const SizedBox(
              //                         height: 10,
              //                       ),
              //                       Text(
              //                         "₹ ${value2.userTotalEarnings}",
              //                         textAlign: TextAlign.start,
              //                         style: TextStyle(
              //                           color: clFF731D,
              //                           height: 1,
              //                           fontWeight: FontWeight.bold,
              //                           fontFamily: "PoppinsMedium",
              //                           fontSize: 22,
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             const SizedBox(width: 10),
              //             Expanded(
              //               flex: 1,
              //               child: SizedBox(
              //                 child: Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Column(
              //                     //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                     crossAxisAlignment: CrossAxisAlignment.end,
              //                     children: [
              //                       const Text(
              //                         'Total give help',
              //                         textAlign: TextAlign.center,
              //                         style: TextStyle(
              //                           color: cWhite,
              //                           fontSize: 14,
              //                           height: 1,
              //                           fontFamily: 'PoppinsRegular',
              //                           fontWeight: FontWeight.w400,
              //                         ),
              //                       ),
              //                       const SizedBox(
              //                         height: 10,
              //                       ),
              //                       Text(
              //                         "₹ ${value2.userTotalDonation}",
              //                         style: const TextStyle(
              //                             color: cWhite,
              //                             fontWeight: FontWeight.bold,
              //                             height: 1,
              //                             fontFamily: "PoppinsMedium",
              //                             fontSize: 22),
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             )
              //           ],
              //         );
              //       }),
              //       Consumer<UserProvider>(builder: (context, user, child) {
              //         return Stack(
              //           children: [
              //             Column(
              //               children: [
              //                 const SizedBox(
              //                   height: 5,
              //                 ),
              //                 Row(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     InkWell(
              //                       onTap: () {
              //                         callNext(
              //                             MyTasksScreen(
              //                               userID: userID,
              //                             ),
              //                             context);
              //                       },
              //                       child: Container(
              //                         height: 25,
              //                         width: 107,
              //                         decoration: BoxDecoration(
              //                             border: Border.all(color: cWhite),
              //                             color: clFFFCF8,
              //                             borderRadius:
              //                                 BorderRadius.circular(26)),
              //                         child: const Center(
              //                           child: Text(
              //                             "My Tasks",
              //                             style: TextStyle(
              //                                 fontSize: 12,
              //                                 fontWeight: FontWeight.w500,
              //                                 height: 0,
              //                                 fontFamily: "PoppinsRegular",
              //                                 color: cl2F7DC1),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                     const SizedBox(
              //                       width: 20,
              //                     ),
              //                     Consumer<UserProvider>(
              //                         builder: (context4, val3, child) {
              //                       return InkWell(
              //                         onTap: () async {
              //                           String generatedDeepLink =
              //                               await FirebaseDynamicLinkService
              //                                   .createDynamicLink(
              //                                       true, val3.userPhone);
              //                           Share.share(
              //                               '${"Lio club"}:\nDownload Lio club to read more and be updated $generatedDeepLink \nID: ${val3.userPhone}',
              //                               subject: 'Look what I made!');
              //                         },
              //                         child: Container(
              //                           height: 25,
              //                           width: 107,
              //                           decoration: BoxDecoration(
              //                               color: clFF731D,
              //                               borderRadius:
              //                                   BorderRadius.circular(26)),
              //                           child: const Center(
              //                             child: Text(
              //                               "Invite Member",
              //                               style: TextStyle(
              //                                   fontSize: 12,
              //                                   fontWeight: FontWeight.w500,
              //                                   height: 0,
              //                                   fontFamily: "PoppinsRegular",
              //                                   color: cWhite),
              //                             ),
              //                           ),
              //                         ),
              //                       );
              //                     }),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //             user.taskIndicator
              //                 ? Positioned(
              //                     left: width * 0.39,
              //                     top: 0,
              //                     child: Icon(
              //                       Icons.circle,
              //                       color: clFF731D,
              //                       size: 14,
              //                     ))
              //                 : const SizedBox()
              //           ],
              //         );
              //       }),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 15),
              // InkWell(
              //   onTap: () async {
              //     UserProvider userProvider =
              //         Provider.of<UserProvider>(context, listen: false);
              //     // await userProvider.fetchLastTransactionList(true);
              //     callNext(const LastTransactionsScreen(), context);
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(vertical: 10),
              //     alignment: Alignment.center,
              //     height: 120,
              //     //height / 6
              //     decoration: BoxDecoration(
              //       color: myWhite, //myWhite
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey.shade500,
              //           offset: const Offset(
              //             0.2,
              //             0.2,
              //           ),
              //           blurRadius: 0.2,
              //           spreadRadius: 0.2,
              //         ),
              //       ],
              //       image: const DecorationImage(
              //           image: AssetImage("assets/Vector 2.png"),
              //           fit: BoxFit.cover,
              //           alignment: Alignment.topRight),
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     child: Consumer<UserProvider>(
              //         builder: (context5, value78, child) {
              //       return value78.lastTransactionHomeName != ""
              //           ? Row(
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 const SizedBox(width: 15),
              //                 CustomPaint(
              //                   painter: CircleBorderPainter(),
              //                   child: Container(
              //                     margin: const EdgeInsets.all(2.5),
              //                     width: 70,
              //                     height: 70,
              //                     decoration: const BoxDecoration(
              //                       color: cWhite,
              //                       shape: BoxShape.circle,
              //                     ),
              //                     child: Container(
              //                       margin: const EdgeInsets.all(3.2),
              //                       width: 68,
              //                       height: 68,
              //                       decoration: BoxDecoration(
              //                           color: cWhite,
              //                           shape: BoxShape.circle,
              //                           image: value78.lastTransactionList[0]
              //                                       .topperImage !=
              //                                   ""
              //                               ? DecorationImage(
              //                                   image: NetworkImage(value78
              //                                       .lastTransactionList[0]
              //                                       .topperImage),
              //                                   fit: BoxFit.cover,
              //                                 )
              //                               : const DecorationImage(
              //                                   image: AssetImage(
              //                                       "assets/profile2.png"),
              //                                   fit: BoxFit.cover,
              //                                 )),
              //                     ),
              //                   ),
              //                 ),
              //                 const SizedBox(width: 30),
              //                 Container(
              //                   alignment: Alignment.centerLeft,
              //                   // height: 97,
              //                   width: width / 2,
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceAround,
              //                     children: [
              //                       const Text(
              //                         "Last Transaction",
              //                         textAlign: TextAlign.center,
              //                         style: TextStyle(
              //                           color: cl252525,
              //                           fontSize: 14,
              //                           fontFamily: 'PoppinsRegular',
              //                           fontWeight: FontWeight.w400,
              //                         ),
              //                       ),
              //                       Text(
              //                         value78.lastTransactionList[0].topperName,
              //                         textAlign: TextAlign.center,
              //                         maxLines: 2,
              //                         style: const TextStyle(
              //                           color: cl252525,
              //                           fontSize: 18,
              //                           fontFamily: 'PoppinsRegular',
              //                           height: 1,
              //                           fontWeight: FontWeight.w600,
              //                         ),
              //                       ),
              //                       RichText(
              //                         text: TextSpan(children: [
              //                           TextSpan(
              //                             text: "₹",
              //                             style: TextStyle(
              //                                 fontWeight: FontWeight.w600,
              //                                 color: clFF731D,
              //                                 fontSize: 21),
              //                           ),
              //                           TextSpan(
              //                             text: value78.lastTransactionList[0]
              //                                 .topperAmount,
              //                             style: const TextStyle(
              //                               color: Color(0xFFFF731D),
              //                               fontSize: 21,
              //                               fontFamily: 'PoppinsRegular',
              //                               height: 1,
              //                               fontWeight: FontWeight.w600,
              //                             ),
              //                           ),
              //                         ]),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ],
              //             )
              //           : const SizedBox();
              //     }),
              //   ),
              // ),

              Column(
                children: [
                  Consumer<UserProvider>(builder: (context, userPro, _) {
                    return userPro.companyDistributionsList.isNotEmpty ||
                            userPro.homeDistributionList.isNotEmpty
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Consumer<UserProvider>(
                                        builder: (context7, value3, child) {
                                      return const Text(
                                        "Distributions",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "PoppinsRegular"),
                                      );
                                    }),
                                    Consumer<UserProvider>(
                                        builder: (context, user, child) {
                                      return InkWell(
                                          onTap: () {
                                            // user.bottomSelectedIndex.value = 1;
                                            user.clearBooleans();
                                            user.masterClubDistributionFiltering(
                                                '', '', '');
                                            user.crownClubDistributionFiltering(
                                                '', '', '');
                                            user.starClubDistributionFiltering(
                                                '', '', '');
                                            callNext(
                                                DistributionSeeMoreScreen(
                                                    loginId: userID),
                                                context);
                                          },
                                          child: const SizedBox(
                                            height: 20,
                                            width: 70,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "See more",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ));
                                    })
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width / 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        callNext(const NewPmcScreen(), context);
                                      },
                                      child: Container(
                                        width: width * .41,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: textColor.withOpacity(0.8),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            border: Border.all(
                                                color:
                                                    const Color(0xFFE9F2FF))),
                                        child: Consumer<UserProvider>(
                                            builder: (context5, value5, child) {
                                          return Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("PMC",
                                                      style: pmcPtcfBox),
                                                  Text("PAID",
                                                      style: pmcPtcfBox),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    value5.totalPmcAmount
                                                        .toStringAsFixed(0),
                                                    style: pmcPtcfBox3,
                                                  ),
                                                  Text(
                                                    value5.totalPmcPaid
                                                        .toStringAsFixed(0),
                                                    style: pmcPtcfBox3,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Container(
                                                height: 2,
                                                // width: width*.42,
                                                color: cl5F9DF7,
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Remaining",
                                                    style: pmcPtcfBox2,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                height: 2,
                                                color: clFFFCF8,
                                                width: width * .41 - 16,
                                                child: Container(
                                                  height: 2,
                                                  width: value5.totalPmcCount !=
                                                              0 &&
                                                          value5.totalPmcPaidCount !=
                                                              0
                                                      ? ((width * .41 - 16) *
                                                              ((value5.totalPmcPaidCount /
                                                                      value5
                                                                          .totalPmcCount) *
                                                                  100)) /
                                                          100
                                                      : 0,
                                                  color: clFA721F,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "${value5.totalPmcPaidCount}/${value5.totalPmcCount}",
                                                    style: pmcPtcfBox2,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        }),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        callNext(
                                            const NewPtcfScreen(), context);
                                      },
                                      child: Container(
                                        width: width * .41,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: textColor.withOpacity(0.8),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            border: Border.all(
                                                color:
                                                    const Color(0xFFE9F2FF))),
                                        child: Consumer<UserProvider>(
                                            builder: (context5, value5, child) {
                                          return Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "CMF",
                                                    style: pmcPtcfBox,
                                                  ),
                                                  Text(
                                                    "PAID",
                                                    style: pmcPtcfBox,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    value5.totalPtcfAmount
                                                        .toStringAsFixed(0),
                                                    style: pmcPtcfBox3,
                                                  ),
                                                  Text(
                                                    value5.totalPtcfPaid
                                                        .toStringAsFixed(0),
                                                    style: pmcPtcfBox3,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Container(
                                                height: 2,
                                                color: cl5F9DF7,
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Remaining",
                                                    style: pmcPtcfBox2,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                height: 2,
                                                color: clFFFCF8,
                                                width: width * .41 - 16,
                                                child: Container(
                                                  height: 2,
                                                  width: value5
                                                              .totalPtcfCount !=
                                                          0
                                                      ? ((width * .41 - 16) *
                                                              ((value5.totalPtcfPaidCount /
                                                                      value5
                                                                          .totalPtcfCount) *
                                                                  100)) /
                                                          100
                                                      : 0,
                                                  color: clFA721F,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "${value5.totalPtcfPaidCount}/${value5.totalPtcfCount}",
                                                    style: pmcPtcfBox2,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Consumer<UserProvider>(
                                  builder: (context, val565, child) {
                                return SizedBox(
                                  width: width,
                                  // height:val565.homeDistributionList.length==1? 100:195,
                                  child:  ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 3),
                                      itemCount:
                                      val565.homeDistributionList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        DistributionModel item =
                                        val565.homeDistributionList[index];
                                        // print("kkkkkkkkkkkkkk  " + item.upiId);
                                        return InkWell(
                                          onTap: () async {
                                            if (item.status != "PAID") {
                                              db
                                                  .collection(item.tree)
                                                  .doc(item.toDocId)
                                                  .get()
                                                  .then((toValue) async {
                                                Map<dynamic, dynamic> toMap =
                                                toValue.data() as Map;
                                                // print("from grade : ${item.fromGrade}, to grade : ${toMap["GRADE"]??""}, to status ${toMap["STATUS"]??""}");
                                                if (item.screenShot == "") {
                                                  bool levelCheck = await val565
                                                      .checkLevelStatus(
                                                      item.fromGrade,
                                                      toMap["GRADE"] ?? "",
                                                      toMap["STATUS"] ?? "",
                                                      item.toId,
                                                      toMap["TYPE"] ?? "",
                                                      context);
                                                  if (levelCheck) {
                                                    if (item.type ==
                                                        "STAR_CLUB" ||
                                                        item.type ==
                                                            "CROWN_CLUB") {
                                                      bool checkKycOrCount =
                                                      await val565
                                                          .checkKycStatusAndChild(
                                                          val565
                                                              .kycStatus,
                                                          item.fromGrade,item.type,
                                                          context);
                                                      if (!checkKycOrCount) {
                                                        val565
                                                            .kycChildCountAlert(
                                                            context,
                                                            item.phoneNumber,
                                                            item.type);
                                                      }
                                                      else {
                                                        print("sfd");
                                                        String entryCheckVariable = item.type=="STAR_CLUB"
                                                            ?val565.starClubEnter:val565.crownClubEnter;
                                                        String club = item.type=="STAR_CLUB"
                                                            ?"Star club":"Crown club";
                                                        print("entryCheckVariable : $entryCheckVariable");
                                                        if(entryCheckVariable!="SUCCESS") {

                                                          showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return AlertDialog(
                                                                backgroundColor: clF8FAFF,
                                                                scrollable: true,
                                                                title: Text(
                                                                  "You meet the eligibility criteria for the $club membership. Would you like to proceed with enrollment?",
                                                                  style: const TextStyle(
                                                                      fontFamily: 'BarlowCondensed',
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 16),
                                                                ),
                                                                content: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap: () {
                                                                        finish(context);
                                                                      },
                                                                      child: Container(
                                                                        height: 45,
                                                                        width: 100,
                                                                        decoration: BoxDecoration(
                                                                            color: clFF731D,
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                        child: const Center(
                                                                          child: Text(
                                                                            "Not Now",
                                                                            style: TextStyle(
                                                                                color: clF8FAFF,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: 'BarlowCondensed',
                                                                                fontSize: 15),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    !val565.waitingBool
                                                                        ? InkWell(
                                                                      onTap: () {
                                                                        if(!val565.waitingBool){
                                                                          val565.waitingBool=true;
                                                                          val565.notifyListeners();
                                                                          print("selected count");
                                                                          if(item.type=="STAR_CLUB"){
                                                                            val565.placeInStarClub(item.fromId,item.tree,val565.registerDocID,
                                                                                item.distributionId,val565.userName,val565.userPhone,val565.userProfileImage,context);
                                                                          }else{
                                                                            val565.placeInCrownClub(item.fromId,item.tree,val565.registerDocID,
                                                                                item.distributionId,val565.userName,val565.userPhone,val565.userProfileImage,context);
                                                                          }
                                                                        }
                                                                      },
                                                                      child: Container(
                                                                        height: 45,
                                                                        width: 100,
                                                                        decoration: BoxDecoration(
                                                                            color: clFF731D,
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                        child: const Center(
                                                                          child: Text(
                                                                            "Continue",
                                                                            style: TextStyle(
                                                                                color: clF8FAFF,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: 'BarlowCondensed',
                                                                                fontSize: 15),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ):Container(
                                                                        decoration: BoxDecoration(
                                                                            color: clFF731D,
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(4.0),
                                                                          child: CircularProgressIndicator(color: Colors.white,),
                                                                        )
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          );


                                                          // val565.warningAlert(context, "eligible to star club");
                                                        } else{
                                                          print("entry print");
                                                          val565.upiCopyBool = false;
                                                          callNext(
                                                              PaymentScreen(
                                                                userUpgradeId: item
                                                                    .toId,
                                                                userUpgradeName:
                                                                item.name,
                                                                userUpgradeNumber:
                                                                item.phoneNumber,
                                                                userUpgradeProfileImage:
                                                                item.proImage,
                                                                userUpgradeAmount:
                                                                item.amount,
                                                                userUpgradeStatus:
                                                                item.status,
                                                                userUpgradeUpiID:
                                                                item.upiId,
                                                                userPaymentType:
                                                                item.type,
                                                                userUpgradeGrade:
                                                                item.fromGrade,
                                                                userUpgradeTree:
                                                                item.tree,
                                                                distributionId:
                                                                item.distributionId,
                                                              ),
                                                              context);
                                                        }
                                                      }
                                                    } else {
                                                      val565.upiCopyBool =
                                                      false;
                                                      callNext(
                                                          PaymentScreen(
                                                            userUpgradeId:
                                                            item.toId,
                                                            userUpgradeName:
                                                            item.name,
                                                            userUpgradeNumber:
                                                            item.phoneNumber,
                                                            userUpgradeProfileImage:
                                                            item.proImage,
                                                            userUpgradeAmount:
                                                            item.amount,
                                                            userUpgradeStatus:
                                                            item.status,
                                                            userUpgradeUpiID:
                                                            item.upiId,
                                                            userPaymentType:
                                                            item.type,
                                                            userUpgradeGrade:
                                                            item.fromGrade,
                                                            userUpgradeTree:
                                                            item.tree,
                                                            distributionId: item
                                                                .distributionId,
                                                          ),
                                                          context);
                                                    }
                                                  } else {
                                                    val565.restrictionAlert(
                                                        context, item.name);
                                                  }
                                                } else {
                                                  callNext(
                                                      ConfirmationScreen(
                                                        name: item.name,
                                                        phoneNumber:
                                                        item.phoneNumber,
                                                        date: "",
                                                        time: "",
                                                        regId: item.toId,
                                                        image: item.proImage,
                                                        screenShot:
                                                        item.screenShot,
                                                        receiptImage: null,
                                                        from: "HOME",
                                                        paymentType: item.type,
                                                        tree: item.tree,
                                                        grade: item.fromGrade,
                                                        distributionId:
                                                        item.distributionId,
                                                      ),
                                                      context);
                                                }
                                              });
                                            }
                                          },
                                          child: Container(
                                            width: width * 0.2,
                                            padding: const EdgeInsets.only(
                                              left: 3,
                                            ),
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFFFFFCF8),
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xFFECECEC)),
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              shadows: const [
                                                BoxShadow(
                                                  color: Color(0x1E7C7C7C),
                                                  blurRadius: 5,
                                                  offset: Offset(0, 0),
                                                  spreadRadius: 0,
                                                )
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    item.proImage != ""
                                                        ? CircleAvatar(
                                                      radius: 20,
                                                      backgroundImage:
                                                      NetworkImage(item
                                                          .proImage),
                                                    )
                                                        : CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor:
                                                      Colors
                                                          .transparent,
                                                      child: Icon(
                                                          Icons
                                                              .account_circle_outlined,
                                                          color:
                                                          grdintclr1),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    SizedBox(
                                                      width: width / 2.5,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          Text(
                                                            item.name,
                                                            maxLines: 1,
                                                            style:
                                                            const TextStyle(
                                                              color: Color(
                                                                  0xFF252525),
                                                              fontSize: 14,
                                                              fontFamily:
                                                              'Poppins',
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                              letterSpacing:
                                                              0.28,
                                                            ),
                                                          ),
                                                          Text(
                                                            item.tree,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                fontSize: 10),
                                                          ),
                                                          Text(
                                                            item.fromGrade,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .w300,
                                                                fontSize: 10),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    SizedBox(
                                                      // height: 60,
                                                      width: width / 3.5,
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Text(
                                                              item.type,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                                  fontSize: 10),
                                                            ),
                                                            Text(item.status,
                                                                style: TextStyle(
                                                                    color: item.status == "PENDING"
                                                                        ? clFA721F
                                                                        : item.status == "PAID"
                                                                        ? cl16B200
                                                                        : item.status == "PROCESSING"
                                                                        ? cl00369F
                                                                        : clAD0000)),
                                                            Text(
                                                              "₹${item.amount}",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        launch(
                                                            "tel://${item.phoneNumber}");
                                                      },
                                                      child: Container(
                                                        height: 28,
                                                        width: width / 8,
                                                        decoration: BoxDecoration(
                                                            color: grdintclr2,
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                20)),
                                                        child: const Icon(
                                                          Icons.call,
                                                          color: Colors.black,
                                                          size: 13,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * .04,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        launch(
                                                            'whatsapp://send?phone=${item.phoneNumber}');
                                                      },
                                                      child: Container(
                                                          height: 30,
                                                          width: width / 8,
                                                          decoration: BoxDecoration(
                                                              color: grdintclr2,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  20)),
                                                          child: const Image(
                                                              image: AssetImage(
                                                                  "assets/whatsapp.png"))),
                                                    ),
                                                    SizedBox(
                                                      width: width * .04,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        launch(
                                                            'https://telegram.me/+91${item.phoneNumber}');
                                                      },
                                                      child: Container(
                                                          height: 30,
                                                          width: width / 8,
                                                          decoration: BoxDecoration(
                                                              color: grdintclr2,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  20)),
                                                          child: const Icon(
                                                            Icons.telegram,
                                                            color: cl3E6FCF,
                                                            size: 18,
                                                          )),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                );
                              }),
                            ],
                          )
                        : const SizedBox();
                  }),

                  const SizedBox(
                    height: 15,
                  ),
                  Consumer<UserProvider>(builder: (context, user, child) {
                    return user.filterIncomeList.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Consumer<UserProvider>(
                                    builder: (context7, value3, child) {
                                  return const Text(
                                    "Club Income",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "PoppinsRegular"),
                                  );
                                }),
                                Consumer<UserProvider>(
                                    builder: (context, user, child) {
                                  return InkWell(
                                      onTap: () {
                                        // user.bottomSelectedIndex.value = 1;
                                        user.clearBooleans();

                                        callNext(
                                            IncomeScreen(
                                              loginId: userID,
                                              admin: false,
                                            ),
                                            context);
                                      },
                                      child: const SizedBox(
                                        height: 20,
                                        width: 70,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "See more",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ));
                                })
                              ],
                            ),
                          )
                        : const SizedBox();
                  }),
                  Consumer<UserProvider>(builder: (context3, value22, child) {
                    return SizedBox(
                      // color: Colors.lightGreen,
                      // height: value22.filterIncomeList.length == 1 ? 100: 200,
                      width: width / 1.01,
                      child: Consumer<UserProvider>(
                          builder: (context3, value3, child) {
                        return value3.filterIncomeList.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                itemCount: value3.filterIncomeList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var item = value3.filterIncomeList[index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: InkWell(
                                        onTap: () async {
                                          if (item.screenShot != "" &&
                                              item.status == "PROCESSING") {
                                            var toValue = await db
                                                .collection("DISTRIBUTIONS")
                                                .doc(item.id)
                                                .get();
                                            // .then((toValue) async {
                                            Map<dynamic, dynamic> toMap =
                                                toValue.data() as Map;
                                            String userIncomeStatus =
                                                toMap["STATUS"].toString();
                                            if (userIncomeStatus ==
                                                "PROCESSING") {
                                              callNext(
                                                  ApproveImageScreen(
                                                    name: item.name,
                                                    number: item.number,
                                                    id: item.memberId,
                                                    date: item.date,
                                                    time: item.time,
                                                    image: item.image,
                                                    screenShort:
                                                        item.screenShot,
                                                    distributionId: item.id,
                                                    grade: item.grade,
                                                    amount: item.amount,
                                                    paymentType:
                                                        item.paymentType,
                                                    tree: item.tree,
                                                    userDocId: item.userDoc,
                                                  ),
                                                  context);
                                            }
                                          }
                                          // });

                                          // if (item.screenShot != "" &&
                                          //     item.status == "PROCESSING") {
                                          //   callNext(
                                          //       ApproveImageScreen(
                                          //         name: item.name,
                                          //         number: item.number,
                                          //         id: item.memberId,
                                          //         date: item.date,
                                          //         time: item.time,
                                          //         image: item.image,
                                          //         screenShort: item.screenShot,
                                          //         distributionId: item.id,
                                          //         grade: item.grade,
                                          //         amount: item.amount,
                                          //         paymentType: item.paymentType,
                                          //         tree: item.tree,
                                          //         userDocId: item.userDoc,
                                          //       ),
                                          //       context);
                                          // }
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFFFFFCF8),
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xFFECECEC)),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              shadows: const [
                                                BoxShadow(
                                                  color: Color(0x1E7C7C7C),
                                                  blurRadius: 5,
                                                  offset: Offset(0, 0),
                                                  spreadRadius: 0,
                                                )
                                              ],
                                            ),
                                            padding: const EdgeInsets.all(5),
                                            // height: ,
                                            width: width,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: item.image != ""
                                                          ? CircleAvatar(
                                                              radius: 20,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      item.image),
                                                            )
                                                          : CircleAvatar(
                                                              radius: 20,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              child: Icon(
                                                                  Icons
                                                                      .account_circle_outlined,
                                                                  color:
                                                                      grdintclr1),
                                                            ),
                                                    ),

                                                    Expanded(
                                                      flex: 10,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            item.name,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                height: 1.3,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                          Text(item.inTree,
                                                              style: const TextStyle(
                                                                  fontSize: 11,
                                                                  height: 1.3,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color:
                                                                      cl252525)),
                                                          Text(item.grade,
                                                              style: const TextStyle(
                                                                  fontSize: 11,
                                                                  height: 1.3,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color:
                                                                      cl5F5F5F)),
                                                        ],
                                                      ),
                                                    ),
                                                    // const Spacer(),
                                                    Expanded(
                                                      flex: 5,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(
                                                              item.status ==
                                                                      "PAID"
                                                                  ? "RECEIVED"
                                                                  : item.status,
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: item.status ==
                                                                          "PENDING"
                                                                      ? clFA721F
                                                                      : item.status ==
                                                                              "PAID"
                                                                          ? cl16B200
                                                                          : item.status == "PROCESSING"
                                                                              ? cl00369F
                                                                              : clAD0000)),
                                                          Text(
                                                              item.tree ==
                                                                      "MASTER_CLUB"
                                                                  ? item
                                                                      .paymentType
                                                                  : "HELP",
                                                              style: const TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      cBlack)),
                                                          RichText(
                                                              text: TextSpan(
                                                                  children: [
                                                                const TextSpan(
                                                                  text:
                                                                      "Amount: ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      color:
                                                                          cl5F5F5F),
                                                                ),
                                                                const TextSpan(
                                                                    text: " ₹ ",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color:
                                                                            cl252525)),
                                                                TextSpan(
                                                                    text: item
                                                                        .amount,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color:
                                                                            cBlack)),
                                                              ]))
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        launch(
                                                            "tel://${item.number}");
                                                      },
                                                      child: Container(
                                                        height: 28,
                                                        width: width / 8,
                                                        decoration: BoxDecoration(
                                                            color: grdintclr2,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: const Icon(
                                                          Icons.call,
                                                          color: Colors.black,
                                                          size: 13,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * .04,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        launch(
                                                            'whatsapp://send?phone=${item.number}');
                                                      },
                                                      child: Container(
                                                          height: 30,
                                                          width: width / 8,
                                                          decoration: BoxDecoration(
                                                              color: grdintclr2,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: const Image(
                                                              image: AssetImage(
                                                                  "assets/whatsapp.png"))),
                                                    ),
                                                    SizedBox(
                                                      width: width * .04,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        launch(
                                                            'https://telegram.me/+91${item.number}');
                                                      },
                                                      child: Container(
                                                          height: 30,
                                                          width: width / 8,
                                                          decoration: BoxDecoration(
                                                              color: grdintclr2,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: const Icon(
                                                            Icons.telegram,
                                                            color: cl3E6FCF,
                                                            size: 18,
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                  );
                                })
                            : const SizedBox();
                      }),
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  Consumer<UserProvider>(builder: (context, user, child) {
                    return user.referralList.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Consumer<UserProvider>(
                                    builder: (context7, value3, child) {
                                  return const Text(
                                    "Referral Income",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "PoppinsRegular"),
                                  );
                                }),
                                Consumer<UserProvider>(
                                    builder: (context, user, child) {
                                  return InkWell(
                                      onTap: () {
                                        // user.bottomSelectedIndex.value = 1;
                                        // user.clearBooleans();

                                        callNext(const MyReferrals(), context);
                                      },
                                      child: const SizedBox(
                                        height: 20,
                                        width: 70,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "See more",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ));
                                })
                              ],
                            ),
                          )
                        : const SizedBox();
                  }),
                  Consumer<UserProvider>(builder: (context3, value22, child) {
                    return SizedBox(
                      // color: Colors.lightGreen,
                      // height: value22.filterIncomeList.length == 1 ? 100: 200,
                      width: width / 1.01,
                      child: Consumer<UserProvider>(
                          builder: (context3, value3, child) {
                        return value3.referralList.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                itemCount: value3.referralList.length >= 2
                                    ? 2
                                    : value3.referralList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var item = value3.referralList[index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: InkWell(
                                        onTap: () async {
                                          if (item.screenShot != "" &&
                                              item.status == "PROCESSING") {
                                            var toValue = await db
                                                .collection("DISTRIBUTIONS")
                                                .doc(item.id)
                                                .get();
                                            // .then((toValue) async {
                                            Map<dynamic, dynamic> toMap =
                                                toValue.data() as Map;
                                            String userIncomeStatus =
                                                toMap["STATUS"].toString();
                                            if (userIncomeStatus ==
                                                "PROCESSING") {
                                              callNext(
                                                  ApproveImageScreen(
                                                    name: item.name,
                                                    number: item.number,
                                                    id: item.memberId,
                                                    date: item.date,
                                                    time: item.time,
                                                    image: item.image,
                                                    screenShort:
                                                        item.screenShot,
                                                    distributionId: item.id,
                                                    grade: item.grade,
                                                    amount: item.amount,
                                                    paymentType:
                                                        item.paymentType,
                                                    tree: item.tree,
                                                    userDocId: item.userDoc,
                                                  ),
                                                  context);
                                            }
                                          }
                                          // });

                                          // if (item.screenShot != "" &&
                                          //     item.status == "PROCESSING") {
                                          //   callNext(
                                          //       ApproveImageScreen(
                                          //         name: item.name,
                                          //         number: item.number,
                                          //         id: item.memberId,
                                          //         date: item.date,
                                          //         time: item.time,
                                          //         image: item.image,
                                          //         screenShort: item.screenShot,
                                          //         distributionId: item.id,
                                          //         grade: item.grade,
                                          //         amount: item.amount,
                                          //         paymentType: item.paymentType,
                                          //         tree: item.tree,
                                          //         userDocId: item.userDoc,
                                          //       ),
                                          //       context);
                                          // }
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFFFFFCF8),
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xFFECECEC)),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              shadows: const [
                                                BoxShadow(
                                                  color: Color(0x1E7C7C7C),
                                                  blurRadius: 5,
                                                  offset: Offset(0, 0),
                                                  spreadRadius: 0,
                                                )
                                              ],
                                            ),
                                            padding: const EdgeInsets.all(5),
                                            // height: ,
                                            width: width,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: item.image != ""
                                                          ? CircleAvatar(
                                                              radius: 20,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      item.image),
                                                            )
                                                          : CircleAvatar(
                                                              radius: 20,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              child: Icon(
                                                                  Icons
                                                                      .account_circle_outlined,
                                                                  color:
                                                                      grdintclr1),
                                                            ),
                                                    ),

                                                    Expanded(
                                                      flex: 10,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            item.name,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                height: 1.3,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                          Text(item.tree,
                                                              style: const TextStyle(
                                                                  fontSize: 11,
                                                                  height: 1.3,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color:
                                                                      cl252525)),
                                                          Text(item.grade,
                                                              style: const TextStyle(
                                                                  fontSize: 11,
                                                                  height: 1.3,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color:
                                                                      cl5F5F5F)),
                                                        ],
                                                      ),
                                                    ),
                                                    // const Spacer(),
                                                    Expanded(
                                                      flex: 5,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(
                                                              item.status ==
                                                                      "PAID"
                                                                  ? "RECEIVED"
                                                                  : item.status,
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: item.status ==
                                                                          "PENDING"
                                                                      ? clFA721F
                                                                      : item.status ==
                                                                              "PAID"
                                                                          ? cl16B200
                                                                          : item.status == "PROCESSING"
                                                                              ? cl00369F
                                                                              : clAD0000)),
                                                          Text(
                                                              item.tree ==
                                                                      "MASTER_CLUB"
                                                                  ? item
                                                                      .paymentType
                                                                  : "HELP",
                                                              style: const TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      cBlack)),
                                                          RichText(
                                                              text: TextSpan(
                                                                  children: [
                                                                const TextSpan(
                                                                  text:
                                                                      "Amount: ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      color:
                                                                          cl5F5F5F),
                                                                ),
                                                                const TextSpan(
                                                                    text: " ₹ ",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color:
                                                                            cl252525)),
                                                                TextSpan(
                                                                    text: item
                                                                        .amount,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color:
                                                                            cBlack)),
                                                              ]))
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        launch(
                                                            "tel://${item.number}");
                                                      },
                                                      child: Container(
                                                        height: 28,
                                                        width: width / 8,
                                                        decoration: BoxDecoration(
                                                            color: grdintclr2,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: const Icon(
                                                          Icons.call,
                                                          color: Colors.black,
                                                          size: 13,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * .04,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        launch(
                                                            'whatsapp://send?phone=${item.number}');
                                                      },
                                                      child: Container(
                                                          height: 30,
                                                          width: width / 8,
                                                          decoration: BoxDecoration(
                                                              color: grdintclr2,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: const Image(
                                                              image: AssetImage(
                                                                  "assets/whatsapp.png"))),
                                                    ),
                                                    SizedBox(
                                                      width: width * .04,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        launch(
                                                            'https://telegram.me/+91${item.number}');
                                                      },
                                                      child: Container(
                                                          height: 30,
                                                          width: width / 8,
                                                          decoration: BoxDecoration(
                                                              color: grdintclr2,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: const Icon(
                                                            Icons.telegram,
                                                            color: cl3E6FCF,
                                                            size: 18,
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                  );
                                })
                            : const SizedBox();
                      }),
                    );
                  }),
                  // Consumer<UserProvider>(builder: (context21, val77, child) {
                  //   return SizedBox(
                  //     child: Column(
                  //       children: [
                  //         //////PMC//////
                  //         Consumer<UserProvider>(
                  //             builder: (context9, value44, child) {
                  //           return value44.userPmcBool
                  //               ? InkWell(
                  //                   onTap: () {
                  //                     if (value44.userPmcStatus != "PAID") {
                  //                       value44.gstCalc(double.parse(
                  //                           value44.userPmcAmount));
                  //                       callNext(
                  //                           PMCPaymentScreen(
                  //                               name: "PMC",
                  //                               amount: value44.userPmcAmount,
                  //                               grade: value44.userPmcGrade,
                  //                               tree: value44.userPmcTree,
                  //                               fromId: value44.registerID,
                  //                               distributionId: value44
                  //                                   .userPmcDistributionId,
                  //                               userName: value44.userName,
                  //                               phoneNumber: value44.userPhone),
                  //                           context);
                  //                     }
                  //                   },
                  //                   child: Container(
                  //                     width: width / 1.1,
                  //                     clipBehavior: Clip.antiAlias,
                  //                     decoration: BoxDecoration(color: bck),
                  //                     child: Row(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.spaceBetween,
                  //                       children: [
                  //                         Column(
                  //                           crossAxisAlignment:
                  //                               CrossAxisAlignment.start,
                  //                           children: [
                  //                             CircleAvatar(
                  //                               radius: 20,
                  //                               backgroundColor: bck,
                  //                               child: Image.asset(
                  //                                   "assets/bluelogo.png",
                  //                                   fit: BoxFit.fill),
                  //                             ),
                  //                             const Text(
                  //                               'PMC',
                  //                               style: TextStyle(
                  //                                   fontWeight: FontWeight.w600,
                  //                                   fontSize: 12),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         SizedBox(
                  //                           // height: 60,
                  //                           width: width / 3.2,
                  //                           child: Padding(
                  //                             padding:
                  //                                 const EdgeInsets.all(8.0),
                  //                             child: Column(
                  //                               crossAxisAlignment:
                  //                                   CrossAxisAlignment.end,
                  //                               mainAxisAlignment:
                  //                                   MainAxisAlignment.center,
                  //                               children: [
                  //                                 Text(value44.userPmcStatus,
                  //                                     style: TextStyle(
                  //                                         color:
                  //                                             value44.userPmcStatus !=
                  //                                                     "PAID"
                  //                                                 ? clFFA500
                  //                                                 : cl16B200)),
                  //                                 Text(
                  //                                   "₹${value44.userPmcAmount}",
                  //                                   style: const TextStyle(
                  //                                       fontWeight:
                  //                                           FontWeight.w600,
                  //                                       fontSize: 12),
                  //                                 ),
                  //                                 const SizedBox(),
                  //                               ],
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 )
                  //               : const SizedBox();
                  //         }),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         ///////////////////PTCF???????????
                  //         Consumer<UserProvider>(
                  //             builder: (context10, value45, child) {
                  //           return value45.userDonationBool
                  //               ? InkWell(
                  //                   onTap: () {
                  //                     if (value45.userDonationStatus !=
                  //                         "PAID") {
                  //                       callNext(
                  //                           PMCPaymentScreen(
                  //                               name: "PTCF",
                  //                               amount:
                  //                                   value45.userDonationAmount,
                  //                               grade:
                  //                                   value45.userDonationGrade,
                  //                               tree: value45.userDonationTree,
                  //                               fromId: value45.registerID,
                  //                               distributionId: value45
                  //                                   .userDonationDistributionId,
                  //                               userName: value45.userName,
                  //                               phoneNumber: value45.userPhone),
                  //                           context);
                  //                     }
                  //                   },
                  //                   child: Container(
                  //                     width: width / 1.1,
                  //                     clipBehavior: Clip.antiAlias,
                  //                     decoration: BoxDecoration(color: bck),
                  //                     child: Column(
                  //                       children: [
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             Column(
                  //                               crossAxisAlignment:
                  //                                   CrossAxisAlignment.start,
                  //                               children: [
                  //                                 CircleAvatar(
                  //                                   radius: 20,
                  //                                   backgroundColor: bck,
                  //                                   child: Image.asset(
                  //                                       "assets/bluelogo.png",
                  //                                       fit: BoxFit.fill),
                  //                                 ),
                  //                                 const Text(
                  //                                   'PTCF',
                  //                                   style: TextStyle(
                  //                                       fontWeight:
                  //                                           FontWeight.w600,
                  //                                       fontSize: 12),
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                             SizedBox(
                  //                               // height: 60,
                  //                               width: width / 3.2,
                  //                               child: Padding(
                  //                                 padding:
                  //                                     const EdgeInsets.all(8.0),
                  //                                 child: Column(
                  //                                   crossAxisAlignment:
                  //                                       CrossAxisAlignment.end,
                  //                                   mainAxisAlignment:
                  //                                       MainAxisAlignment
                  //                                           .center,
                  //                                   children: [
                  //                                     Text(
                  //                                         value45
                  //                                             .userDonationStatus,
                  //                                         style: TextStyle(
                  //                                             color: value45
                  //                                                         .userDonationStatus !=
                  //                                                     "PAID"
                  //                                                 ? clFFA500
                  //                                                 : cl16B200)),
                  //                                     Text(
                  //                                       "₹${value45.userDonationAmount}",
                  //                                       style: const TextStyle(
                  //                                           fontWeight:
                  //                                               FontWeight.w600,
                  //                                           fontSize: 12),
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 )
                  //               : const SizedBox();
                  //         }),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         //////////////////////////UPGRADE////////////
                  //         Consumer<UserProvider>(
                  //             builder: (context11, value46, child) {
                  //           return value46.userUpgradeBool
                  //               ? InkWell(
                  //                   onTap: () async {
                  //                     bool levelCheck =
                  //                         await value46.checkLevelStatus(
                  //                             value46.userGrade,
                  //                             value46.userUpgradeGrade,
                  //                             value46.upgradeUserStatus,
                  //                             // value46.upgradeUserChildCount,
                  //                             // value46.upgradeUserLeftDays,
                  //                             context);
                  //                     if (levelCheck) {
                  //                       if (value46.userUpgradeStatus !=
                  //                           "PAID") {
                  //                         if (value46.userUpgradeScreenShot ==
                  //                             "") {
                  //                           callNext(
                  //                               PaymentScreen(
                  //                                 userUpgradeId:
                  //                                     value46.userUpgradeId,
                  //                                 userUpgradeName:
                  //                                     value46.userUpgradeName,
                  //                                 userUpgradeNumber:
                  //                                     value46.userUpgradeNumber,
                  //                                 userUpgradeProfileImage: value46
                  //                                     .userUpgradeProfileImage,
                  //                                 userUpgradeAmount:
                  //                                     value46.userUpgradeAmount,
                  //                                 userUpgradeStatus:
                  //                                     value46.userUpgradeStatus,
                  //                                 userUpgradeUpiID:
                  //                                     value46.userUpgradeUpiID,
                  //                                 userPaymentType: "HELP",
                  //                                 userUpgradeGrade:
                  //                                     value46.userUpgradeGrade,
                  //                                 userUpgradeTree:
                  //                                     value46.userUpgradeTree,
                  //                                 distributionId: value46
                  //                                     .userUpgradeDistributionId,
                  //                               ),
                  //                               context);
                  //                         } else {
                  //                           callNext(
                  //                               ConfirmationScreen(
                  //                                 name: value46.userUpgradeName,
                  //                                 phoneNumber:
                  //                                     value46.userUpgradeNumber,
                  //                                 date: "",
                  //                                 time: "",
                  //                                 regId: value46.userUpgradeId,
                  //                                 image: value46
                  //                                     .userUpgradeProfileImage,
                  //                                 screenShot: value46
                  //                                     .userUpgradeScreenShot,
                  //                                 receiptImage: null,
                  //                                 from: "HOME",
                  //                                 paymentType: "HELP",
                  //                                 tree: value46.userUpgradeTree,
                  //                                 grade:
                  //                                     value46.userUpgradeGrade,
                  //                                 distributionId: value46
                  //                                     .userUpgradeDistributionId,
                  //                               ),
                  //                               context);
                  //                         }
                  //                       }
                  //                     } else {
                  //                       value46.warningAlertHome(
                  //                         context,
                  //                         "${value46.userUpgradeName} ",
                  //                         "not yet completed his payments or in blocked state, Please contact him for more details.",
                  //                         value46.userUpgradeNumber,
                  //                       );
                  //                     }
                  //                   },
                  //                   child: Container(
                  //                     width: width / 1.1,
                  //                     clipBehavior: Clip.antiAlias,
                  //                     decoration: BoxDecoration(color: bck),
                  //                     child: Column(
                  //                       children: [
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             value46.userUpgradeProfileImage !=
                  //                                     ""
                  //                                 ? CircleAvatar(
                  //                                     radius: 20,
                  //                                     backgroundImage:
                  //                                         NetworkImage(value46
                  //                                             .userUpgradeProfileImage),
                  //                                   )
                  //                                 : const Icon(
                  //                                     Icons.person_rounded),
                  //                             SizedBox(
                  //                               width: width / 2.3,
                  //                               child: Column(
                  //                                 crossAxisAlignment:
                  //                                     CrossAxisAlignment.start,
                  //                                 mainAxisAlignment:
                  //                                     MainAxisAlignment.center,
                  //                                 children: [
                  //                                   Text(
                  //                                     value46.userUpgradeName,
                  //                                     style: const TextStyle(
                  //                                         fontWeight:
                  //                                             FontWeight.w600,
                  //                                         fontSize: 14),
                  //                                   ),
                  //                                   Text(
                  //                                     value46.userUpgradeId,
                  //                                     style: const TextStyle(
                  //                                         fontWeight:
                  //                                             FontWeight.w300,
                  //                                         fontSize: 12),
                  //                                   ),
                  //                                   Text(
                  //                                     value46.userUpgradeNumber,
                  //                                     style: const TextStyle(
                  //                                         fontWeight:
                  //                                             FontWeight.w300,
                  //                                         fontSize: 10),
                  //                                   )
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                             SizedBox(
                  //                               // height: 60,
                  //                               width: width / 3.2,
                  //                               child: Padding(
                  //                                 padding:
                  //                                     const EdgeInsets.all(8.0),
                  //                                 child: Column(
                  //                                   crossAxisAlignment:
                  //                                       CrossAxisAlignment.end,
                  //                                   mainAxisAlignment:
                  //                                       MainAxisAlignment
                  //                                           .center,
                  //                                   children: [
                  //                                     const Text(
                  //                                       "HELP",
                  //                                       style: TextStyle(
                  //                                           fontWeight:
                  //                                               FontWeight.w400,
                  //                                           fontSize: 10),
                  //                                     ),
                  //                                     Text(
                  //                                       value46
                  //                                           .userUpgradeStatus,
                  //                                       style: TextStyle(
                  //                                           color:
                  //                                               value46.userUpgradeStatus !=
                  //                                                       "PAID"
                  //                                                   ? clFFA500
                  //                                                   : cl16B200),
                  //                                     ),
                  //                                     Text(
                  //                                       "₹${value46.userUpgradeAmount}",
                  //                                       style: const TextStyle(
                  //                                           fontWeight:
                  //                                               FontWeight.w600,
                  //                                           fontSize: 12),
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.center,
                  //                           children: [
                  //                             InkWell(
                  //                               onTap: () {
                  //                                 launch(
                  //                                     "tel://${value46.userUpgradeNumber}");
                  //                               },
                  //                               child: Container(
                  //                                 height: 28,
                  //                                 width: width / 6,
                  //                                 decoration: BoxDecoration(
                  //                                     color: grdintclr2,
                  //                                     borderRadius:
                  //                                         BorderRadius.circular(
                  //                                             20)),
                  //                                 child: const Icon(
                  //                                   Icons.call,
                  //                                   color: Colors.black,
                  //                                   size: 13,
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                             SizedBox(
                  //                               width: width * .04,
                  //                             ),
                  //                             InkWell(
                  //                               onTap: () {
                  //                                 launch(
                  //                                     'whatsapp://send?phone=${value46.userUpgradeNumber}');
                  //                               },
                  //                               child: Container(
                  //                                   height: 30,
                  //                                   width: width / 6,
                  //                                   decoration: BoxDecoration(
                  //                                       color: grdintclr2,
                  //                                       borderRadius:
                  //                                           BorderRadius
                  //                                               .circular(20)),
                  //                                   child: const Image(
                  //                                       image: AssetImage(
                  //                                           "assets/whatsapp.png"))),
                  //                             )
                  //                           ],
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 )
                  //               : const SizedBox();
                  //         }),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         /////////////////////REFERRAL///////////////////
                  //         Consumer<UserProvider>(
                  //             builder: (context12, value49, child) {
                  //           return value49.userReferralBool
                  //               ? InkWell(
                  //                   onTap: () async {
                  //                     bool levelCheck =
                  //                         await value49.checkLevelStatus(
                  //                             value49.userGrade,
                  //                             value49.userReferralGrade,
                  //                             value49.referralUserStatus,
                  //                             // value49.referralUserChildCount,
                  //                             // value49.referralUserLeftDays,
                  //                             context);
                  //                     if (levelCheck) {
                  //                       if (value49.userReferralStatus !=
                  //                           "PAID") {
                  //                         if (value49.userReferralScreenShot ==
                  //                             "") {
                  //                           callNext(
                  //                               PaymentScreen(
                  //                                 userUpgradeId:
                  //                                     value49.userReferralId,
                  //                                 userUpgradeName:
                  //                                     value49.userReferralName,
                  //                                 userUpgradeNumber: value49
                  //                                     .userReferralNumber,
                  //                                 userUpgradeProfileImage: value49
                  //                                     .userReferralProfileImage,
                  //                                 userUpgradeAmount: value49
                  //                                     .userReferralAmount,
                  //                                 userUpgradeStatus: value49
                  //                                     .userReferralStatus,
                  //                                 userUpgradeUpiID:
                  //                                     value49.userReferralUpiID,
                  //                                 userPaymentType: "REFERRAL",
                  //                                 userUpgradeGrade:
                  //                                     value49.userReferralGrade,
                  //                                 userUpgradeTree:
                  //                                     value49.userReferralTree,
                  //                                 distributionId: value49
                  //                                     .userReferralDistributionId,
                  //                               ),
                  //                               context);
                  //                         } else {
                  //                           callNext(
                  //                               ConfirmationScreen(
                  //                                 name:
                  //                                     value49.userReferralName,
                  //                                 phoneNumber: value49
                  //                                     .userReferralNumber,
                  //                                 date: "",
                  //                                 time: "",
                  //                                 regId: value49.userReferralId,
                  //                                 image: value49
                  //                                     .userReferralProfileImage,
                  //                                 screenShot: value49
                  //                                     .userReferralScreenShot,
                  //                                 receiptImage: null,
                  //                                 from: "HOME",
                  //                                 paymentType: "REFERRAL",
                  //                                 tree:
                  //                                     value49.userReferralTree,
                  //                                 grade:
                  //                                     value49.userReferralGrade,
                  //                                 distributionId: value49
                  //                                     .userReferralDistributionId,
                  //                               ),
                  //                               context);
                  //                         }
                  //                       }
                  //                     } else {
                  //                       value49.warningAlertHome(
                  //                         context,
                  //                         "${value49.userReferralName}",
                  //                         " not yet completed his payments or"
                  //                             " in blocked state, Please contact him for more details.",
                  //                         value49.userReferralNumber,
                  //                       );
                  //                     }
                  //                   },
                  //                   child: Container(
                  //                     width: width / 1.1,
                  //                     clipBehavior: Clip.antiAlias,
                  //                     decoration: BoxDecoration(color: bck),
                  //                     child: Column(
                  //                       children: [
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             value49.userReferralProfileImage !=
                  //                                     ""
                  //                                 ? CircleAvatar(
                  //                                     radius: 20,
                  //                                     backgroundImage:
                  //                                         NetworkImage(value49
                  //                                             .userReferralProfileImage),
                  //                                   )
                  //                                 : const Icon(
                  //                                     Icons.person_rounded),
                  //                             SizedBox(
                  //                               width: width / 2.3,
                  //                               child: Column(
                  //                                 crossAxisAlignment:
                  //                                     CrossAxisAlignment.start,
                  //                                 mainAxisAlignment:
                  //                                     MainAxisAlignment.center,
                  //                                 children: [
                  //                                   Text(
                  //                                     value49.userReferralName,
                  //                                     style: const TextStyle(
                  //                                         fontWeight:
                  //                                             FontWeight.w600,
                  //                                         fontSize: 14),
                  //                                   ),
                  //                                   Text(
                  //                                     value49.userReferralId,
                  //                                     style: const TextStyle(
                  //                                         fontWeight:
                  //                                             FontWeight.w300,
                  //                                         fontSize: 12),
                  //                                   ),
                  //                                   Text(
                  //                                     value49
                  //                                         .userReferralNumber,
                  //                                     style: const TextStyle(
                  //                                         fontWeight:
                  //                                             FontWeight.w300,
                  //                                         fontSize: 10),
                  //                                   )
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                             SizedBox(
                  //                               // height: 60,
                  //                               width: width / 3.2,
                  //                               child: Padding(
                  //                                 padding:
                  //                                     const EdgeInsets.all(8.0),
                  //                                 child: Column(
                  //                                   crossAxisAlignment:
                  //                                       CrossAxisAlignment.end,
                  //                                   mainAxisAlignment:
                  //                                       MainAxisAlignment
                  //                                           .center,
                  //                                   children: [
                  //                                     const Text(
                  //                                       "REFERRAL",
                  //                                       style: TextStyle(
                  //                                           fontWeight:
                  //                                               FontWeight.w400,
                  //                                           fontSize: 10),
                  //                                     ),
                  //                                     Text(
                  //                                         value49
                  //                                             .userReferralStatus,
                  //                                         style: TextStyle(
                  //                                             color: value49
                  //                                                         .userReferralStatus !=
                  //                                                     "PAID"
                  //                                                 ? clFFA500
                  //                                                 : cl16B200)),
                  //                                     Text(
                  //                                       "₹${value49.userReferralAmount}",
                  //                                       style: const TextStyle(
                  //                                           fontWeight:
                  //                                               FontWeight.w600,
                  //                                           fontSize: 12),
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.center,
                  //                           children: [
                  //                             InkWell(
                  //                               onTap: () {
                  //                                 launch(
                  //                                     "tel://${value49.userReferralNumber}");
                  //                               },
                  //                               child: Container(
                  //                                 height: 28,
                  //                                 width: width / 6,
                  //                                 decoration: BoxDecoration(
                  //                                     color: grdintclr2,
                  //                                     borderRadius:
                  //                                         BorderRadius.circular(
                  //                                             20)),
                  //                                 child: const Icon(
                  //                                   Icons.call,
                  //                                   color: Colors.black,
                  //                                   size: 13,
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                             SizedBox(
                  //                               width: width * .04,
                  //                             ),
                  //                             InkWell(
                  //                               onTap: () {
                  //                                 launch(
                  //                                     'whatsapp://send?phone=${value49.userReferralNumber}');
                  //                               },
                  //                               child: Container(
                  //                                   height: 30,
                  //                                   width: width / 6,
                  //                                   decoration: BoxDecoration(
                  //                                       color: grdintclr2,
                  //                                       borderRadius:
                  //                                           BorderRadius
                  //                                               .circular(20)),
                  //                                   child: const Image(
                  //                                       image: AssetImage(
                  //                                           "assets/whatsapp.png"))),
                  //                             )
                  //                           ],
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 )
                  //               : const SizedBox();
                  //         }),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         ////////////////////////AUTO-POLL ONE/////////////////////
                  //         Consumer<UserProvider>(
                  //             builder: (context13, value47, child) {
                  //           return value47.userAuto1Bool
                  //               ? InkWell(
                  //                   onTap: () async {
                  //                     bool levelCheck = false;
                  //                     if (value47.userAutoPollOneTree ==
                  //                         "MASTER_CLUB") {
                  //                       levelCheck = await value47.checkLevelStatus(
                  //                           value47.userGrade,
                  //                           value47.userAutoPollOneGrade,
                  //                           value47.autoPollOneUserStatus,
                  //                           // value47.autoPollOneUserChildCount,
                  //                           // value47.autoPollOneUserLeftDays,
                  //                           context);
                  //                     } else {
                  //                       levelCheck =
                  //                           await value47.checkAutoLevelStatus(
                  //                               value47.userTreeGrade,
                  //                               value47.userAutoPollOneGrade,
                  //                               value47.autoPollOneUserStatus,
                  //                               context);
                  //                     }
                  //                     bool checkKycOrCount =
                  //                         await value47.checkKycStatusAndChild(
                  //                             value47.directInvitesCount,
                  //                             value47.kycStatus,
                  //                             context);
                  //
                  //                     if (levelCheck) {
                  //                       if (checkKycOrCount) {
                  //                         if (value47.userAutoPollOneStatus !=
                  //                             "PAID") {
                  //                           if (value47
                  //                                   .userAutoPollOneScreenShot ==
                  //                               "") {
                  //                             callNext(
                  //                                 PaymentScreen(
                  //                                   userUpgradeId: value47
                  //                                       .userAutoPollOneId,
                  //                                   userUpgradeName: value47
                  //                                       .userAutoPollOneName,
                  //                                   userUpgradeNumber: value47
                  //                                       .userAutoPollOneNumber,
                  //                                   userUpgradeProfileImage: value47
                  //                                       .userAutoPollOneProfileImage,
                  //                                   userUpgradeAmount: value47
                  //                                       .userAutoPollOneAmount,
                  //                                   userUpgradeStatus: value47
                  //                                       .userAutoPollOneStatus,
                  //                                   userUpgradeUpiID: value47
                  //                                       .userAutoPollOneUpiID,
                  //                                   userPaymentType:
                  //                                       "STAR_CLUB",
                  //                                   userUpgradeGrade: value47
                  //                                       .userAutoPollOneGrade,
                  //                                   userUpgradeTree: value47
                  //                                       .userAutoPollOneTree,
                  //                                   distributionId: value47
                  //                                       .userAutoPollOneDistributionId,
                  //                                 ),
                  //                                 context);
                  //                           } else {
                  //                             callNext(
                  //                                 ConfirmationScreen(
                  //                                   name: value47
                  //                                       .userAutoPollOneName,
                  //                                   phoneNumber: value47
                  //                                       .userAutoPollOneNumber,
                  //                                   date: "",
                  //                                   time: "",
                  //                                   regId: value47
                  //                                       .userAutoPollOneId,
                  //                                   image: value47
                  //                                       .userAutoPollOneProfileImage,
                  //                                   screenShot: value47
                  //                                       .userAutoPollOneScreenShot,
                  //                                   receiptImage: null,
                  //                                   from: "HOME",
                  //                                   paymentType:
                  //                                       "STAR_CLUB",
                  //                                   tree: value47
                  //                                       .userAutoPollOneTree,
                  //                                   grade: value47
                  //                                       .userAutoPollOneGrade,
                  //                                   distributionId: value47
                  //                                       .userAutoPollOneDistributionId,
                  //                                 ),
                  //                                 context);
                  //                           }
                  //                         }
                  //                       } else {
                  //                         value47.kycChildCountAlert(context,
                  //                             value47.userAutoPollOneNumber);
                  //                       }
                  //                     } else {
                  //                       value47.warningAlertHome(
                  //                         context,
                  //                         "${value47.userAutoPollOneName}",
                  //                         "not yet completed his payments or"
                  //                             " in blocked state, Please contact him for more details.",
                  //                         value47.userAutoPollOneNumber,
                  //                       );
                  //                     }
                  //                   },
                  //                   child: Container(
                  //                     width: width / 1.1,
                  //                     clipBehavior: Clip.antiAlias,
                  //                     decoration: BoxDecoration(color: bck),
                  //                     child: Column(
                  //                       children: [
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             value47.userAutoPollOneProfileImage !=
                  //                                     ""
                  //                                 ? CircleAvatar(
                  //                                     radius: 20,
                  //                                     backgroundImage:
                  //                                         NetworkImage(value47
                  //                                             .userAutoPollOneProfileImage),
                  //                                   )
                  //                                 : const Icon(
                  //                                     Icons.person_rounded),
                  //                             SizedBox(
                  //                               width: width / 2.3,
                  //                               child: Column(
                  //                                 crossAxisAlignment:
                  //                                     CrossAxisAlignment.start,
                  //                                 mainAxisAlignment:
                  //                                     MainAxisAlignment.center,
                  //                                 children: [
                  //                                   Text(
                  //                                     value47
                  //                                         .userAutoPollOneName,
                  //                                     style: const TextStyle(
                  //                                         fontWeight:
                  //                                             FontWeight.w600,
                  //                                         fontSize: 14),
                  //                                   ),
                  //                                   Text(
                  //                                     value47.userAutoPollOneId,
                  //                                     style: const TextStyle(
                  //                                         fontWeight:
                  //                                             FontWeight.w300,
                  //                                         fontSize: 12),
                  //                                   ),
                  //                                   Text(
                  //                                     value47
                  //                                         .userAutoPollOneNumber,
                  //                                     style: const TextStyle(
                  //                                         fontWeight:
                  //                                             FontWeight.w300,
                  //                                         fontSize: 10),
                  //                                   )
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                             SizedBox(
                  //                               // height: 60,
                  //                               width: width / 3.2,
                  //                               child: Padding(
                  //                                 padding:
                  //                                     const EdgeInsets.all(8.0),
                  //                                 child: Column(
                  //                                   crossAxisAlignment:
                  //                                       CrossAxisAlignment.end,
                  //                                   mainAxisAlignment:
                  //                                       MainAxisAlignment
                  //                                           .center,
                  //                                   children: [
                  //                                     const Text(
                  //                                       "STAR_CLUB",
                  //                                       style: TextStyle(
                  //                                           fontWeight:
                  //                                               FontWeight.w400,
                  //                                           fontSize: 10),
                  //                                     ),
                  //                                     Text(
                  //                                         value47
                  //                                             .userAutoPollOneStatus,
                  //                                         style: TextStyle(
                  //                                             color: value47
                  //                                                         .userAutoPollOneStatus !=
                  //                                                     "PAID"
                  //                                                 ? clFFA500
                  //                                                 : cl16B200)),
                  //                                     Text(
                  //                                       "₹${value47.userAutoPollOneAmount}",
                  //                                       style: const TextStyle(
                  //                                           fontWeight:
                  //                                               FontWeight.w600,
                  //                                           fontSize: 12),
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.center,
                  //                           children: [
                  //                             InkWell(
                  //                               onTap: () {
                  //                                 launch(
                  //                                     "tel://${value47.userAutoPollOneNumber}");
                  //                               },
                  //                               child: Container(
                  //                                 height: 28,
                  //                                 width: width / 6,
                  //                                 decoration: BoxDecoration(
                  //                                     color: grdintclr2,
                  //                                     borderRadius:
                  //                                         BorderRadius.circular(
                  //                                             20)),
                  //                                 child: const Icon(
                  //                                   Icons.call,
                  //                                   color: Colors.black,
                  //                                   size: 13,
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                             SizedBox(
                  //                               width: width * .04,
                  //                             ),
                  //                             InkWell(
                  //                               onTap: () {
                  //                                 launch(
                  //                                     'whatsapp://send?phone=${value47.userAutoPollOneNumber}');
                  //                               },
                  //                               child: Container(
                  //                                   height: 30,
                  //                                   width: width / 6,
                  //                                   decoration: BoxDecoration(
                  //                                       color: grdintclr2,
                  //                                       borderRadius:
                  //                                           BorderRadius
                  //                                               .circular(20)),
                  //                                   child: const Image(
                  //                                       image: AssetImage(
                  //                                           "assets/whatsapp.png"))),
                  //                             )
                  //                           ],
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 )
                  //               : const SizedBox();
                  //         }),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         ////////////////////////CROWN_CLUB/////////////////////
                  //         Consumer<UserProvider>(
                  //             builder: (context14, value48, child) {
                  //           return value48.userAuto2Bool
                  //               ? InkWell(
                  //                   onTap: () async {
                  //                     bool levelCheck = false;
                  //                     if (value48.userAutoPollTwoTree ==
                  //                         "MASTER_CLUB") {
                  //                       levelCheck = await value48.checkLevelStatus(
                  //                           value48.userGrade,
                  //                           value48.userAutoPollTwoGrade,
                  //                           value48.autoPollTwoUserStatus,
                  //                           // value48.autoPollTwoUserChildCount,
                  //                           // value48.autoPollTwoUserLeftDays,
                  //                           context);
                  //                     } else {
                  //                       levelCheck =
                  //                           await value48.checkAutoLevelStatus(
                  //                               value48.userTreeGrade,
                  //                               value48.userAutoPollTwoGrade,
                  //                               value48.autoPollTwoUserStatus,
                  //                               context);
                  //                     }
                  //
                  //                     bool checkKycOrCount =
                  //                         await value48.checkKycStatusAndChild(
                  //                             value48.directInvitesCount,
                  //                             value48.kycStatus,
                  //                             context);
                  //
                  //                     if (levelCheck) {
                  //                       if (checkKycOrCount) {
                  //                         if (value48.userAutoPollTwoStatus !=
                  //                             "PAID") {
                  //                           if (value48
                  //                                   .userAutoPollTwoScreenShot ==
                  //                               "") {
                  //                             callNext(
                  //                                 PaymentScreen(
                  //                                   userUpgradeId: value48
                  //                                       .userAutoPollTwoId,
                  //                                   userUpgradeName: value48
                  //                                       .userAutoPollTwoName,
                  //                                   userUpgradeNumber: value48
                  //                                       .userAutoPollTwoNumber,
                  //                                   userUpgradeProfileImage: value48
                  //                                       .userAutoPollTwoProfileImage,
                  //                                   userUpgradeAmount: value48
                  //                                       .userAutoPollTwoAmount,
                  //                                   userUpgradeStatus: value48
                  //                                       .userAutoPollTwoStatus,
                  //                                   userUpgradeUpiID: value48
                  //                                       .userAutoPollTwoUpiID,
                  //                                   userPaymentType:
                  //                                       "CROWN_CLUB",
                  //                                   userUpgradeGrade: value48
                  //                                       .userAutoPollTwoGrade,
                  //                                   userUpgradeTree: value48
                  //                                       .userAutoPollTwoTree,
                  //                                   distributionId: value48
                  //                                       .userAutoPollTwoDistributionId,
                  //                                 ),
                  //                                 context);
                  //                           } else {
                  //                             callNext(
                  //                                 ConfirmationScreen(
                  //                                   name: value48
                  //                                       .userAutoPollTwoName,
                  //                                   phoneNumber: value48
                  //                                       .userAutoPollTwoNumber,
                  //                                   date: "",
                  //                                   time: "",
                  //                                   regId: value48
                  //                                       .userAutoPollTwoId,
                  //                                   image: value48
                  //                                       .userAutoPollTwoProfileImage,
                  //                                   screenShot: value48
                  //                                       .userAutoPollTwoScreenShot,
                  //                                   receiptImage: null,
                  //                                   from: "HOME",
                  //                                   paymentType:
                  //                                       "CROWN_CLUB",
                  //                                   tree: value48
                  //                                       .userAutoPollTwoTree,
                  //                                   grade: value48
                  //                                       .userAutoPollTwoGrade,
                  //                                   distributionId: value48
                  //                                       .userAutoPollTwoDistributionId,
                  //                                 ),
                  //                                 context);
                  //                           }
                  //                         }
                  //                       } else {
                  //                         value48.kycChildCountAlert(context,
                  //                             value48.userAutoPollTwoNumber);
                  //                       }
                  //                     } else {
                  //                       value48.warningAlertHome(
                  //                         context,
                  //                         "${value48.userAutoPollTwoName}",
                  //                         " not yet completed his "
                  //                             "payments or in blocked state, Please contact him for more details.",
                  //                         value48.userAutoPollTwoNumber,
                  //                       );
                  //                     }
                  //                   },
                  //                   child: Container(
                  //                     width: width / 1.1,
                  //                     clipBehavior: Clip.antiAlias,
                  //                     decoration: BoxDecoration(color: bck),
                  //                     child: Column(
                  //                       children: [
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             value48.userAutoPollTwoProfileImage !=
                  //                                     ""
                  //                                 ? CircleAvatar(
                  //                                     radius: 20,
                  //                                     backgroundImage:
                  //                                         NetworkImage(value48
                  //                                             .userAutoPollTwoProfileImage),
                  //                                   )
                  //                                 : const Icon(
                  //                                     Icons.person_rounded),
                  //                             SizedBox(
                  //                               width: width / 2.3,
                  //                               child: Column(
                  //                                 crossAxisAlignment:
                  //                                     CrossAxisAlignment.start,
                  //                                 mainAxisAlignment:
                  //                                     MainAxisAlignment.center,
                  //                                 children: [
                  //                                   Text(
                  //                                     value48
                  //                                         .userAutoPollTwoName,
                  //                                     style: const TextStyle(
                  //                                         fontWeight:
                  //                                             FontWeight.w600,
                  //                                         fontSize: 14),
                  //                                   ),
                  //                                   Text(
                  //                                     value48.userAutoPollTwoId,
                  //                                     style: const TextStyle(
                  //                                         fontWeight:
                  //                                             FontWeight.w300,
                  //                                         fontSize: 12),
                  //                                   ),
                  //                                   Text(
                  //                                     value48
                  //                                         .userAutoPollTwoNumber,
                  //                                     style: const TextStyle(
                  //                                         fontWeight:
                  //                                             FontWeight.w300,
                  //                                         fontSize: 10),
                  //                                   )
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                             SizedBox(
                  //                               // height: 60,
                  //                               width: width / 3.2,
                  //                               child: Padding(
                  //                                 padding:
                  //                                     const EdgeInsets.all(8.0),
                  //                                 child: Column(
                  //                                   crossAxisAlignment:
                  //                                       CrossAxisAlignment.end,
                  //                                   mainAxisAlignment:
                  //                                       MainAxisAlignment
                  //                                           .center,
                  //                                   children: [
                  //                                     const Text(
                  //                                       "CROWN_CLUB",
                  //                                       style: TextStyle(
                  //                                           fontWeight:
                  //                                               FontWeight.w400,
                  //                                           fontSize: 10),
                  //                                     ),
                  //                                     Text(
                  //                                         value48
                  //                                             .userAutoPollTwoStatus,
                  //                                         style: TextStyle(
                  //                                             color: value48
                  //                                                         .userAutoPollTwoStatus !=
                  //                                                     "PAID"
                  //                                                 ? clFFA500
                  //                                                 : cl16B200)),
                  //                                     Text(
                  //                                       "₹${value48.userAutoPollTwoAmount}",
                  //                                       style: const TextStyle(
                  //                                           fontWeight:
                  //                                               FontWeight.w600,
                  //                                           fontSize: 12),
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.center,
                  //                           children: [
                  //                             InkWell(
                  //                               onTap: () {
                  //                                 launch(
                  //                                     "tel://${value48.userAutoPollTwoNumber}");
                  //                               },
                  //                               child: Container(
                  //                                 height: 28,
                  //                                 width: width / 6,
                  //                                 decoration: BoxDecoration(
                  //                                     color: grdintclr2,
                  //                                     borderRadius:
                  //                                         BorderRadius.circular(
                  //                                             20)),
                  //                                 child: const Icon(
                  //                                   Icons.call,
                  //                                   color: Colors.black,
                  //                                   size: 13,
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                             SizedBox(
                  //                               width: width * .04,
                  //                             ),
                  //                             InkWell(
                  //                               onTap: () {
                  //                                 launch(
                  //                                     'whatsapp://send?phone=${value48.userAutoPollTwoNumber}');
                  //                               },
                  //                               child: Container(
                  //                                   height: 30,
                  //                                   width: width / 6,
                  //                                   decoration: BoxDecoration(
                  //                                       color: grdintclr2,
                  //                                       borderRadius:
                  //                                           BorderRadius
                  //                                               .circular(20)),
                  //                                   child: const Image(
                  //                                       image: AssetImage(
                  //                                           "assets/whatsapp.png"))),
                  //                             )
                  //                           ],
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 )
                  //               : const SizedBox();
                  //         }),
                  //       ],
                  //     ),
                  //   );
                  // }),
                  // const SizedBox(
                  //   height: 20,
                  // )
                ],
              ),


          Consumer<UserProvider>(builder: (context3, value22, child) {
                return Text("Version : ${value22.currentVersion}.${value22.buildNumber}",
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 8),);
              }
            ),
              SizedBox(
                width: width,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class LastTransactionProfile extends StatefulWidget {
//   final List<LastTransactionModel> list;
//   // final BuildContext ctx;
//    const LastTransactionProfile({
//     super.key,required this.list,
//      // required this.ctx
//   });
//   @override
//   State<LastTransactionProfile> createState() => _LastTransactionProfileState();
// }
//
// class _LastTransactionProfileState extends State<LastTransactionProfile> {
//   int _currentIndex = 0;
//   // UserProvider userProvider =
//   // Provider.of<UserProvider>(widget.ctx, listen: false);
//   late Timer _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   void _startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 5), (timer) {
//       setState(() {
//         if (widget.list.isNotEmpty) {
//           if(_currentIndex==49){
//             _currentIndex=0;
//           }else{
//           _currentIndex = (_currentIndex + 1) ;
//           }
//               // % widget.list.length;
//           print(_currentIndex);
//           print("currentIndex");
//         }
//       });
//     });
//   }
//
//   Widget build(BuildContext context) {
//
//
//     return Consumer<UserProvider>(
//         builder: (context4,value78,_) {
//
//
//           return Container(
//             margin: const EdgeInsets.all(3.2),
//             width: 58,
//             height: 58,
//             decoration: BoxDecoration(
//                 color: cWhite,
//                 shape: BoxShape.circle,
//                 image: widget.list[_currentIndex].topperImage!=
//                     ""
//                     ? DecorationImage(
//                   image: NetworkImage(widget.list[_currentIndex].topperImage),
//                   fit: BoxFit.cover,
//                 )
//                     : const DecorationImage(
//                   image: AssetImage(
//                       "assets/profile2.png"),
//                   fit: BoxFit.cover,
//                 )),
//           );
//         }
//     );
//   }}


class RecentTransactions extends StatefulWidget {
  final List<LastTransactionModel> list;
  // final BuildContext ctx;
  const RecentTransactions({
    super.key,required this.list,
    // required this.ctx
  });

  @override
  _RecentTransactionsState createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> with SingleTickerProviderStateMixin {

  int currentIndex = 0;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _showNextPhoneNumber();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _showNextPhoneNumber() {
    setState(() {
      currentIndex = (currentIndex + 1) % widget.list.length;
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        const SizedBox(width: 15),
        CustomPaint(
          painter: CircleBorderPainter(),
          child: Container(
            margin: const EdgeInsets.all(2),
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: cWhite,
              shape: BoxShape.circle,
            ),
            child: Consumer<UserProvider>(
                builder: (context4,value78,_) {
                  return Container(
                    margin: const EdgeInsets.all(3.2),
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                        color: cWhite,
                        shape: BoxShape.circle,
                        image: widget.list[currentIndex].topperImage!=
                            ""
                            ? DecorationImage(
                          image: NetworkImage(widget.list[currentIndex].topperImage),
                          fit: BoxFit.cover,
                        )
                            : const DecorationImage(
                          image: AssetImage(
                              "assets/profile2.png"),
                          fit: BoxFit.cover,
                        )),
                  );
                }
            ),
          ),
        ),
        const SizedBox(width: 10),
        SlideTransition(
          position: _offsetAnimation,
          child: Container(
            // color: Colors.red,
            alignment: Alignment.center,
            // height: 97,
            width: width-140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment:
              MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.list[currentIndex].topperName,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                    color: cl252525,
                    fontSize: 18,
                    fontFamily: 'PoppinsRegular',
                    height: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5,),
                Text(
                  "has got ${widget.list[currentIndex].transactionType} amount of",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: cl252525,
                    fontSize: 14,
                    fontFamily: 'PoppinsRegular',
                    fontWeight: FontWeight.bold,),
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "₹",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: clFF731D,
                          fontSize: 21),
                    ),
                    TextSpan(
                      text: widget.list[currentIndex]
                          .topperAmount,
                      style: const TextStyle(
                        color: Color(0xFFFF731D),
                        fontSize: 21,
                        fontFamily: 'PoppinsRegular',
                        height: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ]),
                ),


              ],
            ),
          ),
        ),
      ],
    );
  }
}



void alertSupport(context) {
  UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          contentPadding: EdgeInsets.zero,
          title: const Column(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "We're here to assist you! Feel free to use the call button for immediate help or tap "
                    "the WhatsApp button for a quick chat. Whichever you prefer, we're ready to provide the support you need.",
                    style: TextStyle(fontFamily: "PoppinsMedium", fontSize: 14),
                  )),
            ],
          ),
          content: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    launch("tel://${userProvider.contactHelpNumber}");
                    finish(context);
                  },
                  child: Container(
                    width: 115,
                    height: 40,
                    decoration: BoxDecoration(
                      // border: Border.all(color: cl64BC44,width: 1),
                      borderRadius: BorderRadius.circular(23),
                      gradient:
                          const LinearGradient(colors: [cl4389C5, cl22A2B1]),
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone_in_talk_outlined,
                            color: Colors.white, size: 20),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Call',
                          style: TextStyle(
                              fontFamily: 'PoppinsMedium',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    launch(
                        'whatsapp://send?phone=${userProvider.whatsappHelpNumber}');
                    finish(context);
                  },
                  child: Container(
                    width: 115,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                      gradient: const LinearGradient(colors: [
                        cl4389C5,
                        cl22A2B1,
                      ]),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/whatsapp.png",
                          scale: 1,
                        ),
                        // Icon(Icons.whatsapp_sharp),
                        const SizedBox(
                          width: 2,
                        ),
                        const Text(
                          'WhatsApp',
                          style: TextStyle(
                              fontFamily: 'PoppinsMedium',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
