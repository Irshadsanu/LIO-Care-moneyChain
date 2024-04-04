import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lio_care/Constants/functions.dart';
import 'package:lio_care/constants/my_colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Provider/user_provider.dart';
import 'approveImageScreen.dart';

class MyReferrals extends StatelessWidget {
  const MyReferrals({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bxkclr,
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: bxkclr,
        leading: Image.asset(
          'assets/bluelogo.png',
          scale: 18,
        ),
        title: Consumer<UserProvider>(builder: (context1, val1, child) {
          return const Text(
            "Referral Income",
            style: TextStyle(
                color: cl2F7DC1, fontWeight: FontWeight.w700, fontSize: 20),
          );
        }),
        actions: [
          Consumer<UserProvider>(builder: (context1, val1, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      val1.fetchInReferralTransactions(val1.registerID);
                    },
                    child: Container(
                        width: 64,
                        height: 30,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFE9F2FF)  ,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Refresh',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFFF731C),
                                fontSize: 9,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                            Icon(
                              Icons.refresh,
                              color: Colors.black,
                              size: 15,
                            ),
                          ],
                        )),
                  ),
                ),
              );
            }
          )
        ],
        centerTitle: true,
        // actions: [
        //   widget.admin?Consumer<UserProvider>(builder: (context1, val1, child) {
        //     return InkWell(
        //         onTap: (){
        //           val1.logOutAlert(context,true);
        //         },
        //         child: const Icon(Icons.logout));
        //   }
        //   ):const SizedBox(),
        //
        //   widget.admin? const SizedBox(width: 9,):const SizedBox(),
        //
        //   Padding(
        //     padding: const EdgeInsets.only(right: 20),
        //     child: Container(
        //       color: Colors.transparent,
        //       alignment: Alignment.center,
        //       child: InkWell(
        //         onTap: () {
        //           userProvider.fetchInTransactions(widget.loginId);
        //         },
        //         child: Container(
        //             width: 64,
        //             height: 30,
        //             clipBehavior: Clip.antiAlias,
        //             decoration: ShapeDecoration(
        //               color: const Color(0xFFE9F2FF)  ,
        //               shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(6)),
        //             ),
        //             child: const Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   'Refresh',
        //                   textAlign: TextAlign.center,
        //                   style: TextStyle(
        //                     color: Color(0xFFFF731C),
        //                     fontSize: 9,
        //                     fontFamily: 'Inter',
        //                     fontWeight: FontWeight.w600,
        //                     height: 0,
        //                   ),
        //                 ),
        //                 Icon(
        //                   Icons.refresh,
        //                   color: Colors.black,
        //                   size: 15,
        //                 ),
        //               ],
        //             )),
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child:Consumer<UserProvider>(
              builder: (context3, value3, child) {
                return value3.referralList.isNotEmpty
                    ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                    ),
                    itemCount: value3.referralList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = value3.referralList[index];
                      return Padding(
                        padding:
                        const EdgeInsets.only(bottom: 10.0),
                        child: InkWell(
                            onTap: () async {
                              if (item.screenShot != "" &&
                                  item.status == "PROCESSING") {
                              var toValue =  await db
                                  .collection("DISTRIBUTIONS")
                                  .doc(item.id)
                                  .get();
                              // .then((toValue) async {
                                Map<dynamic, dynamic> toMap =
                                toValue.data() as Map;
                                String userIncomeStatus =
                                toMap["STATUS"].toString();
                                if (userIncomeStatus == "PROCESSING") {
                                  callNext(
                                      ApproveImageScreen(
                                        name: item.name,
                                        number: item.number,
                                        id: item.memberId,
                                        date: item.date,
                                        time: item.time,
                                        image: item.image,
                                        screenShort: item.screenShot,
                                        distributionId: item.id,
                                        grade: item.grade,
                                        amount: item.amount,
                                        paymentType: item.paymentType,
                                        tree: item.tree,
                                        userDocId: item.userDoc,
                                      ),
                                      context);
                                }}
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
                                  color: Color(0xFFFFFCF8),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1, color: Color(0xFFECECEC)),
                                    borderRadius: BorderRadius.circular(10),
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
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: item.image != ""
                                              ? CircleAvatar(
                                            radius: 20,
                                            backgroundImage:
                                            NetworkImage(item
                                                .image),
                                          )
                                              :  CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                            Colors
                                                .transparent,
                                            child: Icon(
                                                Icons
                                                    .account_circle_outlined,
                                                color: grdintclr1
                                            ),
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
                                                          : item.status ==
                                                          "PROCESSING"?cl00369F:clAD0000)),
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
      ),
    );
  }
}
