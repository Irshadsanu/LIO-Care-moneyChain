import 'package:flutter/material.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:lio_care/admin/screens/kyc_upload_list.dart';
import 'package:lio_care/admin/screens/totalRegistrations_screen.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:lio_care/constants/my_colors.dart';
import 'package:provider/provider.dart';

import '../admin_leaders.dart';
import 'admin_admins_screen.dart';
import 'admin_amfReport_screen.dart';
import 'admin_blockedUsers_screen.dart';
import 'admin_delete_member_screen.dart';
import 'admin_donationReport_screen.dart';
import 'admin_exchangeUser_screen.dart';
import 'admin_exchange_List.dart';
import 'admin_give_help_screen.dart';
import 'admin_helpReportScreen.dart';
import 'admin_members_screen.dart';
import 'admin_participants_screen.dart';
import 'admin_refferalLedger_screen.dart';
import 'admin_taskAssign_screen.dart';
import 'assignedTasks.dart';
import 'logout_screen.dart';

class AdminMenuScreen extends StatelessWidget {
  const AdminMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AdminProvider adminProvider=Provider.of<AdminProvider>(context,listen: false);
    return Scaffold(

      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.98, -0.40),
              end: Alignment(-0.92, 0.40),
              colors: [ Color(0xFF2FC1BC),Color(0xFF2F7DC1),],
            ),
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        leadingWidth: 18,
        toolbarHeight: 65,
        leading: const SizedBox(),
        title: const Text("Dashboard"),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: cWhite,
          fontFamily: "PoppinsRegular"
        ),

      ),
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.92, -0.40),
            end: Alignment(-0.92, 0.4),
            colors: [ Color(0xFF2FC1BC),Color(0xFF2F7DC1),],
          ),
        ),
        child: Consumer<AdminProvider>(
          builder: (context1,val2,child) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(width / 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    val2.adminImage.isEmpty?
                     CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.white,
                      child: Image.asset(
                       'assets/bluelogo.png',scale: 4,
                      ),
                    )
                        :  CircleAvatar(
                backgroundImage:  NetworkImage(
                val2.adminImage,scale: 4,
              ),
              radius: 38,
              backgroundColor: Colors.white,

            ),
                    items(
                        icon: "assets/taskAssign.png",
                        text: " Assign Task",
                        action: () {
                          val2.getAssignedTasksAdmin();
                          callNext(  AssignedTasks(), context);

                        }),
                    items(
                        icon: "assets/admin.png", text: "Admins",
                        action: () {
                          callNext(const Admins(), context);
                  }),
                    items(
                        icon: "assets/adminLeaders.png", text: "Admin Leaders",
                        action: () {
                          callNext(const AdminLeaders(), context);
                  }),
                    items(
                        icon: "assets/membersLogo.png",
                        text: "Members",
                        action: () {
                          adminProvider. firstFetchMembers(true);
                          callNext(const AdminMembersScreen(), context);
                        val2.showSelectedDate='';

                        }),
                    items(
                        icon: "assets/kyc_submitted_users.png",
                        text: "KYC Submitted Members",
                        action: () {
                          adminProvider. fetchMembersKycSubmitted();
                          callNext(const KycUploadedScreen(), context);

                        }),

                    // items(
                    //     icon: "assets/participant.png",
                    //     text: "Participants",
                    //     action: () {
                    //       adminProvider.fetchParticipants(true);
                    //       callNext(const AdminParticipantsScreen(), context);}),

                    items(
                        icon: "assets/registration.png",
                        text: "Registration list",
                        action: () {
                          adminProvider.fetchPendingRegistrations(true);

                          callNext(const AdminTotalRegistrationsScreen(), context);
                        }),
                    items(
                        icon: "assets/giveHelp.png",
                        text: "Help Report",
                        action: () {

                          adminProvider.fetchAdminHelpReport(true);

                          callNext(const HelpReport(), context);}),
                    val2.adminPrivilegeList.contains("Total amounts")
                    ?items(
                        icon: "assets/mydonation.png",
                        text: "CMF Report",
                        action: () {
                          adminProvider.fetchAdminDonationData(true);
                          callNext(const AdminDonationReportScreen(), context);})
                    :const SizedBox(),

                    items(
                        icon: "assets/helpledger.png",
                        text: "Referral Income ",
                        action: () {callNext(const ReferralLedger(), context);}),
                    val2.adminPrivilegeList.contains("Total amounts")
                        ?items(
                        icon: "assets/amfReport.png",
                        text: "Payment Report PMC ",
                        action: () {
                          adminProvider.fetchAdminPMCData("PMC",true);
                          callNext( AdminAmfReportScreen(type: "PMC"), context);})
                        :const SizedBox(),
                    items(
                        icon: "assets/myAmf.png",
                        text: "Payment Report HELP ",
                        action: () {
                          adminProvider.fetchAdminTotalGiveHelp(true);
                          callNext(const AdminGiveHelp(), context);

                        }),
                    items(
                        icon: "assets/block.png",
                        text: "Blocked Users ",
                        action: () {
                          val2.showSelectedDate="";
                          val2.fetchBlockedUsers();
                          callNext(const AdminBlockedUsers(), context);}),

                    items(
                        icon: "assets/delete_user.png",
                        text: "Delete users ",
                        action: () {
                          callNext( DeleteMember(), context);}),

                    val2.adminPrivilegeList.contains("Exchange user")
                        ?items(
                        icon: "assets/exchange.png",
                        text: "Exchange User",
                        action: () {
                          val2.getExchangeDetails();
                          callNext(const ExchangeUserList(), context);
                          // val2.clearAllExchangeControllers();
                          // val2.exchangeOtherCheck=false;
                          // val2.fileImage=null;
                          // val2.selectedExchange='';
                          // callNext( ExchangeUserScreen(), context);
})
                        :const SizedBox(),



                    // items(
                    //     icon: "assets/bank.png",
                    //     text: "Bank Balance",
                    //     action: () {callNext(const BankBalance(), context);}),
                    items(icon: "assets/logout.png", text: "Logout", action: () {
                      callNext(const Logout(), context);
                    }),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}

Widget items(
    {required String icon, required String text, required Function() action}) {
  return Padding(
    padding: const EdgeInsets.only(left: 18),
    child: TextButton(onPressed:action ,
      child: Row(
        children: [
          SizedBox(height: 20, width: 20, child: Image.asset(icon,color: myWhite,)),
          const SizedBox(
            width: 12,
          ),
          Text(
            text,

        style: const TextStyle(  fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white,fontFamily: "PoppinsRegular"),
          ),



        ],
      ),
    ),
  );
}
