import 'package:flutter/material.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:provider/provider.dart';

import '../../Constants/functions.dart';
import '../../constants/my_colors.dart';
import 'admin_homeScreen.dart';
import 'admin_menu_screen.dart';

class ExchangeApproveScreen extends StatelessWidget {
  const ExchangeApproveScreen({
    super.key,
    required this.from,
    required this.docId,
    required this.apId,
    required this.apName,
    required this.apPhone,
    required this.apTime,
    required this.reqId,
    required this.reqName,
    required this.reqPhone,
    required this.reqTime,
    required this.proofImage,
    required this.fromId,
    required this.fromName,
    required this.fromNumber,
    required this.toId,
    required this.toName,
    required this.toNumber,
    required this.reason,
    required this.status,
  });

  final String from;
  final String docId;
  final String apId;
  final String apName;
  final String apPhone;
  final String apTime;
  final String reqId;
  final String reqName;
  final String reqPhone;
  final String reqTime;
  final String proofImage;
  final String fromId;
  final String fromName;
  final String fromNumber;
  final String toId;
  final String toName;
  final String toNumber;
  final String reason;
  final String status;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print(width);
    return Scaffold(
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width,
        child: const AdminMenuScreen(),
      ),
      backgroundColor: bxkclr,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 20,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.menu,
                    color: cWhite,
                  ),
                ),
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
        toolbarHeight: 65,
        leadingWidth: 30,
        leading: InkWell(
          onTap: () {
            callNextReplacement(const AdminHomeScreen(), context);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: myWhite,
            ),
          ),
        ),
        title: Image.asset(
          "assets/whitelogo.png",
          scale: 12,
        ),
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
      ),
      body: Center(
        child: SizedBox(
          height: height,
          width: width / 1.1,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        from == "REQUEST" ? reqName : apName,
                        style: const TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 16,
                          fontFamily: 'PoppinsRegular',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.32,
                        ),
                      ),
                      Text(
                        from == "REQUEST" ? reqTime : apTime,
                        style: const TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 10,
                          fontFamily: 'PoppinsRegular',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.20,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Opacity(
                    opacity: 0.80,
                    child: Text(
                      from == "REQUEST" ? 'Reg. No : $reqId' : 'Reg. No : $apId',
                      style: const TextStyle(
                        color: Color(0xFF252525),
                        fontSize: 12,
                        fontFamily: 'PoppinsRegular',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.24,
                      ),
                    ),
                  ),
                ),
                from != "REQUEST" &&reqName!=""? Align(
                  alignment: Alignment.topLeft,
                  child: Opacity(
                    opacity: 0.80,
                    child: Text("Requested By : $reqName",
                      style: const TextStyle(
                        color: Color(0xFF252525),
                        fontSize: 12,
                        fontFamily: 'PoppinsRegular',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.24,
                      ),),
                  ),
                ):const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        clipBehavior: Clip.antiAlias,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFFFCF8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x0C000000),
                              blurRadius: 11,
                              offset: Offset(0, 3),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Text(
                          "$fromName\n$fromNumber\n$fromId",
                          style: const TextStyle(
                            color: Color(0xFF252525),
                            fontSize: 12,
                            fontFamily: 'PoppinsRegular',
                            fontWeight: FontWeight.w500,
                            height: 1.20,
                            letterSpacing: 0.24,
                          ),textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(10),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFFCF8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(200),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x0C000000),
                            blurRadius: 11,
                            offset: Offset(0, 3),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Image.asset(
                        "assets/exchange.png",
                        color: const Color(0xFF2F7DC1),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        clipBehavior: Clip.antiAlias,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFFFCF8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x0C000000),
                              blurRadius: 11,
                              offset: Offset(0, 3),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Text(
                          "$toName\n$toNumber\n$toId",
                          style: const TextStyle(
                            color: Color(0xFF252525),
                            fontSize: 12,
                            fontFamily: 'PoppinsRegular',
                            fontWeight: FontWeight.w500,
                            height: 1.20,
                            letterSpacing: 0.24,
                          ),textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 26,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Reasons',
                    style: TextStyle(
                      color: Color(0xFF252525),
                      fontSize: 12,
                      fontFamily: 'PoppinsRegular',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.24,
                    ),
                  ),
                ),
                Container(
                  width: width,
                  padding: const EdgeInsets.all(15),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFFCF8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x0C000000),
                        blurRadius: 11,
                        offset: Offset(0, 3),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Opacity(
                    opacity: 0.80,
                    child: Text(
                      reason,
                      style: const TextStyle(
                        color: Color(0xFF252525),
                        fontSize: 12,
                        fontFamily: 'PoppinsRegular',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                Container(
                  height: height / 2.071960297766749,
                  width: width / 1.708695652173913,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                      color: const Color(0xFFFFFCF8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0C000000),
                          blurRadius: 11,
                          offset: Offset(0, 3),
                          spreadRadius: 0,
                        )
                      ],
                      image: DecorationImage(
                          image: NetworkImage(proofImage), fit: BoxFit.fill)),
                ),
                const SizedBox(
                  height: 20,
                ),
                from == "REQUEST"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            SizedBox(
                              width: width / 2.311764705882353,
                              height: 36,
                              child: TextButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                color: Color(0xFF2F7DC1))))),
                                onPressed: () {
                                  approveExchange(context, "REJECT");
                                },
                                child: const Text(
                                  'Reject',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF2F7DC1),
                                    fontSize: 12,
                                    fontFamily: 'PoppinsRegular',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              height: 36,
                              width: width / 2.311764705882353,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xFF2F7DC1)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                onPressed: () {
                                  approveExchange(context, "APPROVE");
                                },
                                child: const Text(
                                  'Approve',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'PoppinsRegular',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                          ])
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }

  approveExchange(BuildContext context, String from) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        scrollable: true,
        content: Container(
          // height: height*0.26,
          width: width,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFFEBEBEB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x1C000000),
                blurRadius: 11,
                offset: Offset(0, 9),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      from == "APPROVE"
                          ? 'Are you Sure to Approve'
                          : "Are you Sure to Reject",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF252525),
                        fontSize: 16,
                        fontFamily: 'PoppinsRegular',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                        width: 62,
                        height: 62,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFEBEBEB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(102),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x1C000000),
                              blurRadius: 11,
                              offset: Offset(0, 9),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Image.asset("assets/exchange.png",
                            color: const Color(0xFF2F7DC1)))
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Consumer<AdminProvider>(builder: (context, val10, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              finish(context);
                            },
                            child: Container(
                              width: 120,
                              height: 39,
                              alignment: Alignment.center,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFFFFCF8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(62),
                                ),
                              ),
                              child: const Text(
                                'Cancel',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF252525),
                                  fontSize: 16,
                                  fontFamily: 'PoppinsRegular',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (from == "APPROVE") {
                                // val10.exchangeUsers(fromId,toId,context);
                                val10.exchangeApproveANDRejectFun(
                                    "APPROVE", docId);
                              } else {
                                val10.exchangeApproveANDRejectFun(
                                    "REJECT", docId);
                              }
                              finish(context);
                            },
                            child: Container(
                              width: 120,
                              height: 39,
                              alignment: Alignment.center,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF2F7DC1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(62),
                                ),
                              ),
                              child: Text(
                                from == "APPROVE" ? "Approve" : "Reject",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFFFFFCF8),
                                  fontSize: 16,
                                  fontFamily: 'PoppinsRegular',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 20),
            ],
          ),
        ));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
