import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:lio_care/constants/my_colors.dart';
import 'package:provider/provider.dart';

import '../../Provider/user_provider.dart';
import 'adminReferralScreen.dart';
import 'admin_amfReport_screen.dart';
import 'admin_donationReport_screen.dart';
import 'admin_give_help_screen.dart';
import 'admin_members_screen.dart';
import 'admin_menu_screen.dart';
import 'admin_transactions.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    AdminProvider adminProvider =Provider.of<AdminProvider>(context,listen: false);
    return WillPopScope(
      onWillPop: () => userProvider.showExitPopup(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        endDrawer: Drawer(
          width: width,
          child: const AdminMenuScreen(),
        ),
        appBar: AppBar(
          backgroundColor: cWhite,
          leadingWidth: 8,
          toolbarHeight: 65,
          title: const Text(
            'Dashboard',
            style: TextStyle(
              color: cl252525,
              fontSize: 20,
              fontFamily: 'PoppinsMedium',
              fontWeight: FontWeight.w700,
              letterSpacing: 0.40,
            ),
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon:  const CircleAvatar(
                  backgroundColor: cl2F7DC1,
                  radius: 20,
                  child: Center(child: Icon(Icons.menu,color: cWhite,)),
                ),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
          leading: const SizedBox(),
          elevation: 0,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: cl252525,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
              top: 8.0, left: width / 22.5, right: width / 22.5,),
          child: Consumer<AdminProvider>(
            builder: (context,value,child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  value.adminPrivilegeList.contains("Total amounts")
                  ?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          ///fasil
                          adminProvider.fetchAdminPMCData("PMC",true);
                          callNext( AdminAmfReportScreen(type: "PMC"), context);},
                        child: rectangle(
                            title: "PMC",
                            text: value.pmcTotal.toStringAsFixed(1),
                            icon: "assets/myAmf.png",
                            containerColor: "green",
                            width: width / 2.3),
                      ),
                      InkWell(
                        onTap: () {
                          adminProvider.fetchAdminDonationData(true);
                          callNext(const AdminDonationReportScreen(), context);
                          },
                        child: rectangle(
                            title: "CMF",
                            text: value.donationTotal.toStringAsFixed(1),
                            icon: "assets/mydonation.png",
                            containerColor: "blue",
                            width: width / 2.3),
                      ),
                    ],
                  ):const SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          adminProvider.fetchAdminTotalGiveHelp(true);
                          callNext(const AdminGiveHelp(),context);
                          },
                        child: rectangle(
                            title: "Helps",
                            text: value.giveHelpTotal.toStringAsFixed(1),
                            icon: "assets/giveHelp.png",
                            containerColor: "blue",
                            width: width / 2.3),
                      ),
                      InkWell(
                        onTap: () {
                          ///asif
                          adminProvider.showSelectedDate='';
                          adminProvider.firstFetchMembers(true);
                          callNext(const AdminMembersScreen(), context);},
                        child: rectangle(
                            title: "Members",
                            text: value.membersCount.toString(),
                            icon: "assets/membersLogo.png",
                            containerColor: "green",
                            width: width / 2.3),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          adminProvider.isOpenedFilter=false;
                          adminProvider.isSecondDropdownEnabled=false;
                          adminProvider.fetchReferralLedger(true);
                          callNext(AdminReferralScreen(totalAmount: value.referralTotal), context);

                          },
                        child: rectangle(
                            title: "Referral",
                            text: value.referralTotal.toStringAsFixed(1),
                            icon: "assets/referral.png",
                            containerColor: "green",
                            width: width/2.3),
                      ),
                      InkWell(
                        onTap: () {
                          adminProvider.fetchAdminPMCData("PRC",true);
                          callNext( AdminAmfReportScreen(type: "PRC"), context);
                          },
                        child: rectangle(
                            title: "PRC",
                            text: value.prcTotal.toStringAsFixed(1),
                            icon: "assets/myAmf.png",
                            containerColor: "blue",
                            width: width/2.3),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transaction History",
                        style: TextStyle(
                            fontSize: width / 22.5,
                            fontFamily: "PoppinsRegular",
                            letterSpacing: 0.40,
                            fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                        child: Text(
                          "See more",
                          style: TextStyle(
                              fontSize: width / 30,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'PoppinsRegular',
                              color: cBlack),
                        ),
                        onPressed: () {
                          value.showSelectedDate="";
                          value.fetchTransactionHistory('',true,);
                          callNext(const AdminTransactionHistory(), context);
                          },
                      ),
                    ],
                  ),

                  Flexible(
                    fit: FlexFit.tight,
                    child: Consumer<AdminProvider>(
                      builder: (context,value2,child) {
                        return  value2.home_Transcation_HistoryList.isNotEmpty?
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: value2.home_Transcation_HistoryList.length>10?10: value2.home_Transcation_HistoryList.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                         var item=  value2.home_Transcation_HistoryList[index];
                            return Card(
                              child: SizedBox(
                                  // height: width / 4.3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            const SizedBox(height: 4,),
                                            Align(alignment:Alignment.topLeft,
                                              child: Text(
                                              item.username,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: width / 28,
                                                height: 1,
                                                fontFamily: 'PoppinsRegular',
                                                letterSpacing: 0.32,
                                              ),
                                          ),
                                            ),
                                              const SizedBox(height: 10,),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [

                                                Text(
                                                  item.grade,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: 'PoppinsMedium',
                                                      color: Color(0xff252525)),
                                                ),
                                                Text(
                                                  DateFormat("hh:mm a").format(item.paymentTime),
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(0xff252525),
                                                      fontSize: 12,
                                                      fontFamily: "PoppinsMedium"),
                                                ),

                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Reg no : ",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 12,
                                                          color:  Color(0XFF5F5F5F),
                                                        fontFamily: 'PoppinsRegular',
                                                        letterSpacing: 0.24,
                                                      ),
                                                    ),Text(
                                                      item.id,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Color(0XFF252525,),
                                                          fontFamily: "PoppinsMedium",
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                  ],
                                                ),

                                                RichText(text: TextSpan(
                                                  children:[
                                                    const TextSpan(
                                                      text: "₹ ",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 16,
                                                          color: Color(0xff1646A2)),
                                                    ),
                                                    TextSpan(
                                                      text: "${item.amount}",
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 16,
                                                          fontFamily: "PoppinsMedium",
                                                          color: Color(0xff1646A2)),
                                                    ),
                                                  ]
                                                ))
                                              ],
                                            ),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                item.phone,
                                                  style: TextStyle(
                                                      fontSize: width / 37.5,
                                                      fontWeight: FontWeight.w500,
                                                      color: const Color(0XFF5F5F5F),
                                                    fontFamily: 'PoppinsRegular',
                                                    letterSpacing: 0.24,
                                                  ),
                                                ),
                                                Text(item.paymentType,
                                                    style: TextStyle(
                                                        fontSize: width / 37.5,
                                                        fontWeight: FontWeight.w400,
                                                        fontFamily: "PoppinsRegular",
                                                        color: const Color(0xff16AD00))),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            );
                          },
                        )
                            : SizedBox(
                          height: height*.4,
                          child: const Center(
                            child: Text("No Transactions Yet.",style: TextStyle(fontWeight: FontWeight.w500),),
                          ),
                        );
                      }
                    ),
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}

