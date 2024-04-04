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

class NewPtcfScreen extends StatefulWidget {
  const NewPtcfScreen({Key? key}) : super(key: key);

  @override
  State<NewPtcfScreen> createState() => _NewPtcfScreenState();
}

class _NewPtcfScreenState extends State<NewPtcfScreen>with SingleTickerProviderStateMixin {
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
    // if(index==0){
    // }else if(index==1){
    // }else{
    // }
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
        backgroundColor: backgrnd,
        appBar: AppBar(
          backgroundColor: backgrnd,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,

          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/bluelogo.png',
                scale: 18,
              ),
              Text(
                "CMF Distributions",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    fontFamily: "PoppinsRegular"),
              ),
              const SizedBox()
            ],
          ),
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
              // if(index==0){
              //   userProvider. assignCurrentGrade(userProvider.currentBasicGrade);
              // }else if(index==1){
              //   userProvider. assignCurrentGrade(userProvider.currentAutoOneGrade);
              // }else{
              //   userProvider. assignCurrentGrade(userProvider.currentAutoTwoGrade);
              // }
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
                  child:  const Text(
                    'Master Club',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
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
                    'Star Club',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
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
                    'Crown Club',
                    textAlign: TextAlign.center,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<UserProvider>(builder: (context2, val565, child) {
                    return Container(
                      // color: Colors.cyan,
                      padding: const EdgeInsets.all(8),
                      width: width,
                      height: height-180,
                      child:  val565.masterPtcfDistributionsList.isNotEmpty
                          ?ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemCount: val565.companyAllLevelList.length,
                          itemBuilder: (BuildContext context, int index) {
                            List<DistributionModel> filteredPMCList = val565
                                .masterPtcfDistributionsList
                                .where((element) =>
                            val565.companyAllLevelList[index].levelName ==
                                element.fromGrade)
                                .toList();
                            filteredPMCList.sort((a, b) => a.installment.compareTo(b.installment));
                            return filteredPMCList.isNotEmpty
                                ? Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 6, top: 5),
                                      child: Text(
                                        val565.companyAllLevelList[index].levelName,
                                        style: const TextStyle(
                                          color: cl5F5F5F,
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                      ),
                                      itemCount: filteredPMCList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var item = filteredPMCList[index];
                                        return InkWell(
                                          onTap: () {
                                            print("distribution id ${item.distributionId}");
                                            String txnID=DateTime.now().millisecondsSinceEpoch.toString() + val565.generateRandomString(2);
                                            if (item.status != "PAID") {
                                              if(index==0){
                                                val565.gstCalc(double.parse(
                                                    item.amount));
                                                val565.gatewayShowFun();
                                                callNext(
                                                    PMCPaymentScreen(
                                                      name: item.type,
                                                      amount:item.amount,
                                                      grade: item.fromGrade,
                                                      tree: item.tree,
                                                      fromId:item.fromId,
                                                      distributionId: item.distributionId,
                                                      userName:item.name ,
                                                      phoneNumber: val565.userPhone, installment: item.installment, txnID: txnID),
                                                    context);
                                                val565.attemptPmCmf(context,  txnID, item.amount,item.type,
                                                    item.fromGrade, item.fromId, item.tree, item.distributionId, item.installment);
                                                val565.clearBooleans();
                                              }else{
                                                if(filteredPMCList[index-1].status=="PAID"){
                                                  val565.gstCalc(double.parse(
                                                      item.amount));
                                                  val565.gatewayShowFun();
                                                  callNext(
                                                      PMCPaymentScreen(
                                                        name: item.type,
                                                        amount:item.amount,
                                                        grade: item.fromGrade,
                                                        tree: item.tree,
                                                        fromId:item.fromId,
                                                        distributionId: item.distributionId,
                                                        userName:item.name ,
                                                        phoneNumber: val565.userPhone, installment: item.installment, txnID: txnID),
                                                      context);
                                                  val565.attemptPmCmf(context,  txnID, item.amount,item.type,
                                                      item.fromGrade, item.fromId, item.tree, item.distributionId, item.installment);
                                                  val565.clearBooleans();
                                                }else{
                                                  var snackBar = SnackBar(
                                                    content: Text("Please complete CMF ${item.installment-1} payment first."),
                                                  );
                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                }
                                              }
                                            }
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                clipBehavior: Clip.antiAlias,
                                                margin: const EdgeInsets.only(top: 0,bottom: 5),
                                                decoration: BoxDecoration(color: bck),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: width / 2.5,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,

                                                        children: [
                                                          Text(
                                                            item.type,
                                                            style: const TextStyle(
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 14),
                                                          ),
                                                          Text(

                                                            item.tree,
                                                            style:  TextStyle(
                                                                fontWeight: FontWeight.w500, fontSize: 10,
                                                                color: item.tree == "MASTER_CLUB"
                                                                    ?cl7aefba
                                                                    :item.tree == "STAR_CLUB"
                                                                    ?cl22A2B1:cl00369F),
                                                          ),
                                                          Text(
                                                            item.fromGrade,
                                                            style:  TextStyle(fontWeight: FontWeight.w400, fontSize: 10,
                                                                color: item.tree == "MASTER_CLUB"
                                                                    ?cl7aefba
                                                                    :item.tree == "STAR_CLUB"
                                                                    ?cl22A2B1:cl00369F),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width / 2.5,
                                                      child:
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.end,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          children: [
                                                            Text("CMF ${item.installment}",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w600,
                                                                    fontSize: 12,
                                                                    color: item.status !=
                                                                        "PAID"
                                                                        ? clFFA500
                                                                        : cl16B200)),
                                                            Text(item.status,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w600,
                                                                    fontSize: 12,
                                                                    color: item.status !=
                                                                        "PAID"
                                                                        ? clFFA500
                                                                        : cl16B200)),
                                                            Text(
                                                              "₹${item.amount}",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  fontSize: 12),
                                                            ),

                                                            const SizedBox(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              index!=0
                                                  ?filteredPMCList[index-1].status!="PAID"
                                                  ?Container(
                                                padding: const EdgeInsets.all(5),
                                                clipBehavior: Clip.antiAlias,
                                                margin: const EdgeInsets.only(top: 0,bottom: 5),
                                                decoration: BoxDecoration(color: textclr2.withOpacity(0.3)),
                                                height: 70,
                                                width: width,
                                                child:  Icon( Icons.lock_outline_rounded,color:textclr2,size: 30,),
                                              )
                                                  :const SizedBox():const SizedBox(),
                                            ],
                                          ),
                                        );
                                      })
                                ],
                              ),
                            )
                                : const SizedBox();
                          })
                          : const SizedBox(
                        height: 80,
                        child: Center(
                            child: Text("No Distributions Yet.")),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<UserProvider>(builder: (context2, val565, child) {
                    return Container(
                      // color: Colors.cyan,
                      padding: const EdgeInsets.all(8),
                      width: width,
                      height: height-180,
                      child:  val565.starPtcfDistributionsList.isNotEmpty
                          ?ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemCount: val565.companyAllLevelList.length,
                          itemBuilder: (BuildContext context, int index) {
                            List<DistributionModel> filteredPMCList = val565
                                .starPtcfDistributionsList
                                .where((element) =>
                            val565.companyAllLevelList[index].levelName ==
                                element.fromGrade)
                                .toList();
                            filteredPMCList.sort((a, b) => a.installment.compareTo(b.installment));
                            return filteredPMCList.isNotEmpty
                                ? Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 6, top: 5),
                                      child: Text(
                                        val565.companyAllLevelList[index].levelName,
                                        style: const TextStyle(
                                          color: cl5F5F5F,
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                      ),
                                      itemCount: filteredPMCList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var item = filteredPMCList[index];
                                        return InkWell(
                                          onTap: () {
                                            print("distribution id ${item.distributionId}");
                                            String txnID=DateTime.now().millisecondsSinceEpoch.toString() + val565.generateRandomString(2);
                                            if (item.status != "PAID") {
                                              if(index==0){
                                                val565.gstCalc(double.parse(
                                                    item.amount));
                                                val565.gatewayShowFun();
                                                callNext(
                                                    PMCPaymentScreen(
                                                      name: item.type,
                                                      amount:item.amount,
                                                      grade: item.fromGrade,
                                                      tree: item.tree,
                                                      fromId:item.fromId,
                                                      distributionId: item.distributionId,
                                                      userName:item.name ,
                                                      phoneNumber: val565.userPhone, installment: item.installment, txnID: txnID),
                                                    context);
                                                val565.attemptPmCmf(context,  txnID, item.amount,item.type,
                                                    item.fromGrade, item.fromId, item.tree, item.distributionId, item.installment);
                                                val565.clearBooleans();
                                              }else{
                                                if(filteredPMCList[index-1].status=="PAID"){
                                                  val565.gstCalc(double.parse(
                                                      item.amount));
                                                  val565.gatewayShowFun();
                                                  callNext(
                                                      PMCPaymentScreen(
                                                        name: item.type,
                                                        amount:item.amount,
                                                        grade: item.fromGrade,
                                                        tree: item.tree,
                                                        fromId:item.fromId,
                                                        distributionId: item.distributionId,
                                                        userName:item.name ,
                                                        phoneNumber: val565.userPhone, installment: item.installment, txnID: txnID),
                                                      context);
                                                  val565.attemptPmCmf(context,  txnID, item.amount,item.type,
                                                      item.fromGrade, item.fromId, item.tree, item.distributionId, item.installment);
                                                  val565.clearBooleans();
                                                }else{
                                                  var snackBar = SnackBar(
                                                    content: Text("Please complete CMF ${item.installment-1} payment first."),
                                                  );
                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                }
                                              }
                                            }
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                clipBehavior: Clip.antiAlias,
                                                margin: const EdgeInsets.only(top: 0,bottom: 5),
                                                decoration: BoxDecoration(color: bck),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: width / 2.5,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,

                                                        children: [
                                                          Text(
                                                            item.type,
                                                            style: const TextStyle(
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 14),
                                                          ),
                                                          Text(

                                                            item.tree,
                                                            style:  TextStyle(
                                                                fontWeight: FontWeight.w500, fontSize: 10,
                                                                color: item.tree == "MASTER_CLUB"
                                                                    ?cl7aefba
                                                                    :item.tree == "STAR_CLUB"
                                                                    ?cl22A2B1:cl00369F),
                                                          ),
                                                          Text(
                                                            item.fromGrade,
                                                            style:  TextStyle(fontWeight: FontWeight.w400, fontSize: 10,
                                                                color: item.tree == "MASTER_CLUB"
                                                                    ?cl7aefba
                                                                    :item.tree == "STAR_CLUB"
                                                                    ?cl22A2B1:cl00369F),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width / 2.5,
                                                      child:
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.end,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          children: [
                                                            Text("CMF ${item.installment}",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w600,
                                                                    fontSize: 12,
                                                                    color: item.status !=
                                                                        "PAID"
                                                                        ? clFFA500
                                                                        : cl16B200)),
                                                            Text(item.status,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w600,
                                                                    fontSize: 12,
                                                                    color: item.status !=
                                                                        "PAID"
                                                                        ? clFFA500
                                                                        : cl16B200)),
                                                            Text(
                                                              "₹${item.amount}",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  fontSize: 12),
                                                            ),

                                                            const SizedBox(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              index!=0
                                                  ?filteredPMCList[index-1].status!="PAID"
                                                  ?Container(
                                                padding: const EdgeInsets.all(5),
                                                clipBehavior: Clip.antiAlias,
                                                margin: const EdgeInsets.only(top: 0,bottom: 5),
                                                decoration: BoxDecoration(color: textclr2.withOpacity(0.3)),
                                                height: 70,
                                                width: width,
                                                child:  Icon( Icons.lock_outline_rounded,color:textclr2,size: 30,),
                                              )
                                                  :const SizedBox():const SizedBox(),
                                            ],
                                          ),
                                        );
                                      })
                                ],
                              ),
                            )
                                : const SizedBox();
                          })
                          : const SizedBox(
                        height: 80,
                        child: Center(
                            child: Text("No Distributions Yet.")),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<UserProvider>(builder: (context2, val565, child) {
                    return Container(
                      // color: Colors.cyan,
                      padding: const EdgeInsets.all(8),
                      width: width,
                      height: height-180,
                      child:  val565.crownPtcfDistributionsList.isNotEmpty
                          ?ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemCount: val565.companyAllLevelList.length,
                          itemBuilder: (BuildContext context, int index) {
                            List<DistributionModel> filteredPMCList = val565
                                .crownPtcfDistributionsList
                                .where((element) =>
                            val565.companyAllLevelList[index].levelName ==
                                element.fromGrade)
                                .toList();
                            filteredPMCList.sort((a, b) => a.installment.compareTo(b.installment));
                            return filteredPMCList.isNotEmpty
                                ? Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 6, top: 5),
                                      child: Text(
                                        val565.companyAllLevelList[index].levelName,
                                        style: const TextStyle(
                                          color: cl5F5F5F,
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                      ),
                                      itemCount: filteredPMCList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var item = filteredPMCList[index];
                                        return InkWell(
                                          onTap: () {
                                            print("distribution id ${item.distributionId}");
                                            String txnID=DateTime.now().millisecondsSinceEpoch.toString() + val565.generateRandomString(2);
                                            if (item.status != "PAID") {
                                              if(index==0){
                                                val565.gstCalc(double.parse(
                                                    item.amount));
                                                val565.gatewayShowFun();
                                                callNext(
                                                    PMCPaymentScreen(
                                                      name: item.type,
                                                      amount:item.amount,
                                                      grade: item.fromGrade,
                                                      tree: item.tree,
                                                      fromId:item.fromId,
                                                      distributionId: item.distributionId,
                                                      userName:item.name ,
                                                      phoneNumber: val565.userPhone, installment: item.installment, txnID: txnID),
                                                    context);
                                                val565.attemptPmCmf(context,  txnID, item.amount,item.type,
                                                    item.fromGrade, item.fromId, item.tree, item.distributionId, item.installment);
                                                val565.clearBooleans();
                                              }else{
                                                if(filteredPMCList[index-1].status=="PAID"){
                                                  val565.gstCalc(double.parse(
                                                      item.amount));
                                                  val565.gatewayShowFun();
                                                  callNext(
                                                      PMCPaymentScreen(
                                                        name: item.type,
                                                        amount:item.amount,
                                                        grade: item.fromGrade,
                                                        tree: item.tree,
                                                        fromId:item.fromId,
                                                        distributionId: item.distributionId,
                                                        userName:item.name ,
                                                        phoneNumber: val565.userPhone, installment: item.installment, txnID: txnID),
                                                      context);
                                                  val565.attemptPmCmf(context,  txnID, item.amount,item.type,
                                                      item.fromGrade, item.fromId, item.tree, item.distributionId, item.installment);
                                                  val565.clearBooleans();
                                                }else{
                                                  var snackBar = SnackBar(
                                                    content: Text("Please complete CMF ${item.installment-1} payment first."),
                                                  );
                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                }
                                              }
                                            }
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                clipBehavior: Clip.antiAlias,
                                                margin: const EdgeInsets.only(top: 0,bottom: 5),
                                                decoration: BoxDecoration(color: bck),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: width / 2.5,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,

                                                        children: [
                                                          Text(
                                                            item.type,
                                                            style: const TextStyle(
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 14),
                                                          ),
                                                          Text(

                                                            item.tree,
                                                            style:  TextStyle(
                                                                fontWeight: FontWeight.w500, fontSize: 10,
                                                                color: item.tree == "MASTER_CLUB"
                                                                    ?cl7aefba
                                                                    :item.tree == "STAR_CLUB"
                                                                    ?cl22A2B1:cl00369F),
                                                          ),
                                                          Text(
                                                            item.fromGrade,
                                                            style:  TextStyle(fontWeight: FontWeight.w400, fontSize: 10,
                                                                color: item.tree == "MASTER_CLUB"
                                                                    ?cl7aefba
                                                                    :item.tree == "STAR_CLUB"
                                                                    ?cl22A2B1:cl00369F),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width / 2.5,
                                                      child:
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.end,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          children: [
                                                            Text("CMF ${item.installment}",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w600,
                                                                    fontSize: 12,
                                                                    color: item.status !=
                                                                        "PAID"
                                                                        ? clFFA500
                                                                        : cl16B200)),
                                                            Text(item.status,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w600,
                                                                    fontSize: 12,
                                                                    color: item.status !=
                                                                        "PAID"
                                                                        ? clFFA500
                                                                        : cl16B200)),
                                                            Text(
                                                              "₹${item.amount}",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  fontSize: 12),
                                                            ),

                                                            const SizedBox(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              index!=0
                                                  ?filteredPMCList[index-1].status!="PAID"
                                                  ?Container(
                                                padding: const EdgeInsets.all(5),
                                                clipBehavior: Clip.antiAlias,
                                                margin: const EdgeInsets.only(top: 0,bottom: 5),
                                                decoration: BoxDecoration(color: textclr2.withOpacity(0.3)),
                                                height: 70,
                                                width: width,
                                                child:  Icon( Icons.lock_outline_rounded,color:textclr2,size: 30,),
                                              )
                                                  :const SizedBox():const SizedBox(),
                                            ],
                                          ),
                                        );
                                      })
                                ],
                              ),
                            )
                                : const SizedBox();
                          })
                          : const SizedBox(
                        height: 80,
                        child: Center(
                            child: Text("No Distributions Yet.")),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            ]),
      ),
    );
  }
}

