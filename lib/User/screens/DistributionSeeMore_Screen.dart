import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lio_care/User/screens/payment_screen.dart';
import 'package:lio_care/User/screens/pmc_distribtions.dart';
import 'package:lio_care/User/screens/ptcf_distributions.dart';
import 'package:lio_care/providers/mainProvider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants/functions.dart';
import '../../Provider/user_provider.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_texts.dart';
import '../../models/distributionModel.dart';
import 'confirmation_screen.dart';
import 'new_pmc_screen.dart';
import 'new_ptcf_screen.dart';

class DistributionSeeMoreScreen extends StatefulWidget {
  String loginId;

  DistributionSeeMoreScreen({Key? key, required this.loginId})
      : super(key: key);

  @override
  State<DistributionSeeMoreScreen> createState() =>
      _DistributionSeeMoreScreenState();
}

class _DistributionSeeMoreScreenState extends State<DistributionSeeMoreScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(initialIndex: 0, length: 3, vsync: this);
    controller.addListener(handleTabChange);
  }

  void handleTabChange() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final index = controller.index;
    setState(() {
      if (index == 0) {
        // userProvider.sortDistributionList=userProvider.masterDistributionList;
      } else if (index == 1) {
        // userProvider.sortDistributionList=userProvider.starDistributionList;
      } else {
        // userProvider.sortDistributionList=userProvider.crownDistributionList;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: bxkclr,
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          backgroundColor: bxkclr,
          leading: Image.asset(
            'assets/bluelogo.png',
            scale: 18,
          ),
          title: const Text(
            "Distribution",
            style: TextStyle(
                color: cl2F7DC1, fontWeight: FontWeight.w700, fontSize: 20),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                      userProvider.getUserDetails(widget.loginId);
                      userProvider.masterClubDistributionFiltering('', '', '');

                    },
                  child: Container(
                        width: 64,
                        height: 30,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFE9F2FF),
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
            )
          ],
          bottom: TabBar(
            controller: controller,
            unselectedLabelColor: cl2F7DC1,
            indicatorColor: bxkclr,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Creates border
                color: cl2F7DC1),
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: clF3F3F3,
            onTap: (index) {
              if (!controller.indexIsChanging) {
                // Only change the tab index if it's not already changing
                controller.animateTo(index);
              }
              if (index == 0) {
                // userProvider. assignCurrentGrade(userProvider.currentBasicGrade);
              } else if (index == 1) {
                // userProvider. assignCurrentGrade(userProvider.currentAutoOneGrade);
              } else {
                // userProvider. assignCurrentGrade(userProvider.currentAutoTwoGrade);
              }
            },
            tabs: [
              Tab(
                child: Consumer<UserProvider>(builder: (context1, va, child) {
                    return Container(
                      width: width / 1,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: va.userGrade=="VIOLET"?VIOLET
                              :va.userGrade=="INDIGO"?INDIGO
                              :va.userGrade=="BLUE"?BLUE
                              :va.userGrade=="GREEN"?GREEN
                              :va.userGrade=="YELLOW"?YELLOW
                              :va.userGrade=="ORANGE"?ORANGE
                              :va.userGrade=="RED"?RED
                              :va.userGrade=="MASTER ACHIEVER"?MASTERACHIEVER:Colors.grey,width: 2,
                          )),
                      child: const Text(
                        "Master Club",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    );
                  }
                ),
              ),
              Tab(
                child: Consumer<UserProvider>(builder: (context1, va, child) {
                    return Container(
                      width: width / 1,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: va.userAutoOneGrade=="STAR"?STAR
                              :va.userAutoOneGrade=="2 STAR"?STAR2
                              :va.userAutoOneGrade=="3 STAR"?STAR3
                              :va.userAutoOneGrade=="4 STAR"?STAR4
                              :va.userAutoOneGrade=="5 STAR"?STAR5
                              :va.userAutoOneGrade=="6 STAR"?STAR6
                              :va.userAutoOneGrade=="7 STAR"?STAR7
                              :va.userAutoOneGrade=="STAR CLUB ACHIEVER"?STARCLUBACHIEVER:Colors.grey, width: 2)),
                      child: const Text(
                        "Star Club",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    );
                  }
                ),
              ),
              Tab(
                child: Consumer<UserProvider>(builder: (context1, va, child) {
                    return Container(
                      width: width / 1,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: va.userAutoTwoGrade=="SILVER"?SILVER
                              :va.userAutoTwoGrade=="GOLD"?GOLD
                              :va.userAutoTwoGrade=="PLATINUM"?PLATINUM
                              :va.userAutoTwoGrade=="DIAMOND"?DIAMOND
                              :va.userAutoTwoGrade=="ROYAL"?ROYAL
                              :va.userAutoTwoGrade=="CROWN"?CROWN
                              :va.userAutoTwoGrade=="CROWN CLUB ACHIEVER"?CROWNCLUBACHIEVER
                              :Colors.grey, width: 2)),
                      child: const Text(
                        "Crown Club",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: [
            Consumer<UserProvider>(builder: (context4, value7, child) {
              return Column(children: [
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  // height: 35,
                  width: width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xffe9f2ff)),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      value7.userGrade.isNotEmpty
                          ?Text(
                        value7.userGrade,
                        style: const TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: cBlack),
                      ):const SizedBox(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Consumer<UserProvider>(builder: (context, val90, child) {
                            return Container(
                                // margin: const EdgeInsets.symmetric(vertical: 10),
                                // padding: EdgeInsets.symmetric(vertical: 0),
                                height: 40,
                                width: width / 3.55,
                                decoration: ShapeDecoration(
                                  color: cl5F9DF7,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(55),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x0C000000),
                                      blurRadius: 6,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: PopupMenuButton<String>(
                                  icon: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: width / 6,
                                        child: Text(
                                          value7.selectedMasterLevel,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: cWhite,
                                            fontSize: 10,
                                            fontFamily: "PoppinsRegular",
                                          ),
                                        ),
                                      ),
                                      const Icon(Icons.keyboard_arrow_down_rounded,
                                          color: cWhite),
                                    ],
                                  ),
                                  itemBuilder: (context) {
                                    return val90.allMasterlevelsItems
                                        .map((String item) {
                                      return PopupMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: cBlack,
                                            fontSize: 12,
                                            fontFamily: "PoppinsRegular",
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  onSelected: (String newValue) {
                                    value7.updateMasterLevel(newValue);
                                    // value7.masterClubDistributionFiltering('LEVEL', value7.selectedLevel, value7.selectedStatus);
                                  },
                                ));
                          }),
                          Consumer<UserProvider>(
                              builder: (context, value90, child) {
                            return Container(
                                // margin: const EdgeInsets.symmetric(vertical: 10),
                                height: 40,
                                width: width / 3.55,
                                decoration: ShapeDecoration(
                                  color: cl5F9DF7,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(55),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x0C000000),
                                      blurRadius: 6,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: PopupMenuButton<String>(
                                  icon: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width / 6,
                                        // color: Colors.red,
                                        child: Text(
                                          value7.selectedMasterStatus,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: cWhite,
                                            fontSize: 10,
                                            fontFamily: "PoppinsRegular",
                                          ),
                                        ),
                                      ),
                                      const Icon(Icons.keyboard_arrow_down_rounded,
                                          color: cWhite),
                                    ],
                                  ),
                                  itemBuilder: (context) {
                                    return value7.alllStatusItems
                                        .map((String item) {
                                      return PopupMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: cBlack,
                                            fontSize: 12,
                                            fontFamily: "PoppinsRegular",
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  onSelected: (String newValue) {
                                    value7.updateMasterStatus(newValue);
                                  },
                                ));
                          }),
                          InkWell(
                            onTap: () {
                              value7.masterClubDistributionFiltering('', '', '');
                            },
                            child: Container(
                              // margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              alignment: Alignment.center,
                              height: 40,
                              width: width / 3.55,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(55),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x0C000000),
                                    blurRadius: 6,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Clear Filter",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: cl5F9DF7,
                                      fontSize: 12,
                                      fontFamily: "PoppinsRegular",
                                    ),
                                  ),
                                  Icon(Icons.close, color: cl5F9DF7),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                // Padding(
                //   padding:  EdgeInsets.symmetric(horizontal: width/25),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Consumer<UserProvider>(
                //         builder: (context,value33,child) {
                //           return InkWell(
                //             onTap: (){
                //               // value33.filterPmcDistributionsList=value33.masterPmcDistributionsList;
                //               callNext(const NewPmcScreen(), context);
                //             },
                //             child: Container(
                //               width: width*.44,
                //               padding: const EdgeInsets.all(8),
                //               decoration: BoxDecoration(
                //                   color:textColor.withOpacity(0.8),
                //                   borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: const Color(0xFFE9F2FF))
                //
                //               ),
                //               child: Consumer<UserProvider>(
                //                   builder: (context5,value5,child) {
                //                     return Column(
                //                       children: [
                //
                //                         Row(
                //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             Text("PMC",style: pmcPtcfBox),
                //                             Text("PAID",style: pmcPtcfBox),
                //                           ],
                //                         ),
                //                         const SizedBox(height: 3,),
                //                         Row(
                //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             Text(value5.masterTotalPmcAmount.toStringAsFixed(0),style: pmcPtcfBox3,),
                //                             Text(value5.masterPmcPaid.toStringAsFixed(0),style: pmcPtcfBox3,),
                //                           ],
                //                         ),
                //                         const SizedBox(height: 3,),
                //                         Container(
                //                           height: 2,
                //                           // width: width*.42,
                //                           color: cl5F9DF7,
                //                         ),
                //                         const SizedBox(height: 3,),
                //                         Row(
                //                           mainAxisAlignment: MainAxisAlignment.start,
                //                           children: [
                //                             Text("Remaining",style:pmcPtcfBox2,),
                //                           ],
                //                         ),
                //                         const SizedBox(height: 3,),
                //                         Container(
                //                           alignment: Alignment.centerLeft,
                //                           height: 2,
                //                           color: clFFFCF8,
                //                           width: width*.44-16,
                //                           child: Container(
                //                             height: 2,
                //                             width: value5.masterTotalPmcCount!=0&&value5.masterTotalPmcPaidCount!=0
                //                                 ?((width*.44-16)*((value5.masterTotalPmcPaidCount/value5.masterTotalPmcCount)*100))/100:0,
                //                             color: clFA721F,
                //                           ),
                //                         ),
                //                         Row(
                //                           mainAxisAlignment: MainAxisAlignment.end,
                //                           children: [
                //                             Text("${value5.masterTotalPmcPaidCount}/${value5.masterTotalPmcCount}",style: pmcPtcfBox2,),
                //                           ],
                //                         ),
                //                       ],
                //                     );
                //                   }
                //               ),
                //             ),
                //           );
                //         }
                //       ),
                //       Consumer<UserProvider>(
                //         builder: (context,value44,child) {
                //           return InkWell(
                //             onTap: (){
                //               // value44.filterPtcfDistributionsList=value44.masterPtcfDistributionsList;
                //               callNext(const NewPtcfScreen(), context);
                //             },
                //             child: Container(
                //               width: width*.44,
                //               padding: const EdgeInsets.all(8),
                //               decoration: BoxDecoration(
                //                   color:textColor.withOpacity(0.8),
                //                   borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: const Color(0xFFE9F2FF))
                //
                //               ),
                //               child: Consumer<UserProvider>(
                //                   builder: (context5,value5,child) {
                //                     return Column(
                //                       children: [
                //
                //                         Row(
                //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             Text("CMF",style: pmcPtcfBox,),
                //                             Text("PAID",style: pmcPtcfBox,),
                //                           ],
                //                         ),
                //                         const SizedBox(height: 3,),
                //                         Row(
                //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             Text(value5.masterPtcfAmount.toStringAsFixed(0),style: pmcPtcfBox3,),
                //                             Text(value5.masterTotalPtcfPaid.toStringAsFixed(0),style: pmcPtcfBox3,),
                //                           ],
                //                         ),
                //                         const SizedBox(height: 3,),
                //                         Container(
                //                           height: 2,
                //                           color: cl5F9DF7,
                //                         ),
                //                         const SizedBox(height: 3,),
                //                         Row(
                //                           mainAxisAlignment: MainAxisAlignment.start,
                //                           children: [
                //                             Text("Remaining",style:pmcPtcfBox2,),
                //                           ],
                //                         ),
                //                         const SizedBox(height: 3,),
                //
                //                         Container(
                //                           alignment: Alignment.centerLeft,
                //                           height: 2,
                //                           color: clFFFCF8,
                //                           width: width*.44-16,
                //                           child: Container(
                //                             height: 2,
                //                             width: value5.masterTotalPtcfCount!=0
                //                                 ?((width*.44-16)*((value5.masterTotalPtcfPaidCount/value5.masterTotalPtcfCount)*100))/100:0,
                //                             color: clFA721F,
                //                           ),
                //                         ),
                //                         Row(
                //                           mainAxisAlignment: MainAxisAlignment.end,
                //                           children: [
                //                             Text("${value5.masterTotalPtcfPaidCount}/${value5.masterTotalPtcfCount}",style: pmcPtcfBox2,),
                //                           ],
                //                         ),
                //                       ],
                //                     );
                //                   }
                //               ),
                //             ),
                //           );
                //         }
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),

                // Consumer<UserProvider>(
                //     builder: (context, val565, child) {
                //       // Filter the list based on the selected status
                //
                //
                //       return Flexible (
                //         fit: FlexFit.tight,
                //         child: SizedBox(
                //           width: width,
                //           child: val565.masterDistributionList.isNotEmpty
                //               ? ListView.builder(
                //             shrinkWrap: true,
                //             padding: const EdgeInsets.only(left: 8, right: 8),
                //             itemCount: val565.masterDistributionList.length,
                //             itemBuilder: (BuildContext context, int index) {
                //               DistributionModel item = val565.masterDistributionList[index];
                //               // Your existing list item UI code
                //               return InkWell(
                //                   onTap: () {
                //                     // Handle item tap
                //                   },
                //                   child:
                //                   Container(
                //                     width: width / 1.1,
                //                     clipBehavior: Clip.antiAlias,
                //                     decoration: BoxDecoration(color: bck),
                //                     child: Column(
                //                       children: [
                //                         Row(
                //                           mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             item.proImage!=
                //                                 ""
                //                                 ? CircleAvatar(
                //                               radius: 20,
                //                               backgroundImage:
                //                               NetworkImage(item.proImage),
                //                             )
                //                                 : const CircleAvatar(
                //                               radius: 20,
                //                               backgroundColor: Colors.transparent,
                //                               child: Icon(
                //                                 Icons.person_rounded,color: Colors.black,),
                //                             ),
                //                             SizedBox(
                //                               width: width / 2.3,
                //                               child: Column(
                //                                 crossAxisAlignment:
                //                                 CrossAxisAlignment.start,
                //                                 mainAxisAlignment:
                //                                 MainAxisAlignment.center,
                //                                 children: [
                //                                   Text(
                //                                     item.name,
                //                                     style: const TextStyle(
                //                                         fontWeight:
                //                                         FontWeight.w600,
                //                                         fontSize: 14),
                //                                     overflow: TextOverflow.ellipsis,
                //                                     maxLines: 1,
                //                                   ),
                //                                   Text(
                //
                //                                     // item.tree=="MASTER_CLUB"?item.tree:"${item.tree}_TREE",
                //                                     item.tree,
                //                                     style:  const TextStyle(
                //                                         fontWeight: FontWeight.w500, fontSize: 10,
                //                                         color: cl7aefba),
                //                                   ),
                //                                   Text(
                //                                     item.fromGrade,
                //                                     style:  const TextStyle(
                //                                         fontWeight: FontWeight.w300, fontSize: 10,
                //                                         color: cl7aefba),
                //                                   ),
                //                                 ],
                //                               ),
                //                             ),
                //                             SizedBox(
                //                               // height: 60,
                //                               width: width / 3.2,
                //                               child: Padding(
                //                                 padding:
                //                                 const EdgeInsets.all(8.0),
                //                                 child: Column(
                //                                   crossAxisAlignment:
                //                                   CrossAxisAlignment.end,
                //                                   mainAxisAlignment:
                //                                   MainAxisAlignment.center,
                //                                   children: [
                //                                     Text(item.type,
                //                                       style: const TextStyle(
                //                                           fontWeight:
                //                                           FontWeight.w400,
                //                                           fontSize: 10),
                //                                     ),
                //                                     Text(
                //                                         item.status,
                //                                         style: TextStyle(
                //                                             color: item.status !=
                //                                                 "PAID"
                //                                                 ? clFFA500
                //                                                 : cl16B200)),
                //                                     Text(
                //                                       "₹${item.amount}",
                //                                       style: const TextStyle(
                //                                           fontWeight:
                //                                           FontWeight.w600,
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
                //                           MainAxisAlignment.center,
                //                           children: [
                //                             InkWell(
                //                               onTap: () {
                //                                 launch(
                //                                     "tel://${item.phoneNumber}");
                //                               },
                //                               child: Container(
                //                                 height: 28,
                //                                 width: width / 6,
                //                                 decoration: BoxDecoration(
                //                                     color: grdintclr2,
                //                                     borderRadius:
                //                                     BorderRadius.circular(
                //                                         20)),
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
                //                                     'whatsapp://send?phone=${item.phoneNumber}');
                //                               },
                //                               child: Container(
                //                                   height: 30,
                //                                   width: width / 6,
                //                                   decoration: BoxDecoration(
                //                                       color: grdintclr2,
                //                                       borderRadius:
                //                                       BorderRadius
                //                                           .circular(20)),
                //                                   child: const Image(
                //                                       image: AssetImage(
                //                                           "assets/whatsapp.png"))),
                //                             ),
                //                             SizedBox(
                //                               width: width * .04,
                //                             ),
                //                             InkWell(
                //                               onTap: () {
                //                                 launch(
                //                                     'https://telegram.me/+91${item.phoneNumber}');
                //                               },
                //                               child: Container(
                //                                   height: 30,
                //                                   width: width / 6,
                //                                   decoration: BoxDecoration(
                //                                       color: grdintclr2,
                //                                       borderRadius:
                //                                       BorderRadius
                //                                           .circular(20)),
                //                                   child: const Icon(
                //                                     Icons.telegram,
                //                                     color: cl3E6FCF,
                //                                     size: 18,
                //                                   )),
                //                             )
                //                           ],
                //                         ),
                //                         const SizedBox(height: 10,)
                //                       ],
                //                     ),
                //                   )
                //
                //               );
                //             },
                //           )
                //               : const Center(
                //             child: Text('No items found for the selected status'),
                //           ),
                //         ),
                //       );}),
                Consumer<UserProvider>(builder: (context, val565, child) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: SizedBox(
                      width: width,
                      // height:val565.hideFilterBool?height/1.9: height/1.5,
                      child: val565.masterDistributionList.isNotEmpty
                          ?  ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                          ),
                          itemCount: val565.masterDistributionList.length,
                          itemBuilder: (BuildContext context, int index) {
                            DistributionModel item =
                            val565.masterDistributionList[index];
                            return InkWell(
                              onTap: () async {
                                print("gggeeeeee ${item.distributionId}");
                                print("gggccvccc ${item.toDocId}");
                                print("gggeretbbbb ${item.toId}");
                                db
                                    .collection(item.tree)
                                    .doc(item.toDocId)
                                    .get()
                                    .then((toValue) async {
                                  Map<dynamic, dynamic> toMap =
                                  toValue.data() as Map;
                                  // print("from grade : ${item.fromGrade}, to grade : ${toMap["GRADE"]??""}, to status ${toMap["STATUS"]??""}");

                                  if (item.status != "PAID") {
                                    if (item.screenShot == "") {
                                      bool levelCheck =
                                      await val565.checkLevelStatus(
                                          item.fromGrade,
                                          toMap["GRADE"] ?? "",
                                          toMap["STATUS"] ?? "",
                                          item.toId,
                                          toMap["TYPE"] ?? "",
                                          context);
                                      if (levelCheck) {

                                        if (item.type == "STAR_CLUB" ||
                                            item.type == "CROWN_CLUB") {
                                          bool checkKycOrCount =
                                          await val565
                                              .checkKycStatusAndChild(
                                              val565.kycStatus,
                                              item.fromGrade,item.type,
                                              context);
                                          if (checkKycOrCount == false) {
                                            val565.kycChildCountAlert(
                                                context, item.phoneNumber,item.type);
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
                                                        )
                                                            :Container(
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
                                          print("entry printttttt");
                                          val565.upiCopyBool=false;
                                          callNext(
                                              PaymentScreen(
                                                userUpgradeId: item.toId,
                                                userUpgradeName: item.name,
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
                                                userPaymentType: item.type,
                                                userUpgradeGrade:
                                                item.fromGrade,
                                                userUpgradeTree: item.tree,
                                                distributionId:
                                                item.distributionId,
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
                                            phoneNumber: item.phoneNumber,
                                            date: "",
                                            time: "",
                                            regId: item.toId,
                                            image: item.proImage,
                                            screenShot: item.screenShot,
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
                                  }
                                });
                              },
                              child: Container(
                                width: width / 1.1,
                                clipBehavior: Clip.antiAlias,
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: ShapeDecoration(
                                  color: Color(0xFFFFFCF8),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1, color: Color(0xFFECECEC)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  shadows: [
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
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        item.proImage != ""
                                            ? CircleAvatar(
                                          radius: 20,
                                          backgroundImage:
                                          NetworkImage(
                                              item.proImage),
                                        )
                                            :  CircleAvatar(
                                          radius: 20,
                                          backgroundColor:
                                          Colors.transparent,
                                          child: Icon(
                                              Icons
                                                  .account_circle_outlined,
                                              color: grdintclr1
                                          ),
                                        ),
                                        SizedBox(
                                          width: width / 2.3,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                item.name,
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontSize: 14),
                                                overflow:
                                                TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              Text(
                                                // item.tree=="MASTER_CLUB"?item.tree:"${item.tree}_TREE",
                                                item.tree,
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    fontSize: 10,
                                                    color: cl7aefba),
                                              ),
                                              Text(
                                                item.fromGrade,
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.w300,
                                                    fontSize: 10,
                                                    color: cl7aefba),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          // height: 60,
                                          width: width / 3.2,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  item.type,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize: 10),
                                                ),
                                                Text(item.status,
                                                    style: TextStyle(
                                                        color: item.status ==
                                                            "PENDING"
                                                            ? clFA721F
                                                            : item.status ==
                                                            "PAID"
                                                            ? cl16B200
                                                            : item.status ==
                                                            "PROCESSING"?cl00369F:clAD0000)),
                                                Text(
                                                  "₹${item.amount}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.w600,
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
                                            width: width / 6,
                                            decoration: BoxDecoration(
                                                color: grdintclr2,
                                                borderRadius:
                                                BorderRadius.circular(
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
                                              width: width / 6,
                                              decoration: BoxDecoration(
                                                  color: grdintclr2,
                                                  borderRadius:
                                                  BorderRadius.circular(
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
                                              width: width / 6,
                                              decoration: BoxDecoration(
                                                  color: grdintclr2,
                                                  borderRadius:
                                                  BorderRadius.circular(
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
                          })
                          : const SizedBox(
                              height: 80,
                              child: Center(
                                  child: Text(
                                      "No Master Club Distributions Yet.")),
                            ),
                    ),
                  );
                }),
              ]);
            }), // MASTER CLUB
            Consumer<UserProvider>(builder: (context, value7, child) {
              return Column(children: [
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  // height: 35,
                  width: width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xffe9f2ff)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      value7.userAutoOneGrade.isNotEmpty
                          ?Text(
                        value7.userAutoOneGrade,
                        style: const TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: cBlack),
                      ):const SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Consumer<UserProvider>(builder: (context, val90, child) {
                            return Container(
                                height: 40,
                                width: width / 3.55,
                                decoration: ShapeDecoration(
                                  color: cl5F9DF7,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(55),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x0C000000),
                                      blurRadius: 6,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: PopupMenuButton<String>(
                                  icon: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: width / 6,
                                        child: Text(value7.selectedStarLevel,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: cWhite,
                                              fontSize: 10,
                                              fontFamily: "PoppinsRegular",
                                            )),
                                      ),
                                      const Icon(Icons.keyboard_arrow_down_rounded,
                                          color: cWhite),
                                    ],
                                  ),
                                  itemBuilder: (context) {
                                    return val90.allStarLevelItems
                                        .map((String item) {
                                      return PopupMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: cBlack,
                                            fontSize: 12,
                                            fontFamily: "PoppinsRegular",
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  onSelected: (String newValue) {
                                    value7.updateStarLevel(newValue);
                                    // value7.masterClubDistributionFiltering('LEVEL', value7.selectedLevel, value7.selectedStatus);
                                  },
                                ));
                          }),
                          Consumer<UserProvider>(
                              builder: (context, value90, child) {
                            return Container(
                                height: 40,
                                width: width / 3.55,
                                decoration: ShapeDecoration(
                                  color: cl5F9DF7,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(55),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x0C000000),
                                      blurRadius: 6,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: PopupMenuButton<String>(
                                  icon: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width / 6,
                                        // color: Colors.red,
                                        child: Text(
                                          value7.selectedStarStatus,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: cWhite,
                                            fontSize: 10,
                                            fontFamily: "PoppinsRegular",
                                          ),
                                        ),
                                      ),
                                      const Icon(Icons.keyboard_arrow_down_rounded,
                                          color: cWhite),
                                    ],
                                  ),
                                  itemBuilder: (context) {
                                    return value7.alllStatusItems
                                        .map((String item) {
                                      return PopupMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: cBlack,
                                            fontSize: 12,
                                            fontFamily: "PoppinsRegular",
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  onSelected: (String newValue) {
                                    value7.updateStarStatus(newValue);
                                  },
                                ));
                          }),
                          InkWell(
                            onTap: () {
                              value7.starClubDistributionFiltering('', '', '');
                            },
                            child: Container(
                              // margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              alignment: Alignment.center,
                              height: 40,
                              width: width / 3.55,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(55),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x0C000000),
                                    blurRadius: 6,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Clear Filter",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: cl5F9DF7,
                                      fontSize: 12,
                                      fontFamily: "PoppinsRegular",
                                    ),
                                  ),
                                  Icon(Icons.close, color: cl5F9DF7),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Consumer<UserProvider>(builder: (context, val565, child) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: SizedBox(
                      width: width,
                      // height:val565.hideFilterBool?height/1.9: height/1.5,
                      child: val565.starDistributionList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              itemCount: val565.starDistributionList.length,
                              itemBuilder: (BuildContext context, int index) {
                                DistributionModel item =
                                    val565.starDistributionList[index];
                                return InkWell(
                                  onTap: () async {

                                    print("doc id : ${item.distributionId}");
                                    db
                                        .collection(item.tree)
                                        .doc(item.toDocId)
                                        .get()
                                        .then((toValue) async {
                                      Map<dynamic, dynamic> toMap =
                                          toValue.data() as Map;
                                      // print("from grade : ${item.fromGrade}, to grade : ${toMap["GRADE"]??""}, to status ${toMap["STATUS"]??""}");

                                      if (item.status != "PAID") {
                                        if (item.screenShot == "") {
                                          bool levelCheck =
                                              await val565.checkLevelStatus(
                                                  item.fromGrade,
                                                  toMap["GRADE"] ?? "",
                                                  toMap["STATUS"] ?? "",
                                                  item.toId,
                                                  toMap["TYPE"] ?? "",
                                                  context);
                                          if (levelCheck) {
                                            val565.upiCopyBool=false;
                                            callNext(
                                                PaymentScreen(
                                                  userUpgradeId: item.toId,
                                                  userUpgradeName: item.name,
                                                  userUpgradeNumber:
                                                      item.phoneNumber,
                                                  userUpgradeProfileImage:
                                                      item.proImage,
                                                  userUpgradeAmount:
                                                      item.amount,
                                                  userUpgradeStatus:
                                                      item.status,
                                                  userUpgradeUpiID: item.upiId,
                                                  userPaymentType: item.type,
                                                  userUpgradeGrade:
                                                      item.fromGrade,
                                                  userUpgradeTree: item.tree,
                                                  distributionId:
                                                      item.distributionId,
                                                ),
                                                context);
                                          } else {
                                            val565.restrictionAlert(
                                                context, item.name);
                                          }
                                        } else {
                                          callNext(
                                              ConfirmationScreen(
                                                name: item.name,
                                                phoneNumber: item.phoneNumber,
                                                date: "",
                                                time: "",
                                                regId: item.toId,
                                                image: item.proImage,
                                                screenShot: item.screenShot,
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
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: width / 1.1,
                                    clipBehavior: Clip.antiAlias,
                                    margin: EdgeInsets.only(bottom: 5),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFFFFCF8),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(width: 1, color: Color(0xFFECECEC)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      shadows: [
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            item.proImage != ""
                                                ? CircleAvatar(
                                                    radius: 20,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            item.proImage),
                                                  )
                                                :  CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child: Icon(
                                                        Icons
                                                            .account_circle_outlined,
                                                        color: grdintclr1
                                                    ),
                                                  ),
                                            SizedBox(
                                              width: width / 2.3,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    item.name,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                  Text(
                                                    // item.tree=="MASTER_CLUB"?item.tree:"${item.tree}_TREE",
                                                    item.tree,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10,
                                                        color: cl22A2B1),
                                                  ),
                                                  Text(
                                                    item.fromGrade,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 10,
                                                        color: cl22A2B1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              // height: 60,
                                              width: width / 3.2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "HELP",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 10),
                                                    ),
                                                    Text(item.status,
                                                        style: TextStyle(
                                                            color: item.status ==
                                                                "PENDING"
                                                                ? clFA721F
                                                                : item.status ==
                                                                "PAID"
                                                                ? cl16B200
                                                                : item.status ==
                                                                "PROCESSING"?cl00369F:clAD0000)),
                                                    Text(
                                                      "₹${item.amount}",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                                width: width / 6,
                                                decoration: BoxDecoration(
                                                    color: grdintclr2,
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                                                  width: width / 6,
                                                  decoration: BoxDecoration(
                                                      color: grdintclr2,
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                                  width: width / 6,
                                                  decoration: BoxDecoration(
                                                      color: grdintclr2,
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                              })
                          : const SizedBox(
                              height: 80,
                              child: Center(
                                  child:
                                      Text("No Star Club Distributions Yet.")),
                            ),
                    ),
                  );
                }),
              ]);
            }),
            Consumer<UserProvider>(builder: (context, value7, child) {
              return Column(children: [
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  // height: 35,
                  width: width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xffe9f2ff)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      value7.userAutoTwoGrade.isNotEmpty
                      ?Text(
                        value7.userAutoTwoGrade,
                        style: const TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: cBlack),
                      ):const SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Consumer<UserProvider>(builder: (context, val90, child) {
                            return Container(
                                height: 40,
                                width: width / 3.55,
                                decoration: ShapeDecoration(
                                  color: cl5F9DF7,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(55),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x0C000000),
                                      blurRadius: 6,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: PopupMenuButton<String>(
                                  icon: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: width / 6,
                                        child: Text(
                                          value7.selectedCrownLevel,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: cWhite,
                                            fontSize: 10,
                                            fontFamily: "PoppinsRegular",
                                          ),
                                        ),
                                      ),
                                      const Icon(Icons.keyboard_arrow_down_rounded,
                                          color: cWhite),
                                    ],
                                  ),
                                  itemBuilder: (context) {
                                    return val90.allCrownLevelItems
                                        .map((String item) {
                                      return PopupMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: cBlack,
                                            fontSize: 12,
                                            fontFamily: "PoppinsRegular",
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  onSelected: (String newValue) {
                                    value7.updateCrownLevel(newValue);
                                    // value7.masterClubDistributionFiltering('LEVEL', value7.selectedLevel, value7.selectedStatus);
                                  },
                                ));
                          }),
                          Consumer<UserProvider>(
                              builder: (context, value90, child) {
                            return Container(
                                height: 40,
                                width: width / 3.55,
                                decoration: ShapeDecoration(
                                  color: cl5F9DF7,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(55),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x0C000000),
                                      blurRadius: 6,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: PopupMenuButton<String>(
                                  icon: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: width / 6,
                                        // color: Colors.red,
                                        child: Text(
                                          value7.selectedCrownStatus,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: cWhite,
                                            fontSize: 10,
                                            fontFamily: "PoppinsRegular",
                                          ),
                                        ),
                                      ),
                                      const Icon(Icons.keyboard_arrow_down_rounded,
                                          color: cWhite),
                                    ],
                                  ),
                                  itemBuilder: (context) {
                                    return value7.alllStatusItems
                                        .map((String item) {
                                      return PopupMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: cBlack,
                                            fontSize: 12,
                                            fontFamily: "PoppinsRegular",
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  onSelected: (String newValue) {
                                    value7.updateCrownStatus(newValue);
                                  },
                                ));
                          }),
                          InkWell(
                            onTap: () {
                              value7.crownClubDistributionFiltering('', '', '');
                            },
                            child: Container(
                              // margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              alignment: Alignment.center,
                              height: 40,
                              width: width / 3.55,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(55),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x0C000000),
                                    blurRadius: 6,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Clear Filter",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: cl5F9DF7,
                                      fontSize: 12,
                                      fontFamily: "PoppinsRegular",
                                    ),
                                  ),
                                  Icon(Icons.close, color: cl5F9DF7),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Consumer<UserProvider>(builder: (context, val565, child) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: SizedBox(
                      width: width,
                      // height:val565.hideFilterBool?height/1.9: height/1.5,
                      child: val565.crownDistributionList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              itemCount: val565.crownDistributionList.length,
                              itemBuilder: (BuildContext context, int index) {
                                DistributionModel item =
                                    val565.crownDistributionList[index];
                                return InkWell(
                                  onTap: () async {
                                    db
                                        .collection(item.tree)
                                        .doc(item.toDocId)
                                        .get()
                                        .then((toValue) async {
                                      Map<dynamic, dynamic> toMap =
                                          toValue.data() as Map;
                                      // print("from grade : ${item.fromGrade}, to grade : ${toMap["GRADE"]??""}, to status ${toMap["STATUS"]??""}");

                                      if (item.status != "PAID") {
                                        if (item.screenShot == "") {
                                          bool levelCheck =
                                              await val565.checkLevelStatus(
                                                  item.fromGrade,
                                                  toMap["GRADE"] ?? "",
                                                  toMap["STATUS"] ?? "",
                                                  item.toId,
                                                  toMap["TYPE"] ?? "",
                                                  context);
                                          if (levelCheck) {
                                            val565.upiCopyBool=false;
                                            callNext(
                                                PaymentScreen(
                                                  userUpgradeId: item.toId,
                                                  userUpgradeName: item.name,
                                                  userUpgradeNumber:
                                                      item.phoneNumber,
                                                  userUpgradeProfileImage:
                                                      item.proImage,
                                                  userUpgradeAmount:
                                                      item.amount,
                                                  userUpgradeStatus:
                                                      item.status,
                                                  userUpgradeUpiID: item.upiId,
                                                  userPaymentType: item.type,
                                                  userUpgradeGrade:
                                                      item.fromGrade,
                                                  userUpgradeTree: item.tree,
                                                  distributionId:
                                                      item.distributionId,
                                                ),
                                                context);
                                          } else {
                                            val565.restrictionAlert(
                                                context, item.name);
                                          }
                                        } else {
                                          callNext(
                                              ConfirmationScreen(
                                                name: item.name,
                                                phoneNumber: item.phoneNumber,
                                                date: "",
                                                time: "",
                                                regId: item.toId,
                                                image: item.proImage,
                                                screenShot: item.screenShot,
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
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: width / 1.1,
                                    clipBehavior: Clip.antiAlias,
                                    margin: EdgeInsets.only(bottom: 5),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFFFFCF8),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(width: 1, color: Color(0xFFECECEC)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      shadows: [
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            item.proImage != ""
                                                ? CircleAvatar(
                                                    radius: 20,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            item.proImage),
                                                  )
                                                :  CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child: Icon(
                                                        Icons
                                                            .account_circle_outlined,
                                                        color: grdintclr1
                                                    ),
                                                  ),
                                            SizedBox(
                                              width: width / 2.3,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    item.name,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                  Text(
                                                    // item.tree=="MASTER_CLUB"?item.tree:"${item.tree}_TREE",
                                                    item.tree,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10,
                                                        color: cl00369F),
                                                  ),
                                                  Text(
                                                    item.fromGrade,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 10,
                                                        color: cl00369F),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              // height: 60,
                                              width: width / 3.2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "HELP",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 10),
                                                    ),
                                                    Text(item.status,
                                                        style: TextStyle(
                                                            color: item.status ==
                                                                "PENDING"
                                                                ? clFA721F
                                                                : item.status ==
                                                                "PAID"
                                                                ? cl16B200
                                                                : item.status ==
                                                                "PROCESSING"?cl00369F:clAD0000)),
                                                    Text(
                                                      "₹${item.amount}",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                                width: width / 6,
                                                decoration: BoxDecoration(
                                                    color: grdintclr2,
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                                                  width: width / 6,
                                                  decoration: BoxDecoration(
                                                      color: grdintclr2,
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                                  width: width / 6,
                                                  decoration: BoxDecoration(
                                                      color: grdintclr2,
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                              })
                          : const SizedBox(
                              height: 80,
                              child: Center(
                                  child:
                                      Text("No Crown Club Distributions Yet.")),
                            ),
                    ),
                  );
                }),
              ]);
            }),
          ],
        ),
      ),
    );
  }
}
