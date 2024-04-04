import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lio_care/Constants/functions.dart';
import 'package:lio_care/User/screens/PMCAndPTCF_Screen.dart';
import 'package:lio_care/User/screens/approveImageScreen.dart';
import 'package:lio_care/User/screens/payment_screen.dart';
import 'package:lio_care/User/screens/pmc_distribtions.dart';
import 'package:lio_care/User/screens/ptcf_distributions.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Provider/user_provider.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_texts.dart';
import '../../models/basic_treeListModel.dart';
import '../../models/distributionModel.dart';
import 'confirmation_screen.dart';
import 'help_Screen.dart';

class HelpParentScreen extends StatefulWidget {
  const HelpParentScreen({Key? key}) : super(key: key);

  @override
  State<HelpParentScreen> createState() => _HelpParentScreenState();
}

class _HelpParentScreenState extends State<HelpParentScreen>with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(initialIndex:0,length: 3, vsync: this);
    controller.addListener(_handleTabChange);
  }
  void openEndDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _handleTabChange(){
    UserProvider userProvider = Provider.of<UserProvider>(context,listen: false);
    final index=controller.index;
    if(index==0){
      userProvider. assignCurrentGrade(userProvider.currentBasicGrade);
    }else if(index==1){
      userProvider. assignCurrentGrade(userProvider.currentAutoOneGrade);
    }else{
      userProvider. assignCurrentGrade(userProvider.currentAutoTwoGrade);
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
    UserProvider userProvider = Provider.of<UserProvider>(context,listen: false);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
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
            return Text(

              "Helps",
              style: const TextStyle(
                  color: cl2F7DC1, fontWeight: FontWeight.w700, fontSize: 20),
            );
          }),
          centerTitle: true,
          bottom: TabBar(

            controller: controller,
            unselectedLabelColor: cl2F7DC1,
            indicatorColor: bxkclr,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Creates border
                color: cl2F7DC1),
            dividerColor:  Colors.transparent,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: clF3F3F3,
            onTap: (index){
              if (!controller.indexIsChanging) {
                // Only change the tab index if it's not already changing
                controller.animateTo(index);
              }
              if(index==0){
                userProvider. assignCurrentGrade(userProvider.currentBasicGrade);
              }else if(index==1){
                userProvider. assignCurrentGrade(userProvider.currentAutoOneGrade);
              }else{
                userProvider. assignCurrentGrade(userProvider.currentAutoTwoGrade);
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
                  child: const Text("Master Club",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),                  ),
                ),
              ),
              Tab(
                child: Container(
                  width: width / 1,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: cl2F7DC1, width: 1)),
                  child: const Text("Star Club",
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
                  child: const Text("Crown Club",textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
            controller: controller,
            children: [
              Consumer<UserProvider>(
                  builder: (context,value10,child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox(
                            width: width / 1.01,
                            child: Consumer<UserProvider>(
                                builder: (context3, value3, child) {
                                  return value3.basicTreeUpgradeUsersList.isNotEmpty
                                      ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                      ),
                                      itemCount: value3.basicTreeUpgradeUsersList.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        var item = value3.basicTreeUpgradeUsersList[index];
                                        return InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(top: 5, bottom: 5),
                                            child: Container(
                                                padding: const EdgeInsets.all(5),
                                                height: 75,
                                                decoration: BoxDecoration(
                                                  color: value3.getTexts(index, "MASTER_CLUB") == value3.currentBasicGrade
                                                      ? clFFAC7B.withOpacity(.6)
                                                      : Colors.white,
                                                  borderRadius: const BorderRadius.all(
                                                    Radius.circular(9),
                                                  ),

                                                  // border: Border.all(
                                                  //     color: value3.getTexts(
                                                  //         index,
                                                  //         "MASTER_CLUB") ==
                                                  //         value3.currentBasicGrade
                                                  //         ? clFFAC7B
                                                  //         : cl2F7DC1),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x1E7C7C7C),
                                                      blurRadius: 5,
                                                      offset: Offset(0, 0),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),

                                                // color: Colors.red,
                                                child: Row(
                                                  children: [
                                                    Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Padding(
                                                            padding:
                                                            const EdgeInsets.only(
                                                                top: 9.0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                              children: [
                                                                Text(
                                                                  ('Parent ${index + 1}'),
                                                                  style: const TextStyle(
                                                                      fontSize: 12,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 10),
                                                                  child: Text(
                                                                      value3.getTexts(
                                                                          index,"MASTER_CLUB"),
                                                                      style: const TextStyle(
                                                                          fontSize: 10,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w400)),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                )
                                                              ],
                                                            ))),
                                                    const Padding(
                                                      padding: EdgeInsets.all(8.0),
                                                      child: VerticalDivider(
                                                        color: Color(0xFFECECEC),

                                                        thickness: 1,
                                                        endIndent: 1,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 11,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceEvenly,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width / 2.3,
                                                          child: Text(
                                                            item.name,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                FontWeight.w600),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                        // Text("ID : ${item.id}",
                                                        //     style: const TextStyle(
                                                        //         fontSize: 10,
                                                        //         fontWeight:
                                                        //             FontWeight.w300,
                                                        //         color: cl5F5F5F)),
                                                        // Text(item.phone,
                                                        //     style: const TextStyle(
                                                        //         fontSize: 10,
                                                        //         fontWeight:
                                                        //             FontWeight.w300,
                                                        //         color: cl5F5F5F)),


                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                launch(
                                                                    "tel://${item.phone}");
                                                              },
                                                              child: Container(
                                                                height: 28,
                                                                width: width / 10,
                                                                clipBehavior: Clip.antiAlias,
                                                                decoration: ShapeDecoration(
                                                                  color: Color(0xFFECF3FF),
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(21.44),
                                                                  ),
                                                                ),
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
                                                                    'whatsapp://send?phone=${item.phone}');

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
                                                                    'https://telegram.me/+91${item.phone}');
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
                                                    const Spacer(),
                                                    Text(item.amount,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w600,
                                                            color: cBlack)),
                                                    const SizedBox(
                                                      width: 10,
                                                    )
                                                  ],
                                                )),
                                          ),
                                        );
                                      })
                                      : const SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Center(
                                        child: Text(
                                          "You Have Not Entered In MASTER CLUB yet.",
                                          textAlign: TextAlign.center,
                                        )),
                                  );
                                }),
                          ),
                        )
                      ],
                    );
                  }
              ),
              Consumer<UserProvider>(
                  builder: (context,value10,child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox(
                            width: width / 1.01,
                            child: Consumer<UserProvider>(
                                builder: (context3, value3, child) {
                                  return value3.autoPollOneUpgradeUsersList.isNotEmpty
                                      ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                      ),
                                      itemCount: value3.autoPollOneUpgradeUsersList.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        var item = value3.autoPollOneUpgradeUsersList[index];
                                        return InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(top: 5, bottom: 5),
                                            child: Container(
                                                padding: const EdgeInsets.all(5),
                                                height: 75,
                                                decoration: BoxDecoration(
                                                  color: value3.getTexts(index, "STAR_CLUB") == value3.currentAutoOneGrade
                                                      ? clFFAC7B.withOpacity(.6)
                                                      : Colors.white,
                                                  borderRadius: const BorderRadius.all(
                                                    Radius.circular(9),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x1E7C7C7C),
                                                      blurRadius: 5,
                                                      offset: Offset(0, 0),
                                                      spreadRadius: 0,
                                                    )
                                                  ],

                                                ),

                                                // color: Colors.red,
                                                child: Row(
                                                  children: [
                                                    Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Padding(
                                                            padding:
                                                            const EdgeInsets.only(
                                                                top: 9.0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                              children: [
                                                                Text(
                                                                  ('Parent ${index + 1}'),
                                                                  style: const TextStyle(
                                                                      fontSize: 12,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 10),
                                                                  child: Text(
                                                                      value3.getTexts(
                                                                          index,"STAR_CLUB"),
                                                                      style: const TextStyle(
                                                                          fontSize: 10,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w400)),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                )
                                                              ],
                                                            ))),
                                                    const Padding(
                                                      padding: EdgeInsets.all(8.0),
                                                      child: VerticalDivider(
                                                        color: Color(0xFFECECEC),
                                                        thickness: 1,
                                                        endIndent: 1,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 11,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceEvenly,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width / 2.3,
                                                          child: Text(
                                                            item.name,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                FontWeight.w600),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                        // Text("ID : ${item.id}",
                                                        //     style: const TextStyle(
                                                        //         fontSize: 10,
                                                        //         fontWeight:
                                                        //             FontWeight.w300,
                                                        //         color: cl5F5F5F)),
                                                        // Text(item.phone,
                                                        //     style: const TextStyle(
                                                        //         fontSize: 10,
                                                        //         fontWeight:
                                                        //             FontWeight.w300,
                                                        //         color: cl5F5F5F)),


                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                launch(
                                                                    "tel://${item.phone}");
                                                              },
                                                              child: Container(
                                                                height: 28,
                                                                width: width / 10,
                                                                decoration: BoxDecoration(
                                                                    color: grdintclr2,
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        5)),
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
                                                                    'whatsapp://send?phone=${item.phone}');

                                                              },
                                                              child: Container(
                                                                  height: 30,
                                                                  width: width / 10,
                                                                  decoration: BoxDecoration(
                                                                      color: grdintclr2,
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          5)),
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
                                                                    'https://telegram.me/+91${item.phone}');
                                                              },
                                                              child: Container(
                                                                  height: 30,
                                                                  width: width / 10,
                                                                  decoration: BoxDecoration(
                                                                      color: grdintclr2,
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          5)),
                                                                  child: const Icon(
                                                                    Icons.telegram,color: cl3E6FCF,size: 18,
                                                                  )
                                                              ),
                                                            )
                                                          ],
                                                        ),




                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Text(item.amount,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w600,
                                                            color: cBlack)),
                                                    const SizedBox(
                                                      width: 10,
                                                    )
                                                  ],
                                                )),
                                          ),
                                        );
                                      })
                                      : const SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Center(
                                        child: Text(
                                          "You Have Not Entered In STAR CLUB yet.",
                                          textAlign: TextAlign.center,
                                        )),
                                  );
                                }),
                          ),
                        )
                      ],
                    );
                  }
              ),
              Consumer<UserProvider>(
                  builder: (context,value10,child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox(
                            width: width / 1.01,
                            child: Consumer<UserProvider>(
                                builder: (context3, value3, child) {
                                  return value3.autoPollTwoUpgradeUsersList.isNotEmpty
                                      ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                      ),
                                      itemCount: value3.autoPollTwoUpgradeUsersList.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        var item = value3.autoPollTwoUpgradeUsersList[index];
                                        return InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(top: 5, bottom: 5),
                                            child: Container(
                                                padding: const EdgeInsets.all(5),
                                                height: 75,
                                                decoration: BoxDecoration(
                                                  color: value3.getTexts(index, "CROWN_CLUB") == value3.currentAutoTwoGrade
                                                      ? clFFAC7B.withOpacity(.6)
                                                      : Colors.white,
                                                  borderRadius: const BorderRadius.all(
                                                    Radius.circular(9),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x1E7C7C7C),
                                                      blurRadius: 5,
                                                      offset: Offset(0, 0),
                                                      spreadRadius: 0,
                                                    )
                                                  ],

                                                ),

                                                // color: Colors.red,
                                                child: Row(
                                                  children: [
                                                    Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Padding(
                                                            padding:
                                                            const EdgeInsets.only(
                                                                top: 9.0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                              children: [
                                                                Text(
                                                                  ('Parent ${index + 1}'),
                                                                  style: const TextStyle(
                                                                      fontSize: 12,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 10),
                                                                  child: Text(
                                                                      value3.getTexts(
                                                                          index,"CROWN_CLUB"),
                                                                      style: const TextStyle(
                                                                          fontSize: 10,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w400)),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                )
                                                              ],
                                                            ))),
                                                    const Padding(
                                                      padding: EdgeInsets.all(8.0),
                                                      child: VerticalDivider(
                                                        color: Color(0xFFECECEC),
                                                        thickness: 1,
                                                        endIndent: 1,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 11,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceEvenly,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width / 2.3,
                                                          child: Text(
                                                            item.name,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                FontWeight.w600),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                        // Text("ID : ${item.id}",
                                                        //     style: const TextStyle(
                                                        //         fontSize: 10,
                                                        //         fontWeight:
                                                        //             FontWeight.w300,
                                                        //         color: cl5F5F5F)),
                                                        // Text(item.phone,
                                                        //     style: const TextStyle(
                                                        //         fontSize: 10,
                                                        //         fontWeight:
                                                        //             FontWeight.w300,
                                                        //         color: cl5F5F5F)),


                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                launch(
                                                                    "tel://${item.phone}");
                                                              },
                                                              child: Container(
                                                                height: 28,
                                                                width: width / 10,
                                                                decoration: BoxDecoration(
                                                                    color: grdintclr2,
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        5)),
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
                                                                    'whatsapp://send?phone=${item.phone}');

                                                              },
                                                              child: Container(
                                                                  height: 30,
                                                                  width: width / 10,
                                                                  decoration: BoxDecoration(
                                                                      color: grdintclr2,
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          5)),
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
                                                                    'https://telegram.me/+91${item.phone}');
                                                              },
                                                              child: Container(
                                                                  height: 30,
                                                                  width: width / 10,
                                                                  decoration: BoxDecoration(
                                                                      color: grdintclr2,
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          5)),
                                                                  child: const Icon(
                                                                    Icons.telegram,color: cl3E6FCF,size: 18,
                                                                  )
                                                              ),
                                                            )
                                                          ],
                                                        ),




                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Text(item.amount,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w600,
                                                            color: cBlack)),
                                                    const SizedBox(
                                                      width: 10,
                                                    )
                                                  ],
                                                )),
                                          ),
                                        );
                                      })
                                      : const SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Center(
                                        child: Text(
                                          "You Have Not Entered In CROWN CLUB yet.",
                                          textAlign: TextAlign.center,
                                        )),
                                  );
                                }),
                          ),
                        )
                      ],
                    );
                  }
              ),
            ]),
      ),
    );
  }
}

