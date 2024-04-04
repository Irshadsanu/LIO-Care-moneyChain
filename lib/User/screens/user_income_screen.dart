import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lio_care/Constants/functions.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants/functions.dart';
import '../../Provider/user_provider.dart';
import '../../constants/my_colors.dart';
import 'approveImageScreen.dart';

class IncomeScreen extends StatefulWidget {
  String loginId;
  bool admin;

  IncomeScreen({Key? key, required this.loginId,required this.admin}) : super(key: key);

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(initialIndex: 0, length: 3, vsync: this);
    controller.addListener(_handleTabChange);
  }

  void openEndDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _handleTabChange() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final index = controller.index;
    if (index == 0) {
      userProvider.assignCurrentGrade(userProvider.currentBasicGrade);
    } else if (index == 1) {
      userProvider.assignCurrentGrade(userProvider.currentAutoOneGrade);
    } else {
      userProvider.assignCurrentGrade(userProvider.currentAutoTwoGrade);
    }
  }

  @override
  void dispose() {
    controller.removeListener(_handleTabChange);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: (){
      if(widget.admin) {
        return userProvider.logOutAlert(context, true);
      }else{
        return   userProvider.finishFaz(context);
      }
      },
      child: Scaffold(
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
              "Club Income",
              style: TextStyle(
                  color: cl2F7DC1, fontWeight: FontWeight.w700, fontSize: 20),
            );
          }),
          centerTitle: true,
          actions: [
            widget.admin?Consumer<UserProvider>(builder: (context1, val1, child) {
                return InkWell(
                    onTap: (){
                      val1.logOutAlert(context,true);
                    },
                    child: const Icon(Icons.logout));
              }
            ):const SizedBox(),

            widget.admin? const SizedBox(width: 9,):const SizedBox(),

            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    userProvider.fetchInTransactions(widget.loginId);
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
                userProvider.assignCurrentGrade(userProvider.currentBasicGrade);
              } else if (index == 1) {
                userProvider.assignCurrentGrade(userProvider.currentAutoOneGrade);
              } else {
                userProvider.assignCurrentGrade(userProvider.currentAutoTwoGrade);
              }
            },
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
                ),
              ),
              Tab(
                child: Container(
                  width: width / 1,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: cl2F7DC1, width: 1)),
                  child: const Text(
                    "Star Club",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),                ),
                ),
              ),
              Tab(
                child: Container(
                  width: width / 1,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: cl2F7DC1, width: 1)),
                  child: const Text(
                    "Crown Club",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),                ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(controller: controller, children: [
          Consumer<UserProvider>(builder: (context, value10, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Consumer<UserProvider>(
                //       builder: (context44, val44, child) {
                //         return SizedBox(
                //           width: 105,
                //           child: PopupMenuButton<String>(
                //             icon: Row(
                //               children: [
                //                 Text(
                //                   val44.selectedIncome,
                //                   style: const TextStyle(
                //                     fontWeight: FontWeight.w400,
                //                     color: cBlack,
                //                     fontSize: 12,
                //                     fontFamily: "PoppinsRegular",
                //                   ),
                //                 ),
                //                 const Icon(Icons.keyboard_arrow_down_rounded),
                //               ],
                //             ),
                //             itemBuilder: (context) {
                //               return val44.incomeStatusList.map((String item) {
                //                 return PopupMenuItem<String>(
                //                   value: item,
                //                   child: Text(
                //                     item,
                //                     style: const TextStyle(
                //                       fontWeight: FontWeight.w400,
                //                       color: cBlack,
                //                       fontSize: 12,
                //                       fontFamily: "PoppinsRegular",
                //                     ),
                //                   ),
                //                 );
                //               }).toList();
                //             },
                //             onSelected: (String newValue) {
                //               val44.incomeStatusFilter(newValue);
                //             },
                //           ),
                //         );
                //       },
                //     ),
                //
                //     // Consumer<UserProvider>(builder: (context, val44, child) {
                //     //   return DropdownButton<String>(
                //     //     icon: const Icon(Icons.keyboard_arrow_down_rounded),
                //     //     elevation: 0,
                //     //     style: const TextStyle(
                //     //       fontWeight: FontWeight.w400,
                //     //       color: cBlack,
                //     //       fontSize: 12,
                //     //       fontFamily: "PoppinsRegular",
                //     //     ),
                //     //     value: val44.selectedIncome,
                //     //     onChanged: (String? newValue) {
                //     //       val44.incomeStatusFilter(newValue!);
                //     //     },
                //     //     items: val44.incomeStatusList.map((String item) {
                //     //       return DropdownMenuItem<String>(
                //     //         value: item,
                //     //         child: Text(item),
                //     //       );
                //     //     }).toList(),
                //     //   );
                //     // }),
                //
                //     // Consumer<UserProvider>(builder: (context, val54, child) {
                //     //   return DropdownButton<String>(
                //     //     icon: const Icon(Icons.keyboard_arrow_down_rounded),
                //     //     elevation: 0,
                //     //     style: const TextStyle(
                //     //       fontWeight: FontWeight.w400,
                //     //       color: cBlack,
                //     //       fontSize: 12,
                //     //       fontFamily: "PoppinsRegular",
                //     //     ),
                //     //     value: val54.selectedLevel,
                //     //     onChanged: (String? newValue) {
                //     //       val54.incomeLevelFilter(newValue!);
                //     //     },
                //     //     items: val54.incomeLevelList.map((String item) {
                //     //       return DropdownMenuItem<String>(
                //     //         value: item,
                //     //         child: Text(item),
                //     //       );
                //     //     }).toList(),
                //     //   );
                //     // }),
                //     Consumer<UserProvider>(
                //       builder: (context54, val54, child) {
                //         return SizedBox(
                //           width: 105,
                //           child: PopupMenuButton<String>(
                //             icon: Row(
                //               children: [
                //                 Text(
                //                   val54.selectedLevel,
                //                   style: const TextStyle(
                //                     fontWeight: FontWeight.w400,
                //                     color: cBlack,
                //                     fontSize: 12,
                //                     fontFamily: "PoppinsRegular",
                //                   ),
                //                 ),
                //                 const Icon(Icons.keyboard_arrow_down_rounded),
                //               ],
                //             ),
                //             itemBuilder: (context) {
                //               return val54.incomeLevelList.map((String item) {
                //                 return PopupMenuItem<String>(
                //                   value: item,
                //                   child: Text(
                //                     item,
                //                     style: const TextStyle(
                //                       fontWeight: FontWeight.w400,
                //                       color: cBlack,
                //                       fontSize: 12,
                //                       fontFamily: "PoppinsRegular",
                //                     ),
                //                   ),
                //                 );
                //               }).toList();
                //             },
                //             onSelected: (String newValue) {
                //               val54.incomeLevelFilter(newValue);
                //             },
                //           ),
                //         );
                //       },
                //     ),
                //     const SizedBox(
                //       width: 15,
                //     )
                //   ],
                // ),
                Flexible(
                  fit: FlexFit.tight,
                  child: SizedBox(
                    width: width / 1.01,
                    child: Consumer<UserProvider>(
                        builder: (context3, value3, child) {
                      return value3.filterIncomeMasterList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              itemCount: value3.filterIncomeMasterList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var item = value3.filterIncomeMasterList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
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
                                                  screenShort: item.screenShot,
                                                  distributionId: item.id,
                                                  grade: item.grade,
                                                  amount: item.amount,
                                                  paymentType: item.paymentType,
                                                  tree: item.tree,
                                                  userDocId: item.userDoc,
                                                ),
                                                context);
                                          }
                                          // });
                                        } },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFFFFCF8),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                width: 1,
                                                color: Color(0xFFECECEC)),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          shadows: [
                                            const BoxShadow(
                                              color: Color(0x1E7C7C7C),
                                              blurRadius: 5,
                                              offset: Offset(0, 0),
                                              spreadRadius: 0,
                                            )
                                          ],
                                        ),
                                        // height: ,
                                        width: width,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 11,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.name,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          height: 1.3,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(item.tree,
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            height: 1.3,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: cl252525)),
                                                    Text(item.grade,
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            height: 1.3,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: cl5F5F5F)),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                        item.status == "PAID"
                                                            ? "RECEIVED"
                                                            : item.status,
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: item.status ==
                                                                "PENDING"
                                                                ? clFA721F
                                                                : item.status ==
                                                                "PAID"
                                                                ? cl16B200
                                                                : item.status ==
                                                                "PROCESSING"?cl00369F:clAD0000)),
                                                    Text(
                                                        item.tree == "MASTER_CLUB"
                                                            ? item.paymentType
                                                            : "HELP",
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: cBlack)),
                                                    RichText(
                                                        text: TextSpan(children: [
                                                      const TextSpan(
                                                        text: "Amount: ",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: cl5F5F5F),
                                                      ),
                                                      const TextSpan(
                                                          text: " ₹ ",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight.w400,
                                                              color: cl252525)),
                                                      TextSpan(
                                                          text: item.amount,
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              color: cBlack)),
                                                    ]))
                                                  ],
                                                )
                                              ],
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
                                                        'whatsapp://send?phone=${item.number}');
                                                  },
                                                  child: Container(
                                                      height: 30,
                                                      width: width / 6,
                                                      decoration: BoxDecoration(
                                                          color: grdintclr2,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20)),
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
                                                      width: width / 10,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: ShapeDecoration(
                                                        color: Color(0xFFECF3FF),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(21.44),
                                                        ),
                                                      ),
                                                      child: const Icon(
                                                        Icons.telegram,color: cl3E6FCF,size: 18,
                                                      )
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              })
                          : const SizedBox(
                              height: 80,
                              child: Center(
                                  child: Text(
                                      "You have no MASTER CLUB incomes.")),
                            );
                    }),
                  ),
                )
              ],
            );
          }),
          Consumer<UserProvider>(builder: (context, value10, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: SizedBox(
                    width: width / 1.01,
                    child: Consumer<UserProvider>(
                        builder: (context3, value3, child) {
                      return value3.filterIncomeStarList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              itemCount: value3.filterIncomeStarList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var item = value3.filterIncomeStarList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: InkWell(
                                      onTap: () async {
                                        if (item.screenShot != "" &&
                                            item.status == "PROCESSING") {
                                          var toValue = await db
                                              .collection("DISTRIBUTIONS")
                                              .doc(item.id)
                                              .get();
                                          // .then((toValue) async {
                                          Map<dynamic, dynamic> toMap = toValue.data() as Map;
                                          String userIncomeStatus = toMap["STATUS"].toString();
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
                                          }
                                          // });

                                          print("element idddddd   " + item.id);
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
                                        } },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFFFFCF8),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                width: 1,
                                                color: Color(0xFFECECEC)),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          shadows: [
                                            const BoxShadow(
                                              color: Color(0x1E7C7C7C),
                                              blurRadius: 5,
                                              offset: Offset(0, 0),
                                              spreadRadius: 0,
                                            )
                                          ],
                                        ),
                                        // height: ,
                                        width: width,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 11,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.name,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          height: 1.3,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(item.inTree,
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            height: 1.3,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: cl252525)),
                                                    Text(item.grade,
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            height: 1.3,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: cl5F5F5F)),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                        item.status == "PAID"
                                                            ? "RECEIVED"
                                                            : item.status,
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: item.status ==
                                                                "PENDING"
                                                                ? clFA721F
                                                                : item.status ==
                                                                "PAID"
                                                                ? cl16B200
                                                                : item.status ==
                                                                "PROCESSING"?cl00369F:clAD0000)),
                                                    // Text(item.status,
                                                    //     style: TextStyle(
                                                    //         fontSize: 11,
                                                    //         fontWeight:
                                                    //         FontWeight.w500,
                                                    //         color: item.status ==
                                                    //             "PENDING"
                                                    //             ? clFA721F
                                                    //             : item.status ==
                                                    //             "PAID"
                                                    //             ? cl16B200
                                                    //             : clAD0000)),
                                                    Text(
                                                        item.tree == "MASTER_CLUB"
                                                            ? item.paymentType
                                                            : "HELP",
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: cBlack)),
                                                    RichText(
                                                        text: TextSpan(children: [
                                                      const TextSpan(
                                                        text: "Amount: ",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: cl5F5F5F),
                                                      ),
                                                      const TextSpan(
                                                          text: " ₹ ",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight.w400,
                                                              color: cl252525)),
                                                      TextSpan(
                                                          text: item.amount,
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              color: cBlack)),
                                                    ]))
                                                  ],
                                                )
                                              ],
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
                                                        'whatsapp://send?phone=${item.number}');
                                                  },
                                                  child: Container(
                                                      height: 30,
                                                      width: width / 6,
                                                      decoration: BoxDecoration(
                                                          color: grdintclr2,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20)),
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
                                                      width: width / 10,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: ShapeDecoration(
                                                        color: Color(0xFFECF3FF),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(21.44),
                                                        ),
                                                      ),
                                                      child: const Icon(
                                                        Icons.telegram,color: cl3E6FCF,size: 18,
                                                      )
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              })
                          : const SizedBox(
                              height: 80,
                              child: Center(
                                  child: Text(
                                      "You have no STAR CLUB incomes.")),
                            );
                    }),
                  ),
                )
              ],
            );
          }),
          Consumer<UserProvider>(builder: (context, value10, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: SizedBox(
                    width: width / 1.01,
                    child: Consumer<UserProvider>(
                        builder: (context3, value3, child) {
                      return value3.filterIncomeCrownList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              itemCount: value3.filterIncomeCrownList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var item = value3.filterIncomeCrownList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
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

                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFFFFCF8),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                width: 1,
                                                color: Color(0xFFECECEC)),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          shadows: [
                                            const BoxShadow(
                                              color: Color(0x1E7C7C7C),
                                              blurRadius: 5,
                                              offset: Offset(0, 0),
                                              spreadRadius: 0,
                                            )
                                          ],
                                        ),
                                        // height: ,
                                        width: width,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 11,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.name,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          height: 1.3,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(item.inTree,
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            height: 1.3,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: cl252525)),
                                                    Text(item.grade,
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            height: 1.3,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: cl5F5F5F)),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                        item.status == "PAID"
                                                            ? "RECEIVED"
                                                            : item.status,
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: item.status ==
                                                                "PENDING"
                                                                ? clFA721F
                                                                : item.status ==
                                                                "PAID"
                                                                ? cl16B200
                                                                : item.status ==
                                                                "PROCESSING"?cl00369F:clAD0000)),
                                                    // Text(item.status,
                                                    //     style: TextStyle(
                                                    //         fontSize: 11,
                                                    //         fontWeight:
                                                    //         FontWeight.w500,
                                                    //         color: item.status ==
                                                    //             "PENDING"
                                                    //             ? clFA721F
                                                    //             : item.status ==
                                                    //             "PAID"
                                                    //             ? cl16B200
                                                    //             : clAD0000)),
                                                    Text(
                                                        item.tree == "MASTER_CLUB"
                                                            ? item.paymentType
                                                            : "HELP",
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: cBlack)),
                                                    RichText(
                                                        text: TextSpan(children: [
                                                      const TextSpan(
                                                        text: "Amount: ",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: cl5F5F5F),
                                                      ),
                                                      const TextSpan(
                                                          text: " ₹ ",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight.w400,
                                                              color: cl252525)),
                                                      TextSpan(
                                                          text: item.amount,
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              color: cBlack)),
                                                    ]))
                                                  ],
                                                )
                                              ],
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
                                                        'whatsapp://send?phone=${item.number}');
                                                  },
                                                  child: Container(
                                                      height: 30,
                                                      width: width / 6,
                                                      decoration: BoxDecoration(
                                                          color: grdintclr2,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20)),
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
                                                      width: width / 10,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: ShapeDecoration(
                                                        color: Color(0xFFECF3FF),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(21.44),
                                                        ),
                                                      ),
                                                      child: const Icon(
                                                        Icons.telegram,color: cl3E6FCF,size: 18,
                                                      )
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              })
                          : const SizedBox(
                              height: 80,
                              child: Center(
                                  child: Text(
                                      "You have no CROWN CLUB incomes.")),
                            );
                    }),
                  ),
                )
              ],
            );
          }),
        ]),
      ),
    );
  }
}
