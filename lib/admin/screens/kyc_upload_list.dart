import 'package:flutter/material.dart';
import 'package:lio_care/constants/my_colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants/functions.dart';
import '../../Provider/admin_provider.dart';
import '../../models/members_Model.dart';
import '../../view/Widgets/my_widgets.dart';
import 'admin_homeScreen.dart';
import 'admin_menu_screen.dart';
import 'blockParticipant_screen.dart';
import 'memberDetails_screen.dart';

class KycUploadedScreen extends StatelessWidget {
  const KycUploadedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      endDrawer: Drawer(
        width: width,
        child: const AdminMenuScreen(),
      ),
      backgroundColor: bxkclr,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.bottomLeft,
              colors: [
                cl005BBB,
                cl001969,
              ],
            ),
          ),
        ),
        backgroundColor: cWhite,
        leadingWidth: 30,
        leading:InkWell(
          onTap: (){
            callNextReplacement(const AdminHomeScreen(),context);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Icon(Icons.arrow_back_ios,color: myWhite,),
          ),
        ),
        toolbarHeight: 65,
        elevation: 0,
        titleSpacing: .015,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width/2.5,
                child: const Text("KYC Submitted Members",textAlign: TextAlign.center,maxLines: 3,)),
            Consumer<AdminProvider>(builder: (context1, val20, child) {
              return Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0,bottom: 4,top: 5,left: 8),
                    child: InkWell(
                      onTap: () {
                        val20.downloadExcelForMembers(val20.membersKycSubmittedList,"DOWNLOAD");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        // width: 200,
                        decoration: const ShapeDecoration(
                            shape: StadiumBorder(),),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 5.0, right: 5),
                          child: Row(
                            children: [
                              Icon(Icons.download,color: Colors.white,size: 20,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0,bottom: 4),
                    child: InkWell(
                      onTap: () {
                        val20.downloadExcelForMembers(val20.membersKycSubmittedList,"SHARE");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        // width: 200,
                        decoration: const ShapeDecoration(
                            shape: StadiumBorder()),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 5.0, right: 5),
                          child: Row(
                            children: [
                              Icon(Icons.share,color: Colors.white,size: 18)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],);
            }
            ),

          ],
        ),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: cWhite,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          // Padding(
          //   padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
          //   child: Card(
          //       elevation: 4,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(200),
          //       ),
          //       child: searchBar("MEMBERS")),
          // ),
          Consumer<AdminProvider>(builder: (context5, val2, child) {
            return val2.membersKycSubmittedList.isNotEmpty
                ? Expanded(
                  child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
                  itemCount: val2.membersKycSubmittedList.length,
                  itemBuilder: (BuildContext context, int index) {
                    MembersModel item = val2.membersKycSubmittedList[index];
                    return InkWell(
                      onTap: () {
                        callNext(MemberDetailsScreen(
                          memberDocID: item.docID,
                          memberName: item.name,
                          memberPhone: item.phone,
                          memberRegId: item.regid,
                          memberRegDate: item.regDate,
                          memberPMC: item.pmc,
                          memberDonation: item.donations,
                          memberReceiveHelp: item.receiveHelp,
                          memberInvitations: item.invitor,
                          memberGiveHelp: item.giveHelp,
                          memberKycStatus: item.kycStatus, memberImage: item.proImage,
                          kycSubmitted: item.kycSubmittedDate, kycVerified:item.kycVerifiedDate,
                          kycRejected: item.kycRejectedDate, memberReferredBy: item.memberReferredBy,kycRejectedReason: item.kycRejectedReason,
                        ),
                            context);
                      },
                      child: Container(
                        // height: height / 14,
                        width: width / 3,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: const LinearGradient(
                              colors: [clFFFCF8, myWhite]),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 2),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 2),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: SizedBox(
                                  width: width/1.5,
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                        height: 1,
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        fontFamily: "PoppinsRegular"),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  item.kycStatus != ""
                                      ? Text(
                                    "KYC ${item.kycStatus}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.orange,
                                        fontFamily: "PoppinsRegular",
                                        fontWeight: FontWeight.w400),
                                  )
                                      : const SizedBox(),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      item.regDate,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          fontFamily: "PoppinsRegular"),
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Reg.No :${item.regid}",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black87,
                                          fontFamily: "PoppinsRegular",
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        item.type,
                                        style:  TextStyle(
                                            color: item.type=="LEADER"? cl00369F:cl303030,
                                            fontFamily: "PoppinsRegular",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "+91 ${item.phone}",
                                    style: const TextStyle(
                                        decoration:
                                        TextDecoration.underline,
                                        color: Colors.black87,
                                        fontFamily: "PoppinsRegular",
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      "More",
                                      style: TextStyle(
                                          decoration:
                                          TextDecoration.underline,
                                          color: cl16B200,
                                          fontFamily: "PoppinsRegular",
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12),
                                    ),
                                  ),

                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      launch(
                                          'whatsapp://send?phone=${item.phone}');
                                    },
                                    child: Container(
                                        height: 30,
                                        width: width / 6,
                                        decoration: BoxDecoration(
                                            color: grdintclr2,
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        child: Image.asset(
                                          "assets/whatsapp.png",
                                          scale: 1,
                                        )),
                                  ),
                                  SizedBox(
                                    width: width * .02,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      launch("tel://${item.phone}");
                                    },
                                    child: Container(
                                      height: 30,
                                      width: width / 6,
                                      decoration: BoxDecoration(
                                          color: grdintclr2,
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      child: const Icon(
                                        Icons.call,
                                        color: Colors.black,
                                        size: 17,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                )
                : SizedBox(
              height: height * .45,
              child: const Center(
                child: Text(
                  "No Members Found !!!",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            );
          }),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
