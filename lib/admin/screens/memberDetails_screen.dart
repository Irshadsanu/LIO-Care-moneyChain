import 'package:flutter/material.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Provider/user_provider.dart';
import '../../constants/my_colors.dart';
import '../../help_tree/tree_provider.dart';
import '../../view/Widgets/my_widgets.dart';
import 'admin_approve_member_kyc.dart';

class MemberDetailsScreen extends StatelessWidget {
  final String memberDocID;
  final String memberName;
  final String memberPhone;
  final String memberRegId;
  final String memberRegDate;
  final String memberPMC;
  final String memberDonation;
  final String memberReceiveHelp;
  final String memberInvitations;
  final String memberReferredBy;
  final String memberGiveHelp;
  final String memberKycStatus;
  final String memberImage;
  final String kycSubmitted;
  final String kycVerified;
  final String kycRejected;
  final String kycRejectedReason;

  const MemberDetailsScreen(
      {Key? key,
      required this.memberDocID,
      required this.memberName,
      required this.memberPhone,
      required this.memberRegId,
      required this.memberRegDate,
      required this.memberPMC,
      required this.memberDonation,
      required this.memberReceiveHelp,
      required this.memberInvitations,
      required this.memberReferredBy,
      required this.memberGiveHelp,
      required this.memberKycStatus,
      required this.memberImage,
      required this.kycSubmitted,
      required this.kycVerified,
      required this.kycRejected,
        required this.kycRejectedReason,


      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
// print(memberName);
// print(memberImage);
// print(memberDocID);
// print(memberRegId);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    AdminProvider adminProvider=Provider.of<AdminProvider>(context,listen:false);
    return Scaffold(
      backgroundColor: bxkclr,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              finish(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: myWhite,
            )),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [cl001969, cl005BBB])),
        ),
        elevation: 0,
        title: Text(
          "Member Details",
          style: appbarStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height:55,
                color:clECF4FF,
              child: Consumer<AdminProvider>(
                builder: (context,value1,child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          const Text(
                            'KYC Status',
                            style: TextStyle(
                              color: cl252525,
                              fontSize: 14,
                              fontFamily: 'PoppinsMedium',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.28,
                            ),
                          ),
                          Text(
                            memberKycStatus,
                            style: const TextStyle(
                              color: cl3760AE,
                              fontSize: 12,
                              fontFamily: 'PoppinsRegular',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.24,
                            ),
                          )
                        ]
                      ),
                      memberKycStatus=="SUBMITTED"?
                      InkWell(
                        onTap: (){
                          adminProvider.memberDetailsForApprove(memberRegId);
                          callNext( ApproveMemberKYC(memberRegId: memberRegId,), context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width:100,
                          height: 33,
                          decoration:BoxDecoration(
                            color:cl2F7DC1,
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: const Text(
                            'Verify',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: cWhite,
                              fontSize: 13,
                              fontFamily: 'PoppinsRegular',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.24,
                            ),
                          ),
                        ),
                      ):memberKycStatus=="REJECTED"?Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Reason",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black38,
                                fontFamily: "PoppinsRegular",
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            kycRejectedReason ?? "",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                                fontFamily: "PoppinsRegular",
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ):const SizedBox()
                    ],
                  );
                }
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: const LinearGradient(colors: [clFFFCF8, myWhite]),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 30, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            memberName,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: "PoppinsRegular"),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Reg.No :$memberRegId",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontFamily: "PoppinsRegular",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Text(
                        "+91 $memberPhone",
                        style: const TextStyle(
                            color: Colors.black87,
                            fontFamily: "PoppinsMedium",
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                      Divider(
                        thickness: 1,
                        indent: 11,
                        endIndent: 11,
                        color: textColor,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 11.0),
                            child: Text(
                              "Join Date",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 11.0),
                            child: Text(
                              memberRegDate,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      kycSubmitted!="" ?Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 11.0),
                            child: Text(
                              "KYC Submitted Date",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 11.0),
                            child: Text(
                              kycSubmitted,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ):const SizedBox(),
                      kycVerified!="" ?Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 11.0),
                            child: Text(
                              "KYC Verified Date",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 11.0),
                            child: Text(
                              kycVerified,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ):const SizedBox(),
                      kycRejected!="" ?Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 11.0),
                            child: Text(
                              "KYC Rejected Date",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 11.0),
                            child: Text(
                              kycRejected,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ):const SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 11.0),
                            child: Text(
                              "Invitations",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 11.0),
                            child: Text(
                              // memberInvitations,
                              adminProvider.memberInviteesCount,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 11.0),
                            child: Text(
                              "PMC",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 11.0),
                            child: Text(
                              memberPMC,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  // fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 11.0),
                            child: Text(
                              "PRC",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(right: 11.0),
                            child: Text(
                              "100",
                              style: TextStyle(
                                  color: Colors.black87,
                                  // fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 11.0),
                            child: Text(
                              "CMF",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 11.0),
                            child: Text(
                              memberDonation,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  // fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 11.0),
                            child: Text(
                              "Give Help",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 11.0),
                            child: Text(
                              memberGiveHelp,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  // fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 11.0),
                            child: Text(
                              "Receive Help",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 11.0),
                            child: Text(
                              memberReceiveHelp,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  // fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 11.0),
                            child: Text(
                              "Referred By",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 11.0),
                            child: Text(
                              memberReferredBy,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  // fontFamily: "PoppinsRegular",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Consumer<TreeProvider>(
                          builder: (context5,value123,child) {
                          return Center(
                            child: InkWell(
                              onTap: () {
                                UserProvider user=Provider.of<UserProvider>(context,listen: false);

                                showModalBottomSheet<void>(
                                  shape: const RoundedRectangleBorder( // <-- SEE HERE
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0),
                                    ),
                                  ),
                                  context: context,
                                  builder: (BuildContext context) {
                                    final width=MediaQuery.of(context).size.width;
                                    return SizedBox(
                                      height: 250,
                                      child: Center(
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Container(
                                              width:width,
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                color:cWhite,
                                                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),),
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
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children:[
                                                    Image.asset("assets/downArrow.png",scale: 3,color: cl303030.withOpacity(0.50),),
                                                    const Text(
                                                      'Help Tree',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color:cl252525,
                                                        fontSize: 15,
                                                        fontFamily: 'PoppinsRegular',
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ),
                                            const SizedBox(height: 5,),
                                            Flexible(
                                              fit: FlexFit.tight,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(15, 8, 12, 10),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        await value123.fetchHelpTree(memberRegId,memberDocID,"MASTER_CLUB",
                                                            memberImage,context,"ADMIN",memberName);

                                                        // await value123.fetchHelpTree("1001","10001","MASTER_CLUB",
                                                        //     user.userProfileImage,context);

                                                      },
                                                      child: SizedBox(
                                                        height: 50,

                                                        child: Row(
                                                          children: [
                                                            const Expanded(
                                                              flex:1,
                                                              child: Text(
                                                                'Master Club',
                                                                style: TextStyle(
                                                                  color: cl252525,
                                                                  fontSize: 15,
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(width:5),
                                                            Expanded(
                                                              flex:1,
                                                              child: Container(
                                                                  alignment: Alignment.centerRight,
                                                                  child:Icon(Icons.arrow_forward_ios,color:cl303030.withOpacity(0.30))
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    InkWell(
                                                      onTap: () async {
                                                        await value123.fetchHelpTree(memberRegId,memberDocID,"STAR_CLUB",
                                                            memberImage,context,"ADMIN",memberName);
                                                      },
                                                      child: SizedBox(
                                                        height: 50,
                                                        child: Row(
                                                          children: [
                                                            const Expanded(
                                                              flex:1,
                                                              child: Text(
                                                                'STAR CLUB',
                                                                style: TextStyle(
                                                                  color: cl252525,
                                                                  fontSize: 15,
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(width:5),
                                                            Expanded(
                                                              flex:1,
                                                              child: Container(
                                                                  alignment: Alignment.centerRight,
                                                                  child:Icon(Icons.arrow_forward_ios,color:cl303030.withOpacity(0.30))
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    InkWell(
                                                      onTap: () async {
                                                        await value123.fetchHelpTree(memberRegId,memberDocID,"CROWN_CLUB",
                                                            memberImage,context,"ADMIN",memberName);

                                                      },
                                                      child: SizedBox(
                                                        height: 50,
                                                        child: Row(
                                                          children: [
                                                            const Expanded(
                                                              flex:1,
                                                              child: Text(
                                                                'CROWN CLUB',
                                                                style: TextStyle(
                                                                  color: cl252525,
                                                                  fontSize: 15,
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(width:5),
                                                            Expanded(
                                                              flex:1,
                                                              child: Container(
                                                                  alignment: Alignment.centerRight,
                                                                  child:Icon(Icons.arrow_forward_ios,color:cl303030.withOpacity(0.30))
                                                              ),
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
                                );




                              },
                              child: Container(
                                height: 30,
                                width: 161,
                                decoration: BoxDecoration(
                                  color: clFF731D,
                                  borderRadius: BorderRadius.circular(21.4),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Help Tree",
                                    style: TextStyle(
                                        color: myWhite,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "PoppinsMedium"),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {

                              launch ('whatsapp://send?phone=$memberPhone');
                            },
                            child: Container(
                                height: 30,
                                width: width / 6,
                                decoration: BoxDecoration(
                                    color: grdintclr2,
                                    borderRadius: BorderRadius.circular(20)),
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
                              launch ("tel://$memberPhone");
                            },
                            child: Container(
                              height: 30,
                              width: width / 6,
                              decoration: BoxDecoration(
                                  color: grdintclr2,
                                  borderRadius: BorderRadius.circular(20)),
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
                        height: 18,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
