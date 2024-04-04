import 'package:flutter/material.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:lio_care/admin/screens/memberDetails_screen.dart';
import 'package:lio_care/models/members_Model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/functions.dart';
import '../../constants/my_colors.dart';
import '../../view/Widgets/my_widgets.dart';
class AdminLeaders extends StatelessWidget {
  const AdminLeaders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bxkclr,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        toolbarHeight: 65,
        elevation: 0,
        title: const Text("  Admin Leaders"),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: cWhite,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<AdminProvider>(builder: (context5, val2, child) {
              return val2.adminLeadersList.isNotEmpty
                  ? ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
                  itemCount: val2.adminLeadersList.length,
                  itemBuilder: (BuildContext context, int index) {
                    MembersModel item = val2.adminLeadersList[index];
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
                          kycSubmitted: item.kycSubmittedDate,
                          kycVerified:item.kycVerifiedDate,
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
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Padding(
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
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
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
                  })
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
      ),
    );
  }
}
