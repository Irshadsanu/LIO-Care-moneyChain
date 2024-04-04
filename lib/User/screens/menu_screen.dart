import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:lio_care/User/screens/giveHelp_screen.dart';
import 'package:lio_care/User/screens/helpLedger_screen.dart';
import 'package:lio_care/User/screens/helpReceived_screen.dart';
import 'package:lio_care/User/screens/my_donation_screen.dart';
import 'package:lio_care/User/screens/paymentReport_screen.dart';
import 'package:lio_care/User/screens/profile_screen.dart';
import 'package:lio_care/User/screens/make_dynamic_Link_Screen.dart';
import 'package:lio_care/User/screens/user_exchange_user.dart';
import 'package:lio_care/help_tree/tree_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../constants/alerts.dart';
import '../../constants/functions.dart';
import '../../constants/my_colors.dart';
import '../../view/Widgets/my_widgets.dart';
import '../../view/loginScreen.dart';
import 'bottomNavigation.dart';
import 'invitesScreen.dart';
import 'myAmf_screen.dart';
import 'myInvitationsScreen.dart';
import 'notification_Screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider user =
    Provider.of<UserProvider>(context, listen: false);
    AdminProvider adminProvider =
    Provider.of<AdminProvider>(context, listen: false);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.92, -0.40),
            end: Alignment(-0.92, 0.4),
            colors: [ Color(0xFF2FC1BC),Color(0xFF2F7DC1),],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height / 30.05882352941176,
              ),
              SizedBox(
                height: 40,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child:
                      Consumer<UserProvider>(builder: (context1, val57, child) {
                    return InkWell(
                        onTap: () {
                          callNextReplacement(
                              BottomNavigationScreen(Userid: val57.registerID),
                              context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 15),
                          width: 35,
                          height: 34,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF2EB0BD),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 25,
                          ),
                        ));
                  }),
                ),
              ),
              CircleAvatar(
                radius: 45,
                backgroundColor: textColor,
                child: Consumer<UserProvider>(builder: (context, val, child) {
                  return val.userProfileImage != ""
                      ? CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(
                            val.userProfileImage,
                          ),
                        )
                       :const CircleAvatar(
                          radius: 45,
                          child: Icon(Icons.person_rounded),
                        );
                }),
              ),
              SizedBox(
                height: height / 170.2,
              ),
              Consumer<UserProvider>(builder: (context, val1, child) {
                return Text(
                  val1.userName,
                  style: const TextStyle(
                      color: myWhite,
                      fontSize: 25,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w600),
                );
              }),
              Consumer<UserProvider>(builder: (context, val2, child) {
                return Text(
                  val2.userPhone,
                  style: const TextStyle(
                      color: myWhite,
                      fontSize: 12,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w400),
                );
              }),
              SizedBox(
                height: height / 40.45833333333333,
              ),
              Consumer<UserProvider>(builder: (context, val3, child) {
                return InkWell(
                  onTap: () {
                    val3.assignFunction();
                    val3.editCheck2 = false;
                    callNext(ProfileScreen(), context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 7.86,
                      ),
                      const Icon(
                        Icons.person_outline,
                        color: myWhite,
                        size: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Text(
                          "Profile",
                          style: menuStyle,
                        ),
                      )
                    ],
                  ),
                );
              }),
              SizedBox(
                height: height / 50.05882352941176,
              ),
              Consumer<UserProvider>(builder: (context, value6, child) {
                return InkWell(
                  onTap: () {
                    value6.helpGiveAndReceived(value6.registerID);
                    callNext(const HelpLedgerScreen(), context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 7.86,
                      ),
                      const Icon(
                        Icons.table_chart_outlined,
                        color: myWhite,
                        size: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Text(
                          "Help Ledger",
                          style: menuStyle,
                        ),
                      )
                    ],
                  ),
                );
              }),

              SizedBox(
                height: height / 50.05882352941176,
              ),
              Consumer<UserProvider>(builder: (context4, value5, child) {
                return InkWell(
                  onTap: () {
                    value5.selectedStageDropdownItem = 'All Stages';
                    value5.helpGiveList(value5.registerID);
                    // value5.helpGiveAndReceived(value5.registerID);
                    callNext(const GiveHelpScreen(), context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 7.86,
                      ),
                      SizedBox(
                          width: 25,
                          child: Image.asset("assets/give help.png")),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Text(
                          "Give Help",
                          style: menuStyle,
                        ),
                      )
                    ],
                  ),
                );
              }),
              SizedBox(
                height: height / 50.05882352941176,
              ),
              Consumer<UserProvider>(builder: (context, value6, child) {
                return InkWell(
                  onTap: () {
                    value6.helpReceiveList(value6.registerID);
                    value6.selectedStageDropdownItem = 'All Stages';
                    callNext(const HelpReceivedScreen(), context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 7.86,
                      ),
                      SizedBox(
                        width: 23,
                        child: Image.asset(
                          "assets/Vector (3).png",
                          color: myWhite,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Text(
                          "Help Received",
                          style: menuStyle,
                        ),
                      )
                    ],
                  ),
                );
              }),
              SizedBox(
                height: height / 50.05882352941176,
              ),

              Consumer<UserProvider>(builder: (context, value10, child) {
                return InkWell(
                  onTap: () {
                    value10.fetchPaymentReport(value10.registerID);
                    callNext(const PaymentReportScreen(), context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 7.86,
                      ),
                      const Icon(
                        Icons.receipt_long_outlined,
                        color: myWhite,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Text(
                          "Payment Report",
                          style: menuStyle,
                        ),
                      )
                    ],
                  ),
                );
              }),
              SizedBox(
                height: height / 50.05882352941176,
              ),

              Consumer<UserProvider>(builder: (context, value1, child) {
                return InkWell(
                  onTap: () {
                    // value1.fetchMyInvitations("1689587978736");
                    value1.fetchReferralTransactions(value1.registerID);
                    callNext(const InvitesScreen(), context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 7.86,
                      ),
                      const Icon(
                        Icons.near_me_outlined,
                        color: myWhite,
                        size: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Text(
                          "My Invitations",
                          style: menuStyle,
                        ),
                      )
                    ],
                  ),
                );
              }),
              SizedBox(
                height: height / 50.05882352941176,
              ),

              Consumer<UserProvider>(builder: (context, value2, child) {
                return InkWell(
                  onTap: () {
                    // value2.fetchNotification(
                    //   value2.registerID,
                    //   true,
                    // );

                    callNext(const NotificationScreen(), context);
                  },
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width / 7.86,
                        ),
                        const Icon(
                          Icons.notifications_none_outlined,
                          color: myWhite,
                          size: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Text(
                            "Notifications",
                            style: menuStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(
                height: height / 50.05882352941176,
              ),

              adminProvider.treeLock == "ON"
              ?Consumer<TreeProvider>(builder: (context5, value123, child) {
                return InkWell(
                  onTap: () async {

                    //
                    //  // callNext(const HelpTreeScreen(), context);
                    // callNext(const TreeHomeSection(), context);
                    //  await value123.fetchHelpTree("1001","MASTER_CLUB",context);
                    // callNext(TreeViewPage(), context);

                    if (user.registerDocID != "") {
                      adminProvider.treeLock == "ON"
                          ? showModalBottomSheet<void>(
                              shape: const RoundedRectangleBorder(
                                // <-- SEE HERE
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0),
                                ),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                final width = MediaQuery.of(context).size.width;
                                return SizedBox(
                                  height: 250,
                                  child: Center(
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          width: width,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                            color: cWhite,
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(25.0),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x30000000),
                                                blurRadius: 5,
                                                offset: Offset(0, 4),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Image.asset(
                                                  "assets/downArrow.png",
                                                  scale: 3,
                                                  color: cl303030
                                                      .withOpacity(0.50),
                                                ),
                                                const Text(
                                                  'Help Tree',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: cl252525,
                                                    fontSize: 15,
                                                    fontFamily:
                                                        'PoppinsRegular',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ]),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 8, 12, 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    await value123.fetchHelpTree(
                                                        user.registerID,
                                                        user.registerDocID,
                                                        "MASTER_CLUB",
                                                        user.userProfileImage,
                                                        context,
                                                        "USER",
                                                        "");

                                                    // await value123.fetchHelpTree("1001","10001","MASTER_CLUB",
                                                    //     user.userProfileImage,context);
                                                  },
                                                  child: SizedBox(
                                                    height: 50,
                                                    child: Row(
                                                      children: [
                                                        const Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            'Master Club',
                                                            style: TextStyle(
                                                              color: cl252525,
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Icon(
                                                                  Icons
                                                                      .arrow_forward_ios,
                                                                  color: cl303030
                                                                      .withOpacity(
                                                                          0.30))),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    await value123.fetchHelpTree(
                                                        user.registerID,
                                                        user.registerDocID,
                                                        "STAR_CLUB",
                                                        user.userProfileImage,
                                                        context,
                                                        "USER",
                                                        "");
                                                  },
                                                  child: SizedBox(
                                                    height: 50,
                                                    child: Row(
                                                      children: [
                                                        const Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            'Star Club',
                                                            style: TextStyle(
                                                              color: cl252525,
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Icon(
                                                                  Icons
                                                                      .arrow_forward_ios,
                                                                  color: cl303030
                                                                      .withOpacity(
                                                                          0.30))),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    await value123.fetchHelpTree(
                                                        user.registerID,
                                                        user.registerDocID,
                                                        "CROWN_CLUB",
                                                        user.userProfileImage,
                                                        context,
                                                        "USER",
                                                        "");
                                                  },
                                                  child: SizedBox(
                                                    height: 50,
                                                    child: Row(
                                                      children: [
                                                        const Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            'Crown Club',
                                                            style: TextStyle(
                                                              color: cl252525,
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Icon(
                                                                  Icons
                                                                      .arrow_forward_ios,
                                                                  color: cl303030
                                                                      .withOpacity(
                                                                          0.30))),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : const SizedBox();
                    } else {
                      final snackBar = SnackBar(
                        backgroundColor: myWhite,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(79),
                        ),
                        behavior: SnackBarBehavior.floating,
                        content: const Text(
                          "You Have No Children",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  highlightColor: cl0F41A1,
                  splashColor: cl3E6FCF,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 7.86,
                      ),
                      const Icon(
                        Icons.account_tree_outlined,
                        color: myWhite,
                        size: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Text(
                          "Help Tree",
                          style: menuStyle,
                        ),
                      )
                    ],
                  ),
                );
              })
              :SizedBox(),
              SizedBox(
                height: adminProvider.treeLock == "ON"
                    ?height / 50.05882352941176:0,
              ),


              Consumer<UserProvider>(builder: (context, value2, child) {
                return InkWell(
                  onTap: () {
                    value2.fetchPMCDetails(value2.registerID);
                    callNext(const MyAmfScreen(), context);
                  },
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width / 7.86,
                        ),
                        const Icon(
                          Icons.article_outlined,
                          color: myWhite,
                          size: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Text(
                            "PMC",
                            style: menuStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(
                height: height / 50.05882352941176,
              ),


              Consumer<UserProvider>(builder: (context, val66, child) {
                return InkWell(
                  onTap: () {
                    val66.fetchDonationDetails(val66.registerID);
                    callNext(const MyDonationScreen(), context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 7.86,
                      ),
                      SizedBox(
                        width: 25,
                        child: Image.asset(
                          "assets/don.png",
                          color: myWhite,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Text(
                          "CMF",
                          style: menuStyle,
                        ),
                      )
                    ],
                  ),
                );
              }),
              SizedBox(
                height: height / 50.05882352941176,
              ),
              Consumer<AdminProvider>(builder: (context, adminpro, child){
                  return Consumer<UserProvider>(builder: (context, val99, child) {
                    return val99.userType == "LEADER"
                        ? InkWell(
                            onTap: () {

                              callNext(UserExchangeUserScreen(), context);
                              adminpro.clearAllExchangeControllers();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: width / 7.86,
                                ),
                                const Icon(Icons.swap_horiz_outlined, color: myWhite,
                                  size: 25,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 14.0),
                                  child: Text(
                                    "Exchange Members",
                                    style: menuStyle,
                                  ),
                                )
                              ],
                            ),
                          )
                        : const SizedBox();
                  });
                }
              ),

              Consumer<UserProvider>(builder: (context, val99, child) {
                return val99.userType == "LEADER"
                    ? SizedBox(
                        height: height / 50.05882352941176,
                      )
                    : const SizedBox();
              }),
              // InkWell(
              //   onTap: () async {
              //     String generatedDeepLink=await FirebaseDynamicLinkService.createDynamicLink(true,'1687254485030yq');
              //     Share.share('${"Lio care"}:\nDownload Lio care to read more and be updated $generatedDeepLink',
              //         subject:
              //         'Look what I made!');
              //
              //   },
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       SizedBox(width: 50),
              //      const Icon(Icons.share,color: Colors.red,),
              //       Padding(
              //         padding: const EdgeInsets.only(left: 14.0),
              //         child: Text("Share link ",style: menuStyle,),
              //       )
              //     ],
              //   ),
              // ),
              // SizedBox(height: 25,),
              Consumer<UserProvider>(
                builder: (context4,value4,child) {
                  return InkWell(
                    onTap: () {
                      value4.logOutAlert(context,false);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width / 7.86,
                        ),
                        const Icon(
                          Icons.logout_sharp,
                          color: myWhite,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Text(
                            "Logout",
                            style: menuStyle,
                          ),
                        )
                      ],
                    ),
                  );
                }
              ),

              SizedBox(
                height: height / 50.05882352941176,
              ),
              Consumer<UserProvider>(builder: (context3, value3, child) {
                return InkWell(
                  onTap: () async {
                    String generatedDeepLink =
                        await FirebaseDynamicLinkService.createDynamicLink(
                            true, value3.userPhone);

                    Share.share(
                        '${"Lio club"}:\n\nDownload Lio club to read more and be updated $generatedDeepLink',
                        subject: 'Look what I made!');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 311,
                    height: height / 18,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(1.00, -0.01),
                        end: Alignment(-1, 0.01),
                        colors: [ Color(0xFF2F97BD),Color(0xFF2F97BD),Color(0xFF2F97BD),Color(0xFF2F97BD),Color(0xFF2F7DC1),],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Invite Member",
                      style: TextStyle(
                        color: clFFFCF8,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),



              Padding(
                padding: const EdgeInsets.only(left: 30,right: 10),
            child: SizedBox(
              height: 35,
              child: ListTile(
                onTap: () {
                  alertTermsAndConditions(context);
                },
                minLeadingWidth:20 ,
                title: Text(

                "Terms and Condition",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: "PoppinsMedium",
                      fontWeight: FontWeight.w500
                  ),
                ),
                trailing: const Icon(Icons.chevron_right,color: Colors.white),
              ),
            ),
          ),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 10),
            child: SizedBox(
              height: 40,
              child: ListTile(
                onTap: () {
                  alertContact(context);
                },
                minLeadingWidth:20 ,
                title: Text(

                "Contact Us",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: "PoppinsMedium",
                      fontWeight: FontWeight.w500
                  ),
                ),
                trailing: const Icon(Icons.chevron_right,color: Colors.white),
              ),
            ),
          ),

        SizedBox(height: 30,)
        // const Divider(color: listtile,thickness: 1,)

            ],
          ),
        ),
      ),
    );
  }

  // logOutAlert(BuildContext context) {
  //   final height = MediaQuery.of(context).size.height;
  //   final width = MediaQuery.of(context).size.width;
  //   AlertDialog alert = AlertDialog(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       contentPadding: const EdgeInsets.all(0),
  //       backgroundColor: cl00369F,
  //       scrollable: true,
  //       content: Container(
  //         // height: height*0.26,
  //         width: width,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(20),
  //           gradient: const LinearGradient(
  //             begin: Alignment(0.92, -0.40),
  //             end: Alignment(-0.92, 0.4),
  //             colors: [
  //               Color(0xFF2FC1BC),
  //               Color(0xFF2F7DC1),
  //             ],
  //           ),
  //         ),
  //         child: Column(
  //           children: [
  //             Center(
  //               child: Column(
  //                 children: [
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   const Text(
  //                     "Are you sure",
  //                     style: TextStyle(
  //                         color: myWhite,
  //                         fontFamily: 'PoppinsMedium',
  //                         fontWeight: FontWeight.w500,
  //                         fontSize: 16),
  //                   ),
  //                   const Text(
  //                     "want to log out?",
  //                     style: TextStyle(
  //                         color: myWhite,
  //                         fontFamily: 'PoppinsMedium',
  //                         fontWeight: FontWeight.w500,
  //                         fontSize: 16),
  //                   ),
  //                   const SizedBox(height: 20),
  //                   Container(
  //                     width: 62,
  //                     height: 62,
  //                     clipBehavior: Clip.antiAlias,
  //                     decoration: ShapeDecoration(
  //                       gradient: const LinearGradient(
  //                         begin: Alignment(0.92, -0.40),
  //                         end: Alignment(-0.92, 0.4),
  //                         colors: [
  //                           Color(0xFF2FC1BC),
  //                           Color(0xFF2F7DC1),
  //                         ],
  //                       ),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(102),
  //                       ),
  //                       shadows: const [
  //                         BoxShadow(
  //                           color: Color(0x1C000000),
  //                           blurRadius: 11,
  //                           offset: Offset(0, 9),
  //                           spreadRadius: 0,
  //                         )
  //                       ],
  //                     ),
  //                     child: const Center(
  //                         child: Icon(
  //                       Icons.logout,
  //                       color: myWhite,
  //                     )),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             const SizedBox(height: 20),
  //             SizedBox(
  //               height: 50,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 5),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         InkWell(
  //                           onTap: () {
  //                             finish(context);
  //                           },
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             width: 120,
  //                             height: 39,
  //                             decoration: BoxDecoration(
  //                                 boxShadow: const [
  //                                   BoxShadow(
  //                                     color: Color(0xFF2FC1BC),
  //                                     offset: Offset(0.0, 1.0), //(x,y)
  //                                     blurRadius: 1.0,
  //                                   ),
  //                                 ],
  //                                 color: const Color(0xFF2F7DC1),
  //                                 borderRadius: BorderRadius.circular(20)),
  //                             child: const Text('Cancel',
  //                                 style: TextStyle(
  //                                     fontSize: 16,
  //                                     color: Colors.white,
  //                                     fontFamily: "PoppinsMedium")),
  //                           ),
  //                         ),
  //                         Consumer<UserProvider>(
  //                           builder: (context3,value3,child) {
  //                             return InkWell(
  //                               onTap: () async {
  //                                 value3._streamDistributions!.cancel();
  //                                 value3.clearFunction();
  //                                 FirebaseAuth auth = FirebaseAuth.instance;
  //                                 auth.signOut();
  //                                 finish(context);
  //                                 Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
  //                                     LoginScreen(referralId: '',)), (Route<dynamic> route) => false);
  //                                 // callNextReplacement(
  //                                 //     LoginScreen(
  //                                 //       referralId: '',
  //                                 //     ),
  //                                 //     context);
  //                               },
  //                               child: Container(
  //                                 alignment: Alignment.center,
  //                                 width: 120,
  //                                 height: 39,
  //                                 decoration: BoxDecoration(
  //                                     color: Colors.white,
  //                                     borderRadius: BorderRadius.circular(20)),
  //                                 child: const Text(
  //                                   'Log out',
  //                                   style: TextStyle(
  //                                       color: Color(0xFF2F7DC1),
  //                                       fontSize: 16,
  //                                       fontFamily: "PoppinsMedium"),
  //                                 ),
  //                               ),
  //                             );
  //                           }
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             const SizedBox(height: 20),
  //           ],
  //         ),
  //       ));
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
}
