import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants/functions.dart';
import '../../Provider/user_provider.dart';
import '../../constants/my_colors.dart';

class InvitesScreen extends StatelessWidget {
  const InvitesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFCF8),
        appBar:AppBar(
          backgroundColor: myWhite,
          elevation: 0,
          leadingWidth: 100,
          centerTitle: true,
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
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Invitees',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF2F7DC1),
                fontSize: 20,
                fontFamily: 'PoppinsRegular',
                fontWeight: FontWeight.w700,
              ),
            ),
            // child: Text("Lio Care",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Textcolor,fontFamily: "PoppinsRegular"),),
          ),
        ),


        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              // Center(
              //   child: Container(
              //     height: height / 8,
              //     width: width / 1.1,
              //     decoration: BoxDecoration(
              //         image: const DecorationImage(
              //             image: AssetImage("assets/bgContainer.png"),
              //             fit: BoxFit.cover),
              //         borderRadius: const BorderRadius.all(Radius.circular(20)),
              //         gradient: LinearGradient(
              //           colors: [
              //             textColor,
              //             cl2FC1BC,
              //
              //           ],
              //           begin: Alignment.topLeft,
              //           end: Alignment.bottomRight,
              //         )),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         SizedBox(
              //           height: height * .01,
              //         ),
              //         const Text(
              //           "Collection by Invitation",
              //           style: TextStyle(
              //               fontWeight: FontWeight.w400,
              //               fontFamily: "PoppinsRegular",
              //               fontSize: 14,
              //               color: Colors.black),
              //         ),
              //         Consumer<UserProvider>(
              //             builder: (context,va,cild) {
              //               return Text(
              //                 "₹${va.totaluserReferralTransaction.toString()}",
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.w700,
              //                     fontSize: 28,
              //                     color: clFF731D),
              //               );
              //             }
              //         ),
              //         SizedBox(
              //           height: height * .01,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              Container(
                margin: const EdgeInsets.only(left: 20.0,right: 20),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Consumer<UserProvider>(
                    builder: (context,value10,child) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children:  [
                                  const Text("Total Received",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        fontFamily: "PoppinsRegular"),),
                                  Text("₹".toString()+value10.totaluserReferralTransaction.toString(),
                                    style: const TextStyle(
                                        color: cl16B200,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        fontFamily: "PoppinsRegular"),),
                                ],
                              ),
                              Column(
                                children:  [
                                  const Text("Total Paid",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        fontFamily: "PoppinsRegular"),),
                                  Text("₹${value10.totaluserReferralOutTransaction}",
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        fontFamily: "PoppinsRegular"),),
                                ],
                              )
                            ],
                          ),
                        ],
                      );
                    }
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: width / 1.02,
                height: 50,
                // padding: const EdgeInsets.only(top: 28, left: 8, right: 8),
                decoration: const BoxDecoration(
                    color: clFFFCF8,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(22),
                        topLeft: Radius.circular(22))),
                child: SizedBox(
                  height: 10,
                  child: TabBar(
                    unselectedLabelColor: cl2F7DC1,
                    labelColor: Colors.white,
                    indicatorColor: bxkclr,
                    dragStartBehavior:DragStartBehavior.down,
                    // indicatorPadding: const EdgeInsets.only(bottom: 12,top: 12),
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // Creates border
                        color: cl2F7DC1),
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(
                        child: Container(
                          width: width / 1,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: cl2F7DC1,
                                width: 1,
                              )),
                          child: const Text("My\nReferrals",textAlign: TextAlign.center),
                        ),
                      ),
                      Tab(
                        child: Container(
                          width: width / 1,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: cl2F7DC1, width: 1)),
                          child: const Text("My Referral\nTransactions",textAlign: TextAlign.center),
                        ),
                      ),
                    ],
                  ),
                ) ,
              ),
              Container(
                width: width / 1.1,
                height: height/1.5,
                padding: const EdgeInsets.only(top: 2, left: 8, right: 8),
                decoration: const BoxDecoration(
                  color: clFFFCF8,
                ),
                child:TabBarView(
                  children: [
                    Consumer<UserProvider>(builder: (context3,value3,child) {
                      return value3.userReferenceList.isNotEmpty
                          ? ListView.builder(
                          shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          itemCount: value3.userReferenceList.length,
                          itemBuilder:
                              (BuildContext context, int index) {
                            var item = value3.userReferenceList[index];
                            return Container(
                              width: width / 1.2,
                              padding: const EdgeInsets.all(5) ,
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(25),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      item.image!=""?  CircleAvatar(
                                        radius: 18,
                                        backgroundImage: NetworkImage(item.image),
                                      ):const Icon(Icons.person_rounded),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      SizedBox(
                                        width: width / 2.6,
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
                                              style: const TextStyle(
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  fontSize: 14,
                                                  fontFamily:
                                                  "PoppinsRegular"),
                                            ),
                                            Text(
                                              "ID:${item.id}",
                                              style: const TextStyle(
                                                  fontWeight:
                                                  FontWeight.w300,
                                                  fontSize: 11,
                                                  fontFamily:
                                                  "PoppinsRegular"),
                                            ),
                                            Text(
                                              item.number,
                                              style: const TextStyle(
                                                  fontWeight:
                                                  FontWeight.w300,
                                                  fontSize: 11,
                                                  fontFamily:
                                                  "PoppinsRegular"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: width / 6,
                                        decoration: BoxDecoration(
                                            color: grdintclr2,
                                            borderRadius:
                                            BorderRadius.circular(
                                                20)),
                                        child: InkWell(
                                          onTap: () {
                                            launch("tel://${item.number}");

                                          },
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
                                          onTap: (){
                                            launch(
                                                'whatsapp://send?phone=${item.number}');
                                          },
                                          child:
                                          Container(
                                              height: 30,
                                              width: width / 6,
                                              decoration: BoxDecoration(
                                                  color: grdintclr2,
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(20)),
                                              child: const Image(
                                                  image: AssetImage(
                                                      "assets/whatsapp.png")))
                                      ) ],
                                  )
                                ],
                              ),
                            );
                          })
                          : const SizedBox(
                        height: 80,
                        child: Center(child: Text("No Referrals Yet.")),
                      );
                    }),
                    Consumer<UserProvider>(builder: (context,val40,child) {
                      return val40.userReferralTransactionList.isNotEmpty? ListView.builder(
                        itemCount: val40.userReferralTransactionList.length,
                        itemBuilder: (context, index) {
                          var item =val40.userReferralTransactionList[index];
                          return InkWell(
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              // height: 75,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 37,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 9.0),
                                        child: item.image!=""?  CircleAvatar(
                                          radius: 18,
                                          backgroundImage: NetworkImage(item.image),
                                        ): const Center(child: Icon(Icons.person_rounded)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: width-255,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(item.id,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300,
                                                color: cl5F5F5F)),
                                        Text(item.number,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300,
                                                color: cl5F5F5F)),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: 135,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Transform.rotate(
                                            angle: item.flow == "IN"
                                                ? 4
                                                : 1,
                                            child: Icon(
                                              Icons
                                                  .arrow_upward_rounded,
                                              color: item.flow == "IN"
                                                  ? cl00AD07
                                                  : clAD0000,
                                            )),
                                        Text(item.showStatus,
                                            style:  TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color:    item.showStatus=="PENDING"
                                                    ?clFA721F
                                                    :item.showStatus=="PAID"||item.showStatus=="RECEIVED"
                                                    ?cl16B200
                                                    :clAD0000)),
                                        RichText(
                                            text:  TextSpan(children: [
                                              const TextSpan(
                                                text: "Referral  Amount: ",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w300,
                                                    color: cl5F5F5F),

                                              ),
                                              const TextSpan(text: " ₹ ",  style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: cl252525
                                              )),
                                              TextSpan(text: item.amount,  style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: cBlack
                                              )),
                                            ]))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ):const SizedBox(
                        height: 80,
                        child: Center(child: Text("No Transactions Yet.")),
                      );
                    }),

                  ],) ,
              )
            ],
          ),
        ),

      ),
    );
  }
}