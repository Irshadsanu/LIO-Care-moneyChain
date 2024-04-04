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

class NewDistributionScreen extends StatefulWidget {
  NewDistributionScreen({Key? key}) : super(key: key);

  @override
  State<NewDistributionScreen> createState() => _NewDistributionScreenState();
}

class _NewDistributionScreenState extends State<NewDistributionScreen>with SingleTickerProviderStateMixin {
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
      userProvider. hideFilter("Distribution");
    }else if(index==1){
      userProvider. hideFilter("Income");
    }else{
      userProvider. hideFilter("Help");
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
          // actions: <Widget>[
          //   IconButton(
          //     icon: const Icon(
          //       Icons.tune,
          //       color: cl2F7DC1,
          //     ),
          //     onPressed: () {
          //       // openEndDrawer();
          //       _showTopSheet(context);
          //     },
          //   )
          // ],
          leading: Image.asset(
            'assets/bluelogo.png',
            scale: 18,
          ),
          title: Consumer<UserProvider>(builder: (context1, val1, child) {
            return Text(
              val1.userGrade,
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
              // if(index==2){
              //   userProvider. unHideFilter("Help");
              //   pageController.jumpToPage(index);
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
                  child: const Text("Distribution"),
                ),
              ),
              Tab(
                child: Container(
                  width: width / 1,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: cl2F7DC1, width: 1)),
                  child: const Text("Income"),
                ),
              ),
              Tab(
                child: Container(
                  width: width / 1,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: cl2F7DC1, width: 1)),
                  child: const Text("Helps"),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
            controller: controller,
            children: [
          Consumer<UserProvider>(
              builder: (context,value7,child) {
              return Column(

                  children: [
                const SizedBox(
                  height: 4,
                ),
                  Padding(
                  padding: const EdgeInsets.only(right: 17,bottom: 5),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: (){
                     if(value7.hideFilterBool==true){
                       value7.hideFilter("Distribution");
                     }else{
                       value7.showFilter("Distribution");
                     }
                      },
                      child: const SizedBox(
                        width: 100,

                        child: Text(
                          "Filters",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff252525),
                            height: 15/10,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ),
                ),
                    value7.hideFilterBool==true
                        ?  Column(

                      children: [
                  const SizedBox(height: 9,),
                  Container(
                    height: 60,
                    width: width*.92,

                    color: const Color(0xFFE9F2FF),
                    //
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 6.0,bottom: 5),
                          child: Text(
                            "Tree",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff252525),
                              height: 15/10,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),

                        Consumer<UserProvider>(
                            builder: (context,value1,child) {
                              return SizedBox(
                                height: 32,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:  value1.treeList.length,
                                    itemBuilder:  (BuildContext context, int index) {
                                      var item= value1.treeList[index];
                                      return   Padding(
                                        padding: const EdgeInsets.only(left: 6.0),
                                        child: InkWell(
                                          onTap: (){
                                            value1.selectDistributionTree=item.levelName;
                                            value1.treeColorChange(value1.treeList,index,item.levelName);
                                            value1.filterDistributionList(item.levelName);
                                            value1.filterListForDropDown(item.levelName);
                                            value1.setDistributionControllers();
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              // height: 33,
                                              width: 95,
                                              decoration: BoxDecoration(
                                                  color:item.color==true? myWhite:cl2F7DC1,
                                                  borderRadius: BorderRadius.circular(25)),
                                              child:  Text(
                                                item.levelName,
                                                style:  TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color:item.color==true? Colors.black:Colors.white,
                                                  height: 15/10,
                                                ),
                                                textAlign: TextAlign.center,
                                              )

                                          ),
                                        ),
                                      );

                                    } ),
                              );
                            }
                        ),


                      ],
                    ),

                  ),
                  Consumer<UserProvider>(
                      builder: (context,value5,child) {
                        return Container(
                          height:  value5.lessBool==true? 100:38,
                          width: width*.92,
                          color: const Color(0xFFF3F8FF),
                          child:    Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 6.0,bottom: 5,top: 5),
                                    child: Text(
                                      "Levels",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff252525),
                                        height: 15/10,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Consumer<UserProvider>(
                                      builder: (context,val,child) {
                                        return InkWell(
                                            onTap: (){
                                              if(val.lessBool==true){
                                                val.toggleMore("Distribution",val.selectDistributionTree);
                                              }else{
                                                val.toggleLess("Distribution",val.selectDistributionTree);
                                              }

                                            },
                                            child:  Container(
                                                alignment: Alignment.centerRight,
                                                width: 200,
                                                child: Icon(val.lessBool==false?Icons.expand_more:Icons.expand_less,size: 28,)));
                                      }
                                  )
                                ],
                              ),
                              value5.lessBool==true?  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Consumer<UserProvider>(
                                      builder: (context,value2,child) {
                                        return SizedBox(
                                          height: 20,
                                          child: ListView.builder(
                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                              itemCount: value2.filterCompanyLevelList.length,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder:  (BuildContext context, int index) {
                                                var distLevelItem=value2.filterCompanyLevelList[index];
                                                return  Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                  child: InkWell(
                                                      onTap: (){
                                                        value2.selectDistributionLevel=distLevelItem.levelName;

                                                        value2.treeColorChange(value2.filterCompanyLevelList,index,distLevelItem.levelName);
                                                        value2.filterGradeDistList( value2.selectDistributionTree,distLevelItem.levelName,"Distribution");
                                                      },
                                                      child: Container(
                                                          alignment: Alignment.center,
                                                          height: 12,
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 3),
                                                            child: Text(distLevelItem.levelName!=""? distLevelItem.levelName:"NO_GRADE",style:  TextStyle(fontSize: 11, color:distLevelItem.color==true?  const Color(0xff252525):cl2F7DC1,
                                                            ),textAlign: TextAlign.center,),
                                                          ))),
                                                );
                                              }),
                                        );
                                      }
                                  ),

                                   const Padding(
                                    padding: EdgeInsets.only(left: 6.0,bottom: 5,top: 5),
                                    child: Text(
                                      "Status",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff252525),
                                        height: 15/10,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Consumer<UserProvider>(
                                      builder: (context,value2,child) {
                                        return SizedBox(
                                          height: 20,
                                          child: ListView.builder(
                                              itemCount: value2.statusList.length,
                                              padding: const EdgeInsets.only(left: 12),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (BuildContext context ,int index){
                                                var item=value2.statusList[index];
                                                return  InkWell(
                                                  onTap: (){
                                                    value2.treeColorChange(value2.statusList,index,item.levelName);
                                                    value2.filterStatusDistList(value2.statusList,index,value2.selectDistributionTree,value2.selectDistributionLevel,item.levelName,context);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                    child: SizedBox(
                                                      child: Text(
                                                        value2.statusList[index].levelName,
                                                        style:  TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w400,
                                                          color:item.color==true?  const Color(0xff252525):cl2F7DC1,
                                                          // color: Color(0xff252525),
                                                          height: 15/10,
                                                        ),
                                                        textAlign: TextAlign.start,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        );
                                      }
                                  ),

                                ],
                              ):const SizedBox(),
                              const SizedBox(height: 5,)
                            ],
                          ),
                        );
                      }
                  ),
                ],
              )
                        :const SizedBox(),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: width/25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              callNext(PMCDistributions(from: 'MASTER',), context);
                            },
                            child: Container(
                              width: width*.44,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color:textColor.withOpacity(0.8),
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: const Color(0xFFE9F2FF))

                              ),
                              child: Consumer<UserProvider>(
                                builder: (context5,value5,child) {
                                  return Column(
                                    children: [

                                       Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("PMC",style: pmcPtcfBox),
                                          Text("PAID",style: pmcPtcfBox),
                                        ],
                                      ),
                                      const SizedBox(height: 3,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(value5.totalPmcAmount.toStringAsFixed(0),style: pmcPtcfBox3,),
                                          Text(value5.totalPmcPaid.toStringAsFixed(0),style: pmcPtcfBox3,),
                                        ],
                                      ),
                                      const SizedBox(height: 3,),
                                      Container(
                                        height: 2,
                                        // width: width*.42,
                                        color: cl5F9DF7,
                                      ),
                                      const SizedBox(height: 3,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Remaining",style:pmcPtcfBox2,),
                                          ],
                                        ),
                                      const SizedBox(height: 3,),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        height: 2,
                                        color: clFFFCF8,
                                        width: width*.44-16,
                                        child: Container(
                                          height: 2,
                                          width: value5.totalPmcCount!=0&&value5.totalPmcPaidCount!=0
                                              ?((width*.44-16)*((value5.totalPmcPaidCount/value5.totalPmcCount)*100))/100:0,
                                          color: clFA721F,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text("${value5.totalPmcPaidCount}/${value5.totalPmcCount}",style: pmcPtcfBox2,),
                                        ],
                                      ),
                                    ],
                                  );
                                }
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              callNext(PTCFDistributions(from: 'MASTER',), context);
                            },
                            child: Container(
                              width: width*.44,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color:textColor.withOpacity(0.8),
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: const Color(0xFFE9F2FF))

                              ),
                              child: Consumer<UserProvider>(
                                builder: (context5,value5,child) {
                                  return Column(
                                    children: [

                                       Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("CMF",style: pmcPtcfBox,),
                                          Text("PAID",style: pmcPtcfBox,),
                                        ],
                                      ),
                                      const SizedBox(height: 3,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(value5.totalPtcfAmount.toStringAsFixed(0),style: pmcPtcfBox3,),
                                          Text(value5.totalPtcfPaid.toStringAsFixed(0),style: pmcPtcfBox3,),
                                        ],
                                      ),
                                      const SizedBox(height: 3,),
                                      Container(
                                        height: 2,
                                        color: cl5F9DF7,
                                      ),
                                      const SizedBox(height: 3,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Remaining",style:pmcPtcfBox2,),
                                          ],
                                        ),
                                      const SizedBox(height: 3,),

                                      Container(
                                        alignment: Alignment.centerLeft,
                                        height: 2,
                                        color: clFFFCF8,
                                        width: width*.44-16,
                                        child: Container(
                                          height: 2,
                                          width: value5.totalPtcfCount!=0
                                              ?((width*.44-16)*((value5.totalPtcfPaidCount/value5.totalPtcfCount)*100))/100:0,
                                          color: clFA721F,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text("${value5.totalPtcfPaidCount}/${value5.totalPtcfCount}",style: pmcPtcfBox2,),
                                        ],
                                      ),
                                    ],
                                  );
                                }
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),


                    Consumer<UserProvider>(builder: (context, val565, child) {
                      return Flexible(
                        fit: FlexFit.tight,
                        child: SizedBox(
                          width: width,
                          // height:val565.hideFilterBool?height/1.9: height/1.5,
                          child:  val565.sortDistributionList.isNotEmpty
                              ?ListView.builder(
                              padding: const EdgeInsets.only(left: 8,right: 8,),
                              itemCount: val565.sortDistributionList.length,
                              itemBuilder: (BuildContext context, int index) {
                                DistributionModel item = val565.sortDistributionList[index];
                                return InkWell (
                                    onTap: () async {
                                      print("distribution id ${item.toDocId}");
                                      print("tree ${item.tree}");
                                      db.collection(item.tree).doc(item.toDocId).get().then((toValue) async {

                                        Map<dynamic,dynamic> toMap = toValue.data() as Map;
                                        // print("from grade : ${item.fromGrade}, to grade : ${toMap["GRADE"]??""}, to status ${toMap["STATUS"]??""}");

                                          if (item.status != "PAID") {
                                            if (item.screenShot == "") {
                                              bool levelCheck = await val565.checkLevelStatus(item.fromGrade, toMap["GRADE"]??"",
                                                  toMap["STATUS"]??"",item.toId,toMap["TYPE"]??"", context);
                                              if (levelCheck) {
                                              if (item.type == "STAR_CLUB"|| item.type == "CROWN_CLUB" ) {
                                                bool checkKycOrCount = await val565.checkKycStatusAndChild(val565.kycStatus,item.fromGrade,item.type, context);
                                                if(checkKycOrCount == false){
                                                  val565.kycChildCountAlert(context, item.phoneNumber,item.type);
                                                }else {
                                                  val565.upiCopyBool=false;
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
                                                        distributionId:
                                                        item.distributionId,
                                                      ),
                                                      context);
                                                }
                                              }
                                              else {
                                                val565.upiCopyBool=false;
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
                                                      distributionId:
                                                      item.distributionId,
                                                    ),
                                                    context);
                                              }
                                            }else {
                                                val565.restrictionAlert(context,item.name);
                                              }
                                            }
                                            else {
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
                                          }
                                      });
                                    },
                                    child: Container(
                                      width: width / 1.1,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(color: bck),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              item.proImage!=
                                                  ""
                                                  ? CircleAvatar(
                                                radius: 20,
                                                backgroundImage:
                                                NetworkImage(item.proImage),
                                              )
                                                  : const CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.transparent,
                                                child: Icon(
                                                    Icons.person_rounded,color: Colors.black,),
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
                                                    ),
                                                    Text(

                                                      // item.tree=="MASTER_CLUB"?item.tree:"${item.tree}_TREE",
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
                                                      style:  TextStyle(
                                                          fontWeight: FontWeight.w300, fontSize: 10,
                                                          color: item.tree == "MASTER_CLUB"
                                                              ?cl7aefba
                                                              :item.tree == "STAR_CLUB"
                                                              ?cl22A2B1:cl00369F),
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
                                                        item.tree=="MASTER_CLUB"
                                                        ?item.type
                                                        :"HELP",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                            FontWeight.w400,
                                                            fontSize: 10),
                                                      ),
                                                      Text(
                                                          item.status,
                                                          style: TextStyle(
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
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                              })
                              : const SizedBox(
                          height: 80,
                          child: Center(
                              child: Text("No Distributions Yet.")),
                        ),
                        ),
                      );
                    }),

                // Consumer<UserProvider>(builder: (context21, val77, child) {
                //   return SizedBox(
                //     child:
                //         // val77.userGrade=="STARTER"
                //         //     ?Column(
                //         //   children: [
                //         //     //////PMC//////
                //         //     Consumer<UserProvider>(
                //         //         builder: (context,value44,child) {
                //         //           return  InkWell(
                //         //             onTap: (){
                //         //               if(value44.userPmcStatus!="PAID"){
                //         //                 value44.gstCalc(double.parse(value44.userPmcAmount));
                //         //                 callNext(PMCPaymentScreen(name:"PMC", amount: value44.userPmcAmount, grade:value44.userPmcGrade,
                //         //                     tree: value44.userPmcTree, fromId: value44.registerID, distributionId:value44.userPmcDistributionId,
                //         //                     userName: value44.userName, phoneNumber: value44.userPhone), context);}
                //         //
                //         //             },
                //         //             child: Container(
                //         //               width: width/1.1,
                //         //               clipBehavior: Clip.antiAlias,
                //         //               decoration:  BoxDecoration(color: bck
                //         //
                //         //               ),
                //         //               child: Row(
                //         //                 mainAxisAlignment:
                //         //                 MainAxisAlignment.spaceBetween,
                //         //
                //         //                 children: [
                //         //                   Column(
                //         //                     crossAxisAlignment: CrossAxisAlignment.start,
                //         //                     children: [
                //         //                       CircleAvatar(
                //         //                         radius: 20,
                //         //                         backgroundColor: bck,
                //         //                         child: Image.asset("assets/bluelogo.png",fit: BoxFit.fill),),
                //         //                       Text('PMC',style: TextStyle( fontWeight: FontWeight.w600,
                //         //                           fontSize: 12),
                //         //                       ),
                //         //                     ],
                //         //                   ),
                //         //                   SizedBox(
                //         //                     // height: 60,
                //         //                     width: width / 3.2,
                //         //                     child: Padding(
                //         //                       padding: const EdgeInsets.all(8.0),
                //         //                       child: Column(
                //         //                         crossAxisAlignment:
                //         //                         CrossAxisAlignment.end,
                //         //                         mainAxisAlignment:
                //         //                         MainAxisAlignment.center,
                //         //                         children: [
                //         //
                //         //                           Text(value44.userPmcStatus,style: TextStyle(color:value44.userPmcStatus!="PAID"?clFFA500:cl16B200 )),
                //         //                           Text(
                //         //                             "₹${value44.userPmcAmount}",
                //         //                             style: const TextStyle(
                //         //                                 fontWeight: FontWeight.w600,
                //         //                                 fontSize: 12),
                //         //                           ),
                //         //
                //         //                           value44.userPmcStatus!="PAID"?Text(
                //         //                             "${value44.leftPmcDays} Days Left",
                //         //                             style: const TextStyle(
                //         //                                 fontWeight: FontWeight.w600,
                //         //                                 fontSize: 12),
                //         //                           ):const SizedBox(),
                //         //                         ],
                //         //                       ),
                //         //                     ),
                //         //                   ),
                //         //                 ],
                //         //               ),
                //         //             ),
                //         //           );
                //         //         }
                //         //     ),
                //         //     const SizedBox(height: 10,),
                //         //     //////////////////////////UPGRADE////////////
                //         //     Consumer<UserProvider>(
                //         //         builder: (context5,value46,child) {
                //         //           return value46.userPmcStatus=="PAID"&&value46.userUpgradeBool?
                //         //
                //         //           InkWell(
                //         //             onTap: () async {
                //         //               bool levelCheck = await value46.checkLevelStatus(
                //         //                   value46.userGrade,value46.userUpgradeGrade, context);
                //         //               if (levelCheck) {
                //         //                 if(value46.userUpgradeStatus!="PAID"){
                //         //                   if (value46.userUpgradeScreenShot == "") {
                //         //                     callNext(PaymentScreen(userUpgradeId: value46.userUpgradeId, userUpgradeName: value46.userUpgradeName,
                //         //                       userUpgradeNumber:value46.userUpgradeNumber, userUpgradeProfileImage:value46.userUpgradeProfileImage,
                //         //                       userUpgradeAmount: value46.userUpgradeAmount, userUpgradeStatus:value46.userUpgradeStatus,
                //         //                       userUpgradeUpiID: value46.userUpgradeUpiID, userPaymentType:"UPGRADE", userUpgradeGrade:value46.userUpgradeGrade,userUpgradeTree: value46.userUpgradeTree ,), context);
                //         //                   } else {
                //         //                     callNext(ConfirmationScreen(name: value46.userUpgradeName, phoneNumber: value46.userUpgradeNumber, date: "",
                //         //                       time: "", regId:  value46.userUpgradeId, image:value46.userUpgradeProfileImage, screenShot:value46.userUpgradeScreenShot,
                //         //                       receiptImage: null, from: "HOME", paymentType:"UPGRADE", tree:value46.userUpgradeTree, grade: value46.userUpgradeGrade,), context);
                //         //                   }}
                //         //               }else{
                //         //                 value46.warningAlert(context, "${value46.userUpgradeName} Not yet completed his payments.");
                //         //               }
                //         //             },
                //         //             child: Container(
                //         //               width: width/1.1,
                //         //               clipBehavior: Clip.antiAlias,
                //         //               decoration:  BoxDecoration(color:
                //         //               bck
                //         //
                //         //               ),
                //         //
                //         //               child: Row(
                //         //                 mainAxisAlignment:
                //         //                 MainAxisAlignment.spaceBetween,
                //         //                 children: [
                //         //                   value46.userUpgradeProfileImage!=""?
                //         //                   CircleAvatar(
                //         //                     radius: 20,
                //         //                     backgroundImage: NetworkImage(
                //         //                         value46.userUpgradeProfileImage),
                //         //                   ) :const Icon(Icons.person_rounded),
                //         //                   SizedBox(
                //         //                     width: width / 2.3,
                //         //                     child: Column(
                //         //                       crossAxisAlignment:
                //         //                       CrossAxisAlignment.start,
                //         //                       mainAxisAlignment:
                //         //                       MainAxisAlignment.center,
                //         //                       children: [
                //         //                         Text(
                //         //                           value46.userUpgradeName,
                //         //                           style: const TextStyle(
                //         //                               fontWeight: FontWeight.w600,
                //         //                               fontSize: 14),
                //         //                         ),
                //         //                         Text(
                //         //                           value46.userUpgradeId,
                //         //                           style: const TextStyle(
                //         //                               fontWeight: FontWeight.w300,
                //         //                               fontSize: 12),
                //         //                         ),
                //         //                         Text(
                //         //                           value46.userUpgradeNumber,
                //         //                           style: const TextStyle(
                //         //                               fontWeight: FontWeight.w300,
                //         //                               fontSize: 10),
                //         //                         )
                //         //                       ],
                //         //                     ),
                //         //                   ),
                //         //                   SizedBox(
                //         //                     // height: 60,
                //         //                     width: width / 3.2,
                //         //                     child: Padding(
                //         //                       padding: const EdgeInsets.all(8.0),
                //         //                       child: Column(
                //         //                         crossAxisAlignment:
                //         //                         CrossAxisAlignment.end,
                //         //                         mainAxisAlignment:
                //         //                         MainAxisAlignment.center,
                //         //                         children: [
                //         //                           const Text(
                //         //                             "UPGRADE",
                //         //                             style: TextStyle(
                //         //                                 fontWeight: FontWeight.w400,
                //         //                                 fontSize: 10),
                //         //                           ),
                //         //                           Text(value46.userUpgradeStatus,style: TextStyle(color:value46.userUpgradeStatus!="PAID"?clFFA500:cl16B200 ),),
                //         //                           Text(
                //         //                             "₹${value46.userUpgradeAmount}",
                //         //                             style: const TextStyle(
                //         //                                 fontWeight: FontWeight.w600,
                //         //                                 fontSize: 12),
                //         //                           ),
                //         //                         ],
                //         //                       ),
                //         //                     ),
                //         //                   ),
                //         //                 ],
                //         //               ),
                //         //
                //         //             ),
                //         //           )
                //         //               :const SizedBox();
                //         //         }
                //         //     ),
                //         //     const SizedBox(height: 10,),
                //         //   ],)
                //         //     :
                //         Column(
                //       children: [
                //
                //         //////PMC//////
                //         Consumer<UserProvider>(builder: (context44, value44, child) {
                //           return value44.userPmcBool
                //               ? InkWell(
                //                   onTap: () {
                //                     if (value44.userPmcStatus != "PAID") {
                //                       value44.gstCalc(
                //                           double.parse(value44.userPmcAmount));
                //                       callNext(
                //                           PMCPaymentScreen(
                //                               name: "PMC",
                //                               amount: value44.userPmcAmount,
                //                               grade: value44.userPmcGrade,
                //                               tree: value44.userPmcTree,
                //                               fromId: value44.registerID,
                //                               distributionId:
                //                                   value44.userPmcDistributionId,
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
                //                             padding: const EdgeInsets.all(8.0),
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
                //                                       fontWeight: FontWeight.w600,
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
                //         Consumer<UserProvider>(builder: (context45, value45, child) {
                //           return value45.userDonationBool
                //               ? InkWell(
                //                   onTap: () {
                //                     if (value45.userDonationStatus != "PAID") {
                //                       callNext(
                //                           PMCPaymentScreen(
                //                               name: "PTCF",
                //                               amount: value45.userDonationAmount,
                //                               grade: value45.userDonationGrade,
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
                //                               'PTCF',
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
                //                             padding: const EdgeInsets.all(8.0),
                //                             child: Column(
                //                               crossAxisAlignment:
                //                                   CrossAxisAlignment.end,
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.center,
                //                               children: [
                //                                 Text(value45.userDonationStatus,
                //                                     style: TextStyle(
                //                                         color:
                //                                             value45.userDonationStatus !=
                //                                                     "PAID"
                //                                                 ? clFFA500
                //                                                 : cl16B200)),
                //                                 Text(
                //                                   "₹${value45.userDonationAmount}",
                //                                   style: const TextStyle(
                //                                       fontWeight: FontWeight.w600,
                //                                       fontSize: 12),
                //                                 ),
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
                //         //////////////////////////UPGRADE////////////
                //         Consumer<UserProvider>(builder: (context46, value46, child) {
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
                //                       if (value46.userUpgradeStatus != "PAID") {
                //                         if (value46.userUpgradeScreenShot == "") {
                //                           callNext(
                //                               PaymentScreen(
                //                                 userUpgradeId:
                //                                     value46.userUpgradeId,
                //                                 userUpgradeName:
                //                                     value46.userUpgradeName,
                //                                 userUpgradeNumber:
                //                                     value46.userUpgradeNumber,
                //                                 userUpgradeProfileImage:
                //                                     value46.userUpgradeProfileImage,
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
                //                                 distributionId: value46.userUpgradeDistributionId,
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
                //                                 image:
                //                                     value46.userUpgradeProfileImage,
                //                                 screenShot:
                //                                     value46.userUpgradeScreenShot,
                //                                 receiptImage: null,
                //                                 from: "HOME",
                //                                 paymentType: "HELP",
                //                                 tree: value46.userUpgradeTree,
                //                                 grade: value46.userUpgradeGrade,
                //                                 distributionId: value46.userUpgradeDistributionId,
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
                //                             value46.userUpgradeProfileImage != ""
                //                                 ? CircleAvatar(
                //                                     radius: 20,
                //                                     backgroundImage: NetworkImage(
                //                                         value46
                //                                             .userUpgradeProfileImage),
                //                                   )
                //                                 : const Icon(Icons.person_rounded),
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
                //                                         fontWeight: FontWeight.w600,
                //                                         fontSize: 14),
                //                                   ),
                //                                   Text(
                //                                     value46.userUpgradeId,
                //                                     style: const TextStyle(
                //                                         fontWeight: FontWeight.w300,
                //                                         fontSize: 12),
                //                                   ),
                //                                   Text(
                //                                     value46.userUpgradeNumber,
                //                                     style: const TextStyle(
                //                                         fontWeight: FontWeight.w300,
                //                                         fontSize: 10),
                //                                   )
                //                                 ],
                //                               ),
                //                             ),
                //                             SizedBox(
                //                               // height: 60,
                //                               width: width / 3.2,
                //                               child: Padding(
                //                                 padding: const EdgeInsets.all(8.0),
                //                                 child: Column(
                //                                   crossAxisAlignment:
                //                                       CrossAxisAlignment.end,
                //                                   mainAxisAlignment:
                //                                       MainAxisAlignment.center,
                //                                   children: [
                //                                     const Text(
                //                                       "HELP",
                //                                       style: TextStyle(
                //                                           fontWeight:
                //                                               FontWeight.w400,
                //                                           fontSize: 10),
                //                                     ),
                //                                     Text(
                //                                       value46.userUpgradeStatus,
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
                //                                         BorderRadius.circular(20)),
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
                //                                           BorderRadius.circular(
                //                                               20)),
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
                //         Consumer<UserProvider>(builder: (context49, value49, child) {
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
                //                       if (value49.userReferralStatus != "PAID") {
                //                         if (value49.userReferralScreenShot == "") {
                //                           callNext(
                //                               PaymentScreen(
                //                                 userUpgradeId:
                //                                     value49.userReferralId,
                //                                 userUpgradeName:
                //                                     value49.userReferralName,
                //                                 userUpgradeNumber:
                //                                     value49.userReferralNumber,
                //                                 userUpgradeProfileImage: value49
                //                                     .userReferralProfileImage,
                //                                 userUpgradeAmount:
                //                                     value49.userReferralAmount,
                //                                 userUpgradeStatus:
                //                                     value49.userReferralStatus,
                //                                 userUpgradeUpiID:
                //                                     value49.userReferralUpiID,
                //                                 userPaymentType: "REFERRAL",
                //                                 userUpgradeGrade:
                //                                     value49.userReferralGrade,
                //                                 userUpgradeTree:
                //                                     value49.userReferralTree,
                //                                 distributionId: value49.userReferralDistributionId,
                //                               ),
                //                               context);
                //                         } else {
                //                           callNext(
                //                               ConfirmationScreen(
                //                                 name: value49.userReferralName,
                //                                 phoneNumber:
                //                                     value49.userReferralNumber,
                //                                 date: "",
                //                                 time: "",
                //                                 regId: value49.userReferralId,
                //                                 image: value49
                //                                     .userReferralProfileImage,
                //                                 screenShot:
                //                                     value49.userReferralScreenShot,
                //                                 receiptImage: null,
                //                                 from: "HOME",
                //                                 paymentType: "REFERRAL",
                //                                 tree: value49.userReferralTree,
                //                                 grade: value49.userReferralGrade,
                //                                 distributionId: value49.userReferralDistributionId,
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
                //                             value49.userReferralProfileImage != ""
                //                                 ? CircleAvatar(
                //                                     radius: 20,
                //                                     backgroundImage: NetworkImage(
                //                                         value49
                //                                             .userReferralProfileImage),
                //                                   )
                //                                 : const Icon(Icons.person_rounded),
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
                //                                         fontWeight: FontWeight.w600,
                //                                         fontSize: 14),
                //                                   ),
                //                                   Text(
                //                                     value49.userReferralId,
                //                                     style: const TextStyle(
                //                                         fontWeight: FontWeight.w300,
                //                                         fontSize: 12),
                //                                   ),
                //                                   Text(
                //                                     value49.userReferralNumber,
                //                                     style: const TextStyle(
                //                                         fontWeight: FontWeight.w300,
                //                                         fontSize: 10),
                //                                   )
                //                                 ],
                //                               ),
                //                             ),
                //                             SizedBox(
                //                               // height: 60,
                //                               width: width / 3.2,
                //                               child: Padding(
                //                                 padding: const EdgeInsets.all(8.0),
                //                                 child: Column(
                //                                   crossAxisAlignment:
                //                                       CrossAxisAlignment.end,
                //                                   mainAxisAlignment:
                //                                       MainAxisAlignment.center,
                //                                   children: [
                //                                     const Text(
                //                                       "REFERRAL",
                //                                       style: TextStyle(
                //                                           fontWeight:
                //                                               FontWeight.w400,
                //                                           fontSize: 10),
                //                                     ),
                //                                     Text(value49.userReferralStatus,
                //                                         style: TextStyle(
                //                                             color:
                //                                                 value49.userReferralStatus !=
                //                                                         "PAID"
                //                                                     ? clFFA500
                //                                                     : cl16B200)),
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
                //                                         BorderRadius.circular(20)),
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
                //                                           BorderRadius.circular(
                //                                               20)),
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
                //                           if (value47.userAutoPollOneScreenShot ==
                //                               "") {
                //                             callNext(
                //                                 PaymentScreen(
                //                                   userUpgradeId:
                //                                       value47.userAutoPollOneId,
                //                                   userUpgradeName:
                //                                       value47.userAutoPollOneName,
                //                                   userUpgradeNumber:
                //                                       value47.userAutoPollOneNumber,
                //                                   userUpgradeProfileImage: value47
                //                                       .userAutoPollOneProfileImage,
                //                                   userUpgradeAmount:
                //                                       value47.userAutoPollOneAmount,
                //                                   userUpgradeStatus:
                //                                       value47.userAutoPollOneStatus,
                //                                   userUpgradeUpiID:
                //                                       value47.userAutoPollOneUpiID,
                //                                   userPaymentType: "STAR_CLUB",
                //                                   userUpgradeGrade:
                //                                       value47.userAutoPollOneGrade,
                //                                   userUpgradeTree:
                //                                       value47.userAutoPollOneTree,
                //                                   distributionId: value47.userAutoPollOneDistributionId,
                //                                 ),
                //                                 context);
                //                           } else {
                //                             callNext(
                //                                 ConfirmationScreen(
                //                                   name: value47.userAutoPollOneName,
                //                                   phoneNumber:
                //                                       value47.userAutoPollOneNumber,
                //                                   date: "",
                //                                   time: "",
                //                                   regId: value47.userAutoPollOneId,
                //                                   image: value47
                //                                       .userAutoPollOneProfileImage,
                //                                   screenShot: value47
                //                                       .userAutoPollOneScreenShot,
                //                                   receiptImage: null,
                //                                   from: "HOME",
                //                                   paymentType: "STAR_CLUB",
                //                                   tree: value47.userAutoPollOneTree,
                //                                   grade:
                //                                       value47.userAutoPollOneGrade,
                //                                   distributionId: value47.userAutoPollOneDistributionId,
                //                                 ),
                //                                 context);
                //                           }
                //                         }
                //                       } else {
                //                         value47.kycChildCountAlert(
                //                             context, value47.userAutoPollOneNumber);
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
                //                                     backgroundImage: NetworkImage(
                //                                         value47
                //                                             .userAutoPollOneProfileImage),
                //                                   )
                //                                 : const Icon(Icons.person_rounded),
                //                             SizedBox(
                //                               width: width / 2.3,
                //                               child: Column(
                //                                 crossAxisAlignment:
                //                                     CrossAxisAlignment.start,
                //                                 mainAxisAlignment:
                //                                     MainAxisAlignment.center,
                //                                 children: [
                //                                   Text(
                //                                     value47.userAutoPollOneName,
                //                                     style: const TextStyle(
                //                                         fontWeight: FontWeight.w600,
                //                                         fontSize: 14),
                //                                   ),
                //                                   Text(
                //                                     value47.userAutoPollOneId,
                //                                     style: const TextStyle(
                //                                         fontWeight: FontWeight.w300,
                //                                         fontSize: 12),
                //                                   ),
                //                                   Text(
                //                                     value47.userAutoPollOneNumber,
                //                                     style: const TextStyle(
                //                                         fontWeight: FontWeight.w300,
                //                                         fontSize: 10),
                //                                   )
                //                                 ],
                //                               ),
                //                             ),
                //                             SizedBox(
                //                               // height: 60,
                //                               width: width / 3.2,
                //                               child: Padding(
                //                                 padding: const EdgeInsets.all(8.0),
                //                                 child: Column(
                //                                   crossAxisAlignment:
                //                                       CrossAxisAlignment.end,
                //                                   mainAxisAlignment:
                //                                       MainAxisAlignment.center,
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
                //                                             color:
                //                                                 value47.userAutoPollOneStatus !=
                //                                                         "PAID"
                //                                                     ? clFFA500
                //                                                     : cl16B200)),
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
                //                                         BorderRadius.circular(20)),
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
                //                                           BorderRadius.circular(
                //                                               20)),
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
                //                           if (value48.userAutoPollTwoScreenShot ==
                //                               "") {
                //                             callNext(
                //                                 PaymentScreen(
                //                                   userUpgradeId:
                //                                       value48.userAutoPollTwoId,
                //                                   userUpgradeName:
                //                                       value48.userAutoPollTwoName,
                //                                   userUpgradeNumber:
                //                                       value48.userAutoPollTwoNumber,
                //                                   userUpgradeProfileImage: value48
                //                                       .userAutoPollTwoProfileImage,
                //                                   userUpgradeAmount:
                //                                       value48.userAutoPollTwoAmount,
                //                                   userUpgradeStatus:
                //                                       value48.userAutoPollTwoStatus,
                //                                   userUpgradeUpiID:
                //                                       value48.userAutoPollTwoUpiID,
                //                                   userPaymentType: "CROWN_CLUB",
                //                                   userUpgradeGrade:
                //                                       value48.userAutoPollTwoGrade,
                //                                   userUpgradeTree:
                //                                       value48.userAutoPollTwoTree,
                //                                   distributionId: value48.userAutoPollTwoDistributionId,
                //                                 ),
                //                                 context);
                //                           } else {
                //                             callNext(
                //                                 ConfirmationScreen(
                //                                   name: value48.userAutoPollTwoName,
                //                                   phoneNumber:
                //                                       value48.userAutoPollTwoNumber,
                //                                   date: "",
                //                                   time: "",
                //                                   regId: value48.userAutoPollTwoId,
                //                                   image: value48
                //                                       .userAutoPollTwoProfileImage,
                //                                   screenShot: value48
                //                                       .userAutoPollTwoScreenShot,
                //                                   receiptImage: null,
                //                                   from: "HOME",
                //                                   paymentType: "CROWN_CLUB",
                //                                   tree: value48.userAutoPollTwoTree,
                //                                   grade:
                //                                       value48.userAutoPollTwoGrade,
                //                                   distributionId: value48.userAutoPollTwoDistributionId,
                //                                 ),
                //                                 context);
                //                           }
                //                         }
                //                       } else {
                //                         value48.kycChildCountAlert(
                //                             context, value48.userAutoPollTwoNumber);
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
                //                                     backgroundImage: NetworkImage(
                //                                         value48
                //                                             .userAutoPollTwoProfileImage),
                //                                   )
                //                                 : const Icon(Icons.person_rounded),
                //                             SizedBox(
                //                               width: width / 2.3,
                //                               child: Column(
                //                                 crossAxisAlignment:
                //                                     CrossAxisAlignment.start,
                //                                 mainAxisAlignment:
                //                                     MainAxisAlignment.center,
                //                                 children: [
                //                                   Text(
                //                                     value48.userAutoPollTwoName,
                //                                     style: const TextStyle(
                //                                         fontWeight: FontWeight.w600,
                //                                         fontSize: 14),
                //                                   ),
                //                                   Text(
                //                                     value48.userAutoPollTwoId,
                //                                     style: const TextStyle(
                //                                         fontWeight: FontWeight.w300,
                //                                         fontSize: 12),
                //                                   ),
                //                                   Text(
                //                                     value48.userAutoPollTwoNumber,
                //                                     style: const TextStyle(
                //                                         fontWeight: FontWeight.w300,
                //                                         fontSize: 10),
                //                                   )
                //                                 ],
                //                               ),
                //                             ),
                //                             SizedBox(
                //                               // height: 60,
                //                               width: width / 3.2,
                //                               child: Padding(
                //                                 padding: const EdgeInsets.all(8.0),
                //                                 child: Column(
                //                                   crossAxisAlignment:
                //                                       CrossAxisAlignment.end,
                //                                   mainAxisAlignment:
                //                                       MainAxisAlignment.center,
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
                //                                             color:
                //                                                 value48.userAutoPollTwoStatus !=
                //                                                         "PAID"
                //                                                     ? clFFA500
                //                                                     : cl16B200)),
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
                //                                         BorderRadius.circular(20)),
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
                //                                           BorderRadius.circular(
                //                                               20)),
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
              ]);
            }
          ),
          Consumer<UserProvider>(
              builder: (context,value7,child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 17),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: (){
                          if(value7.hideIncomeFilterBool==true){
                            value7.hideFilter("Income");
                          }else{
                            value7.showFilter("Income");
                          }
                        },
                        child: const SizedBox(
                          width: 100,

                          child: Text(
                            "Filters",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff252525),
                              height: 15/10,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ),
                  ),
                  value7.hideIncomeFilterBool==true
                      ?  Column(
                    children: [
                      const SizedBox(height: 9,),
                      Container(
                        height: 60,
                        width: width*.92,

                        color: const Color(0xFFE9F2FF),
                        //
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 6.0,bottom: 5),
                              child: Text(
                                "Tree",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff252525),
                                  height: 15/10,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),

                            Consumer<UserProvider>(
                                builder: (context,value33,child) {
                                  return SizedBox(
                                    height: 32,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        scrollDirection: Axis.horizontal,
                                        itemCount:  value33.incomeTreeList.length,
                                        itemBuilder:  (BuildContext context, int index) {
                                          var incomeTreeItem= value33.incomeTreeList[index];
                                          return   Padding(
                                            padding: const EdgeInsets.only(left: 6.0),
                                            child: InkWell(
                                              onTap: (){
                                                value33.selectIncomeTree=incomeTreeItem.levelName;
                                                value33.treeColorChange(value33.incomeTreeList,index,incomeTreeItem.levelName);
                                                value33.incomeFilterTreeBase(incomeTreeItem.levelName);
                                                value33.filterListForDropDown(incomeTreeItem.levelName);
                                                value33.setIncomeControllers();

                                              },
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  // height: 33,
                                                  width: 95,
                                                  decoration: BoxDecoration(

                                                      color:incomeTreeItem.color==true? myWhite:cl2F7DC1,
                                                      borderRadius: BorderRadius.circular(25)),
                                                  child:  Text(
                                                    incomeTreeItem.levelName,
                                                    style:  TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w400,
                                                      color:incomeTreeItem.color==true? Colors.black:Colors.white,
                                                      height: 15/10,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  )

                                              ),
                                            ),
                                          );

                                        } ),
                                  );
                                }
                            ),


                          ],
                        ),

                      ),
                      Consumer<UserProvider>(
                          builder: (context,value5,child) {
                            return Container(
                              height:  value5.lessIncomeBool==true? 100:38,
                              width: width*.92,
                              color: const Color(0xFFF3F8FF),
                              child:    Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 6.0,bottom: 5,top: 5),
                                        child: Text(
                                          "Levels",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff252525),
                                            height: 15/10,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Consumer<UserProvider>(
                                          builder: (context,val,child) {
                                            return InkWell(
                                                onTap: (){
                                                  if(val.lessIncomeBool==true){
                                                    val.toggleMore("Income",val.selectIncomeTree);
                                                  }else{
                                                    val.toggleLess("Income",val.selectIncomeTree);
                                                  }

                                                },
                                                child:  Container(
                                                    width: 100,
                                                    alignment: Alignment.centerRight,
                                                    child: Icon(val.lessIncomeBool==false?Icons.expand_more:Icons.expand_less,size: 28,)));
                                          }
                                      )
                                    ],
                                  ),
                                  value5.lessIncomeBool==true
                                      ?  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Consumer<UserProvider>(
                                          builder: (context,value2,child) {
                                            return SizedBox(
                                              height: 20,
                                              child: ListView.builder(
                                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                                  itemCount: value2.filterCompanyLevelList.length,
                                                  shrinkWrap: true,

                                                  scrollDirection: Axis.horizontal,
                                                  itemBuilder:  (BuildContext context, int index) {
                                                    var item=value2.filterCompanyLevelList[index];
                                                    return Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                      child: InkWell(
                                                          onTap: (){
                                                            value2.selectIncomeLevel=item.levelName;
                                                            value2.treeColorChange(value2.filterCompanyLevelList,index,item.levelName);
                                                            value2.filterGradeDistList( value2.selectIncomeTree,item.levelName,"Income");
                                                          },
                                                          child: Container(
                                                              alignment: Alignment.center,
                                                              height: 12,
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 3),
                                                                child: Text(item.levelName!=""? item.levelName:"NO_GRADE",style:  TextStyle(fontSize: 11, color:item.color==true?  const Color(0xff252525):cl2F7DC1,
                                                                ),textAlign: TextAlign.center,),
                                                              ))),
                                                    );
                                                  })
                                            );
                                          }
                                      ),
                                       const Padding(
                                        padding: EdgeInsets.only(left: 6.0,bottom: 5,top: 5),
                                        child: Text(
                                          "Status",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff252525),
                                            height: 15/10,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Consumer<UserProvider>(
                                          builder: (context,value2,child) {
                                            return SizedBox(
                                              height: 20,
                                              child:ListView.builder(
                                                  itemCount: value2.incomeStatusListNew.length,
                                                  padding: const EdgeInsets.only(left: 13),
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.horizontal,
                                                  itemBuilder: (BuildContext context ,int index){
                                                    var item=value2.incomeStatusListNew[index];
                                                    return  InkWell(
                                                      onTap: (){
                                                        value2.filterStatusIncomeList(value2.incomeStatusListNew,index,value2.selectIncomeTree,value2.selectIncomeLevel,item.levelName,context);

                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                        child: SizedBox(

                                                          child: Text(
                                                            item.levelName,
                                                            style:  TextStyle(
                                                              fontFamily: "Poppins",
                                                              fontSize: 11,
                                                              fontWeight: FontWeight.w400,
                                                              color:item.color==true?  const Color(0xff252525):cl2F7DC1,

                                                              // color: Color(0xff252525),
                                                              height: 15/10,
                                                            ),
                                                            textAlign: TextAlign.start,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            );
                                          }
                                      ),



                                    ],
                                  )
                                      :const SizedBox(),

                                ],
                              ),
                            );
                          }
                      ),
                    ],
                  )
                      :const SizedBox(),
                  const SizedBox(height: 15,),
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
                        return value3.filterIncomeList.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                itemCount: value3.filterIncomeList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var item = value3.filterIncomeList[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: InkWell(
                                        onTap: () {

                                          if (item.screenShot != "" &&
                                              item.status == "PROCESSING") {
                                            callNext(ApproveImageScreen(
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
                                                  tree: item.tree, userDocId: item.userDoc,
                                                ),
                                                context);
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(9)),
                                              border: Border.all(color: cl2F7DC1)),
                                          padding: const EdgeInsets.all(5),
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
                                                        MainAxisAlignment.spaceEvenly,
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
                                                        MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(item.status,
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
                                                                      : clAD0000)),
                                                      Text(
                                                        item.tree=="MASTER_CLUB"
                                                          ?item.paymentType
                                                          :"HELP",
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
                                                        width: width / 6,
                                                        decoration: BoxDecoration(
                                                            color: grdintclr2,
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                20)),
                                                        child: const Image(
                                                            image: AssetImage(
                                                                "assets/whatsapp.png"))),
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
                                    child: Text("No Income Statements Yet.")),
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
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 17,bottom: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: (){
                          if(value10.hideHelpFilterBool==true){
                            value10.hideFilter("Help");
                          }else{
                            value10.showFilter("Help");
                          }
                        },
                        child: const SizedBox(
                          width: 60,

                          child: Text(
                            "Filters",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff252525),
                              height: 15/10,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ),
                  ),

                  value10.hideHelpFilterBool==true
                      ?   Column(
                    children: [
                      Container(
                        height: 60,
                        width: width*.92,

                        color: const Color(0xFFE9F2FF),
                        //
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 6.0,bottom: 5),
                              child: Text(
                                "Tree",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff252525),
                                  height: 15/10,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),

                            Consumer<UserProvider>(
                                builder: (context,value1,child) {
                                  return SizedBox(
                                    height: 32,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        scrollDirection: Axis.horizontal,
                                        itemCount:  value1.helpTreeList.length,
                                        itemBuilder:  (BuildContext context, int index) {
                                          var item= value1.helpTreeList[index];
                                          return   Padding(
                                            padding: const EdgeInsets.only(left: 6.0),
                                            child: InkWell(
                                              onTap: () async {
                                                value1.whichTree=item.levelName;
                                                value1.selectedUserTree=item.levelName;
                                              value1.treeColorChange(value1.helpTreeList,index,item.levelName);
                                                value1.filterParentsList(item.levelName);

                                              },
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  // height: 33,
                                                  width: 95,
                                                  decoration: BoxDecoration(

                                                      color:item.color==true? myWhite:cl2F7DC1,
                                                      borderRadius: BorderRadius.circular(25)),
                                                  child:  Text(
                                                    item.levelName,
                                                    style:  TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w400,
                                                      color:item.color==true? Colors.black:Colors.white,
                                                      height: 15/10,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  )

                                              ),
                                            ),
                                          );

                                        } ),
                                  );
                                }
                            ),


                          ],
                        ),

                      ),

                    ],
                  )
                      :const SizedBox(),
                  const SizedBox(height: 10,),
                  Flexible(
                    fit: FlexFit.tight,
                    child: SizedBox(
                      width: width / 1.01,
                      child: Consumer<UserProvider>(
                          builder: (context3, value3, child) {
                        return value3.filterUpgradeParentsList.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                itemCount: value3.filterUpgradeParentsList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var item = value3.filterUpgradeParentsList[index];
                                  return InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(top: 5, bottom: 5),
                                      child: Container(
                                          padding: const EdgeInsets.all(5),
                                          height: 75,
                                          decoration: BoxDecoration(
                                            color: value3.getTexts(index, value3.selectedUserTree!) == value3.currentTreeGrade
                                                ? clFFAC7B.withOpacity(.6)
                                                : Colors.white,
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(9),
                                            ),
                                            border: Border.all(
                                                color: value3.getTexts(
                                                            index,
                                                            value3
                                                                .selectedUserTree!) ==
                                                        value3.currentTreeGrade
                                                    ? clFFAC7B
                                                    : cl2F7DC1),
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
                                                                    index,
                                                                    value3
                                                                        .selectedUserTree!),
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
                                                  color: cl2F7DC1,
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
                            : SizedBox(
                                width: 80,
                                height: 80,
                                child: Center(
                                    child: Text(
                                  "You Have No ${value3.whichTree} Distributions yet.",
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