Widget rectangle(
    {required String title,
    required String text,
    required String icon,
    required String containerColor,
    required double width}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Container(
      height:  width * 2.3 / 4.4,
      width: width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: containerColor == "green"
            ? [const Color(0xff82D600), const Color(0xff00610D)]
            : [
          cl005BBB,
          cl001969,
              ],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      )),
      child: Stack(
        children: [
          Positioned(
              left: -15,
              top: -10,
              child: Image.asset(
                containerColor == "green"
                    ? "assets/greentop.png"
                    : "assets/bluetop.png",
                height: width * 2.3 / 9,
                width:  width * 2.3 / 9,
              )),
          Positioned(
              right: 12,
              top: 10,
              child: Image.asset(
                containerColor == "green"
                    ? "assets/greenback.png"
                    : "assets/blueback.png",
                height: 50,
                width: 50,
              )),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Image.asset(
                        icon,
                        color: containerColor == "green"
                            ? cl00FF17
                            : cl0073FF,
                        height:  width * 2.5 / 32,
                        width:  width * 2.5 / 26.4,
                      ),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: width * 2.8 / 35,
                          color: cWhite,
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 0.32,
                      ),
                    ),
                  ],
                ),

                //₹

                RichText(text: TextSpan(
                  children:[

                    TextSpan(text: title!="Members"?"₹ ":" ",
                      style:TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: width * 2.5 / 28,
                      color: cWhite,
                    ),),
                    TextSpan(text: text,style:TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize:  width * 2.5 / 28,
                      color: cWhite,
                      fontFamily: 'PoppinsRegular',
                      letterSpacing: 0.32,
                    ),),
                  ]
                )),

              ],
            ),
          )
        ],
      ),
    ),
  );
}
