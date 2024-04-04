import 'package:flutter/material.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:lio_care/admin/screens/memberDetails_screen.dart';
import 'package:lio_care/models/members_Model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/functions.dart';
import '../../constants/my_colors.dart';
import '../../view/Widgets/my_widgets.dart';
import 'admin_homeScreen.dart';
import 'admin_menu_screen.dart';
import 'blockParticipant_screen.dart';

class AdminMembersScreen extends StatelessWidget {
  const AdminMembersScreen({Key? key}) : super(key: key);

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
      appBar: AppBar(titleSpacing: .015,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(" Members"),
            Consumer<AdminProvider>(builder: (context1, val20, child) {
              return Row(children: [
                Builder(
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0,bottom: 4),
                        child: InkWell(
                          onTap: () {
                            val20.downloadExcelForMembers(val20.filterMembersList,"DOWNLOAD");
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
                                  Icon(Icons.download,color: Colors.white,size: 20,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0,bottom: 4),
                  child: InkWell(
                    onTap: () {
                      val20.downloadExcelForMembers(val20.filterMembersList,"SHARE");
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      // width: 200,
                      decoration: const ShapeDecoration(
                          shape: StadiumBorder()),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 5.0, right: 5),
                        child: Row(
                          children: [
                            Icon(Icons.share , color: Colors.white, size: 18)
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
              child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: searchBar("MEMBERS")),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 25),
              child: Consumer<AdminProvider>(builder: (context1, val20, child) {
                return Column(
crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 20,bottom:8),
                      child: Text("Kyc status",style: TextStyle(color: Colors.black54)),
                    ),
                    val20.showSelectedDate != ""
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0,),
                          child: InkWell(
                            onTap: () {
                              val20.showCalendarDialog(context, "MEMBERS");
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              // width: 200,
                              decoration: const ShapeDecoration(
                                  shape: StadiumBorder(), color: clF4F6F8),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5),
                                child: Text(val20.showSelectedDate),
                              ),
                            ),
                          ),
                        ),

                        Consumer<AdminProvider>(
                            builder: (context2, value, child) {
                              return Container(
                                height: 40,
                                width: 130,
                                decoration: const ShapeDecoration(
                                    shape: StadiumBorder(), color: clF4F6F8),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: DropdownButton<String>(
                                    alignment: AlignmentDirectional.bottomStart,
                                    underline: const Text(''),
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded),
                                    elevation: 1,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: cBlack,
                                      fontSize: 12,
                                      fontFamily: "PoppinsRegular",
                                    ),
                                    value: value.kycValue,
                                    onChanged: (String? newValue) {
                                      value.kycValue = newValue.toString();
                                      value.filterMembersKycBased(
                                          newValue.toString());
                                    },
                                    items:
                                    value.kycStatusList.map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            }),
                      ],
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: InkWell(
                            onTap: () {
                              val20.showCalendarDialog(context, "MEMBERS");
                            },
                            child: Container(
                              height: 30,
                              width: 100,
                              decoration: const ShapeDecoration(
                                  shape: StadiumBorder(), color: clF4F6F8),
                              child: const Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Date",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "PoppinsRegular"),
                                  ),
                                  Icon(Icons.keyboard_arrow_down_outlined),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Consumer<AdminProvider>(
                            builder: (context3, value, child) {
                              return Container(
                                margin: const EdgeInsets.only(right: 20),
                                height: 30,
                                width: 130,
                                decoration: const ShapeDecoration(
                                  shape: StadiumBorder(),
                                  color: clF4F6F8,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: PopupMenuButton<String>(
                                    itemBuilder: (BuildContext context) {
                                      return value.kycStatusList
                                          .map((String item) {
                                        return PopupMenuItem<String>(
                                          value: item,
                                          child: SizedBox(
                                            width:
                                            130, // Adjust the width as needed
                                            child: Text(item),
                                          ),
                                        );
                                      }).toList();
                                    },
                                    onSelected: (String? newValue) {
                                      value.kycValue = newValue.toString();
                                      value.filterMembersKycBased(
                                          newValue.toString());
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          value
                                              .kycValue!, // Display the selected value
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: cBlack,
                                            fontSize: 12,
                                            fontFamily: "PoppinsRegular",
                                          ),
                                        ),
                                        const Icon(
                                            Icons.keyboard_arrow_down_rounded),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ],
                );
              }),
            ),
            // Consumer<AdminProvider>(builder: (context4, value, child) {
            //   return Padding(
            //     padding: const EdgeInsets.only(left: 21.0, top: 34),
            //     child: Row(
            //       children: [
            //         Text(
            //           "${value.filterMembersList.length}/${value.membersCount}",
            //           style: const TextStyle(
            //               color: cl3760AE,
            //               fontSize: 13,
            //               fontWeight: FontWeight.w500,
            //               fontFamily: "PoppinsRegular"),
            //         ),
            //         const Text(
            //           " Members",
            //           style: TextStyle(
            //               color: Colors.black54,
            //               fontSize: 13,
            //               fontWeight: FontWeight.w400,
            //               fontFamily: "PoppinsRegular"),
            //         ),
            //       ],
            //     ),
            //   );
            // }),
            Consumer<AdminProvider>(builder: (context5, val2, child) {
              return val2.filterMembersList.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                      ),
                      itemCount: val2.filterMembersList.length,
                      itemBuilder: (BuildContext context, int index) {
                        MembersModel item = val2.filterMembersList[index];
                        return InkWell(
                          onTap: () async {
                            await val2.fetchMemberInviteesCount(item.regid);
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
                                      val2.adminPrivilegeList.contains("Members changes")
                                      ?PopupMenuButton(
                                        color: cl004CA8,
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              value: 0,
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/blockParticipate.png",
                                                    color: myWhite,
                                                    scale: 1.5,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  const Text(
                                                    ' Block Participants',
                                                    style: TextStyle(
                                                        color: myWhite,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            "PoppinsRegular"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ];
                                        },
                                        onSelected: (value) {
                                          if (value == 0) {
                                            val2.selectedReason = '';
                                            val2.reportOtherCheck=false;
                                            callNext(
                                                AdminBlockParticipantScreen(
                                                  name: item.name,
                                                  regId: item.regid,
                                                  number: item.phone,
                                                  proImage: item.proImage,
                                                  from: '',
                                                ),
                                                context);
                                          }
                                        },
                                      )
                                          :const SizedBox(height: 10,width: 10,)
                                    ],
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
            Consumer<AdminProvider>(builder: (context6, value, child) {
              return value.membersListLimit > value.membersList.length||
                  value.filterMembersList.isEmpty || value.isDateSelected
                  ? const SizedBox()
                  : Center(
                      child: value.kycValue == 'Kyc Status' ||
                              value.kycValue == 'All'
                          ? InkWell(
                              onTap: () {
                                value.firstFetchMembers(
                                    false,
                                    value
                                        .membersList[
                                            value.membersList.length - 1]
                                        .regDateTime);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: loadMoreBg,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 40, top: 8, bottom: 8),
                                    child: Text(
                                      "Load More",
                                      style: TextStyle(
                                          color: textColor,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                  )),
                            )
                          : const SizedBox(),
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
