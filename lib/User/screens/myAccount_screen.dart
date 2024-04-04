import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:lio_care/constants/my_colors.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../view/Widgets/my_widgets.dart';
import 'make_dynamic_Link_Screen.dart';

class MyAccountScreen extends StatelessWidget {
  MyAccountScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final fxdWidth = width * .6;
    return Scaffold(
      backgroundColor: myWhite,
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.1),
        child: Container(
          decoration: BoxDecoration(
              color: textColor,
              gradient: const LinearGradient(
                begin: Alignment(-0.00, -1.00),
                end: Alignment(0, 1),
                colors: [
                  Color(0xFF2F7DC1),
                  Color(0xFF2F7DC1),
                  Color(0xFFBFD5E8)
                ],
              ),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(38), topRight: Radius.circular(38))),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 9, bottom: 10),
                  child: Text(
                    "My Account",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: "PoppinsRegular",
                        fontSize: 20),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: textColor,
                          child: Consumer<UserProvider>(
                              builder: (context1, val, child) {
                            return val.userProfileImage != ""
                                ? CircleAvatar(
                                    radius: 55,
                                    backgroundImage: NetworkImage(
                                      val.userProfileImage,
                                    ),
                                  )
                                : const CircleAvatar(
                                    radius: 55,
                                    child: Icon(Icons.person_rounded),
                                  );
                          }),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Consumer<UserProvider>(
                            builder: (context2, val1, child) {
                          return Text(
                            val1.userName,
                            style: const TextStyle(
                                color: myWhite,
                                fontSize: 25,
                                fontFamily: "PoppinsRegular",
                                fontWeight: FontWeight.w600),
                          );
                        }),
                        Consumer<UserProvider>(
                            builder: (context3, val2, child) {
                          return Text(
                            val2.userPhone,
                            style: const TextStyle(
                                color: myWhite,
                                fontSize: 12,
                                fontFamily: "PoppinsRegular",
                                fontWeight: FontWeight.w400),
                          );
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 18.0),
                                      child: Text(
                                        "My Invitees",
                                        style: TextStyle(
                                            color: cl0xFFD5D5D5,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "PoppinsRegular"),
                                      ),
                                    ),
                                    Consumer<UserProvider>(
                                        builder: (context17, val21, child) {
                                      return Row(
                                        children: [
                                          Consumer<UserProvider>(builder:
                                              (context18, val78, child) {
                                            return InkWell(
                                              onTap: () async {
                                                if (val78.inviteCount == 0) {
                                                  String generatedDeepLink =
                                                      await FirebaseDynamicLinkService
                                                          .createDynamicLink(
                                                              true,
                                                              val78.userPhone);
                                                  Share.share(
                                                      '${"Lio club"}:\nDownload Lio club to read more and be updated $generatedDeepLink \nID: ${val78.userPhone}',
                                                      subject:
                                                          'Look what I made!');
                                                }
                                              },
                                              child: Container(
                                                width: width / 5,
                                                padding: const EdgeInsets.all(1),
                                                // height: 24,
                                                alignment: Alignment.center,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: ShapeDecoration(
                                                  color: val78.inviteCount ==
                                                              1 ||
                                                          val78.inviteCount ==
                                                              2 ||
                                                          val78.inviteCount > 2
                                                      ? const Color(0xFF16B200)
                                                      : const Color(0xFF1C4DAD),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    val78.inviteCount == 1 ||
                                                            val78.inviteCount ==
                                                                2 ||
                                                            val78.inviteCount >
                                                                2
                                                        ? const SizedBox()
                                                        : SizedBox(
                                                            width: width / 56),
                                                    const Text(
                                                      'Person 1',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: 0.20,
                                                      ),
                                                    ),
                                                    val78.inviteCount == 1 ||
                                                            val78.inviteCount ==
                                                                2 ||
                                                            val78.inviteCount >
                                                                2
                                                        ? const SizedBox()
                                                        : const Spacer(),
                                                    val78.inviteCount == 1 ||
                                                            val78.inviteCount ==
                                                                2 ||
                                                            val78.inviteCount >
                                                                2
                                                        ? const SizedBox()
                                                        : const Icon(
                                                            Icons
                                                                .add_circle_outlined,
                                                            size: 20,
                                                            color: Color(
                                                                0xFFFF731D),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Consumer<UserProvider>(builder:
                                              (context19, val79, child) {
                                            return InkWell(
                                              onTap: () async {
                                                if (val79.inviteCount == 1) {
                                                  String generatedDeepLink =
                                                      await FirebaseDynamicLinkService
                                                          .createDynamicLink(
                                                              true,
                                                              val79.userPhone);
                                                  Share.share(
                                                      '${"Lio club"}:\nDownload Lio club to read more and be updated $generatedDeepLink \nID: ${val79.userPhone}',
                                                      subject:
                                                          'Look what I made!');
                                                }
                                              },
                                              child: Container(
                                                width: width / 5,
                                                padding: const EdgeInsets.all(1),
                                                // height: 24,
                                                alignment: Alignment.center,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: ShapeDecoration(
                                                  color: val79.inviteCount >= 2
                                                      ? const Color(0xFF16B200)
                                                      : const Color(0xFF1C4DAD),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            70),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    val79.inviteCount >= 2
                                                        ?SizedBox(
                                                        width: width / 56)

                                                        : const SizedBox(),
                                                    const Text(
                                                      ' Person 2',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: 0.20,
                                                      ),
                                                    ),
                                                    val79.inviteCount >= 2
                                                        ? const SizedBox()
                                                        : const Spacer(),
                                                    val79.inviteCount >= 2
                                                        ? const SizedBox()
                                                        : const Icon(
                                                            Icons
                                                                .add_circle_outlined,
                                                            size: 20,
                                                            color: Color(
                                                                0xFFFF731D),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Consumer<UserProvider>(builder:
                                              (context20, val80, child) {
                                            return val80.inviteCount >= 2
                                                ? const SizedBox()
                                                : Text(
                                              "${val80.leftDays} Days Left",
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontFamily: 'Poppins',
                                                fontWeight:
                                                FontWeight.w400,
                                                letterSpacing: 0.20,
                                              ),
                                            );
                                          }),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 18.0),
                                      child: Text(
                                        "Registration ID",
                                        style: TextStyle(
                                            color: cl0xFFD5D5D5,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "PoppinsRegular"),
                                      ),
                                    ),
                                    Consumer<UserProvider>(
                                        builder: (context21, val7, child) {
                                      return SizedBox(
                                          width: fxdWidth,
                                          height: 43,
                                          child: textField(val7.registerID,
                                              Colors.transparent));
                                    })
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 18.0),
                                      child: Text(
                                        "Total Help Given",
                                        style: TextStyle(
                                            color: cl0xFFD5D5D5,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "PoppinsRegular"),
                                      ),
                                    ),
                                    Consumer<UserProvider>(
                                        builder: (context22, val5, child) {
                                      return SizedBox(
                                          width: fxdWidth,
                                          height: 43,
                                          child: textField(
                                              val5.userTotalDonation,
                                              Colors.transparent));
                                    })
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 18.0),
                                      child: Text(
                                        "Total PMC",
                                        style: TextStyle(
                                            color: cl0xFFD5D5D5,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "PoppinsRegular"),
                                      ),
                                    ),
                                    Consumer<UserProvider>(
                                        builder: (context23, val4, child) {
                                      return SizedBox(
                                        width: fxdWidth,
                                        height: 43,
                                        child: textField(val4.userTotalAmf,
                                            Colors.transparent),
                                      );
                                    })
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        left: 18.0,
                                      ),
                                      child: Text(
                                        "Total Help Received",
                                        style: TextStyle(
                                            color: cl0xFFD5D5D5,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "PoppinsRegular"),
                                      ),
                                    ),
                                    Consumer<UserProvider>(
                                        builder: (context24, val6, child) {
                                      return SizedBox(
                                        width: fxdWidth,
                                        height: 43,
                                        child: textField(val6.userTotalEarnings,
                                            Colors.transparent),
                                      );
                                    })
                                  ],
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        Consumer<UserProvider>(
                            builder: (context4, val30, child) {
                          return Row(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 18.0),
                                  child: Text(
                                    "KYC Verification",
                                    style: TextStyle(
                                        color: myWhite,
                                        fontSize: 20,
                                        fontFamily: "PoppinsRegular",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 6.4,
                              ),
                              val30.kycStatus == "VERIFIED"
                                  ? const KycStatusWdget(
                                      color: myWhite,
                                      icon: Center(
                                        child: Icon(
                                          Icons.check_circle,
                                          size: 16,
                                          color: Colors.green,
                                        ),
                                      ))
                                  : val30.kycStatus == "REJECTED"
                                      ? const KycStatusWdget(
                                          color: Colors.white,
                                          icon: Center(
                                            child: Icon(
                                              Icons.error,
                                              size: 16,
                                              color: Colors.red,
                                            ),
                                          ))
                                      : val30.kycStatus == "PENDING" ||
                                              val30.kycStatus == ""
                                          ? const KycStatusWdget(
                                              color: Colors.white,
                                              icon: Center(
                                                child: Icon(
                                                  Icons.error,
                                                  size: 16,
                                                  color: Colors.orange,
                                                ),
                                              ))
                                          : val30.kycStatus == "SUBMITTED"
                                              ? const KycStatusWdget(
                                                  color: Colors.white,
                                                  icon: Center(
                                                    child: Icon(
                                                      Icons.error,
                                                      size: 16,
                                                      color: Colors.yellow,
                                                    ),
                                                  ))
                                              : const SizedBox(),
                              const Spacer(),
                              val30.kycStatus == "VERIFIED" ||
                                      val30.kycStatus == "SUBMITTED"
                                  ? const SizedBox()
                                  : IconButton(
                                      onPressed: () {
                                        val30.editCheckFun();
                                        val30.getUserDetails(val30.registerID);
                                      },
                                      icon: const Icon(
                                        Icons.edit_note_rounded,
                                        color: myWhite,
                                      ))
                            ],
                          );
                        }),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 48,
                              width: width / 2.70,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(4.5)),
                                  color: textColor,
                                  border:
                                      Border.all(color: Colors.transparent)),
                              child: const Text(
                                "Date of Birth",
                                style: TextStyle(
                                    color: cl0xFFD5D5D5,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PoppinsRegular"),
                              ),
                            ),
                            Consumer<UserProvider>(
                                builder: (context5, val8, child) {
                              return SizedBox(
                                width: fxdWidth,

                                ///
                                child: TextFormField(
                                  onTap: () {
                                    if (val8.editCheck) {
                                      val8.selectDOB(context);
                                    }
                                  },
                                  controller: val8.dateOfBirthController,
                                  style: const TextStyle(
                                      color: myWhite,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "PoppinsRegular"),
                                  decoration: InputDecoration(
                                    // constraints: BoxConstraints(maxHeight: 45),
                                    enabled:
                                        val8.editCheck == true ? true : false,
                                    filled: true,
                                    fillColor: textColor,
                                    // contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                    disabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 0.5),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 0.5),
                                    ),
                                    errorBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 0.5),
                                    ),
                                    focusedErrorBorder:
                                        const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 0.5),
                                    ),
                                    suffixIcon: const Padding(
                                      padding: EdgeInsets.only(right: 38.0),
                                      child: Icon(
                                        Icons.calendar_today_outlined,
                                        color: myWhite,
                                        size: 18,
                                      ),
                                    ),
                                    hintText: val8.userDob == ""
                                        ? "Date Of Birth"
                                        : val8.userDob,
                                    hintStyle: const TextStyle(
                                        color: myWhite,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "PoppinsRegular"),
                                  ),
                                  validator: (txt) {
                                    if (txt!.trim().isEmpty) {
                                      return 'Select Your Date Of Birth';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              );
                            })
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 48,
                              width: width / 2.70,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(4.5)),
                                  color: textColor,
                                  border:
                                      Border.all(color: Colors.transparent)),
                              child: const Text(
                                "Gender",
                                style: TextStyle(
                                    color: cl0xFFD5D5D5,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PoppinsRegular"),
                              ),
                            ),
                            Consumer<UserProvider>(
                                builder: (context6, val10, child) {
                              return val10.editCheck
                                  ? Container(
                                      width: fxdWidth,
                                      // height: 48,

                                      decoration: BoxDecoration(
                                        color: textColor,
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(4.5)),

                                        // border: const Border(bottom: BorderSide(color: myWhite, width: 1))
                                      ),
                                      child: DropdownSearch<String>(
                                        popupProps: const PopupProps.menu(
                                            // showSelectedItems: true,
                                            fit: FlexFit.loose),
                                        items: const [
                                          "Select Gender",
                                          "Male",
                                          "Female"
                                        ],
                                        dropdownDecoratorProps:
                                            const DropDownDecoratorProps(
                                                baseStyle:
                                                    TextStyle(color: myWhite),
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  border: InputBorder.none,
                                                  suffixIconColor: myWhite,
                                                  contentPadding:
                                                      EdgeInsets.all(15),
                                                )),
                                        onChanged: (e) {
                                          val10.dropDown(e);
                                        },
                                        selectedItem: "Select Gender",
                                        validator: (txt) {
                                          if (txt!.trim().isEmpty ||
                                              txt == "Select Gender") {
                                            return 'Please Select Your Gender';
                                          } else {
                                            return null;
                                          }
                                        },
                                      )

                                      // DropdownButton(
                                      //   alignment: Alignment.center,dropdownColor: backgrnd,
                                      //   // dropdownColor:textColor.withOpacity(0.71),
                                      //   underline: const SizedBox(),
                                      //   value: val10.dropdownValue,
                                      //   icon: Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       SizedBox(
                                      //         width: width * .25,
                                      //       ),
                                      //       const Icon(
                                      //         Icons.keyboard_arrow_down_outlined,
                                      //         size: 35,
                                      //         color: myWhite,
                                      //       ),
                                      //     ],
                                      //   ),
                                      //   iconSize: 24,
                                      //   elevation: 0,
                                      //   style: const TextStyle(
                                      //     fontWeight: FontWeight.w400,
                                      //     color: Colors.red,
                                      //     fontSize: 12,
                                      //     fontFamily: "PoppinsRegular",
                                      //   ),
                                      //   onChanged: (changeValue) {
                                      //     val10.dropDown(changeValue);
                                      //   },
                                      //   items: val10.gender.map((value2) {
                                      //     return DropdownMenuItem(
                                      //       value: value2,
                                      //       child: Padding(
                                      //         padding: const EdgeInsets.all(8.0),
                                      //         child: Text(value2,
                                      //             style: const TextStyle(
                                      //                 color: myWhite)),
                                      //       ),
                                      //     );
                                      //   }).toList(),
                                      // )
                                      )
                                  : SizedBox(
                                      width: fxdWidth,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          enabled: false,
                                          fillColor: textColor,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 0),
                                          disabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 0.5),
                                          ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          hintText: val10.dropdownValue == ""
                                              ? "   Select Gender"
                                              : "   ${val10.dropdownValue}",
                                          hintStyle: const TextStyle(
                                              color: myWhite,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "PoppinsRegular"),
                                        ),
                                      ),
                                    );
                            }),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 48,
                              width: width / 2.70,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(4.5)),
                                  color: textColor,
                                  border:
                                      Border.all(color: Colors.transparent)),
                              child: const Text(
                                "Address",
                                style: TextStyle(
                                    color: cl0xFFD5D5D5,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PoppinsRegular"),
                              ),
                            ),
                            Consumer<UserProvider>(
                                builder: (context7, val11, child) {
                              return SizedBox(
                                width: fxdWidth,
                                child: TextFormField(
                                  enabled:
                                      val11.editCheck == true ? true : false,
                                  keyboardType: TextInputType.multiline,
                                  controller: val11.adressController,
                                  minLines: 2,
                                  maxLines: null,
                                  style: const TextStyle(
                                      color: myWhite,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "PoppinsRegular"),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: textColor,
                                    disabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 0.5),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 0.5),
                                    ),
                                    errorBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 0.5),
                                    ),
                                    focusedErrorBorder:
                                        const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 0.5),
                                    ),
                                    hintText: "Address",
                                    hintStyle: const TextStyle(
                                        color: myWhite,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "PoppinsRegular"),
                                  ),
                                  validator: (txt) {
                                    if (txt!.trim().isEmpty) {
                                      return 'Enter Your Address';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              );
                            })
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 48,
                              width: width / 2.70,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(4.5)),
                                  color: textColor,
                                  border:
                                      Border.all(color: Colors.transparent)),
                              child: const Text(
                                "Pin Code",
                                style: TextStyle(
                                    color: cl0xFFD5D5D5,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PoppinsRegular"),
                              ),
                            ),
                            Consumer<UserProvider>(
                                builder: (context8, val19, child) {
                              return SizedBox(
                                width: fxdWidth,
                                child: TextField2(
                                    TextInputType.number,
                                    "Pin Code",
                                    "PIN",
                                    val19.pinCodeController,
                                    6),
                              );
                            })
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 48,
                              width: width / 2.70,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(4.5)),
                                  color: textColor,
                                  border:
                                      Border.all(color: Colors.transparent)),
                              child: const Text(
                                "PAN Number",
                                style: TextStyle(
                                    color: cl0xFFD5D5D5,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PoppinsRegular"),
                              ),
                            ),
                            Consumer<UserProvider>(
                                builder: (context9, val19, child) {
                              return SizedBox(
                                width: fxdWidth,
                                child: TextField2(
                                    TextInputType.text,
                                    "PAN Number",
                                    "PAN",
                                    val19.panNumberController,
                                    10),
                              );
                            })
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 48,
                              width: width / 2.70,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(4.5)),
                                  color: textColor,
                                  border:
                                      Border.all(color: Colors.transparent)),
                              child: const Text(
                                "PAN Card",
                                style: TextStyle(
                                    color: cl0xFFD5D5D5,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PoppinsRegular"),
                              ),
                            ),
                            Consumer<UserProvider>(
                                builder: (context10, val28, child) {
                              return InkWell(
                                onTap: () {
                                  if (val28.editCheck) {
                                    val28.showBottomSheet(context, "PAN");
                                  }
                                },
                                child: Container(
                                    width: fxdWidth,
                                    height: height / 6,
                                    decoration: BoxDecoration(
                                        color: textColor,
                                        border: const Border(
                                            bottom: BorderSide(
                                                color: myWhite, width: 0.5))),
                                    child: val28.filePanImage != null
                                        ? Image.file(val28.filePanImage!,
                                            fit: BoxFit.fill)
                                        : val28.userPanImage != ""
                                            ? Image.network(val28.userPanImage,
                                                fit: BoxFit.fill)
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      "assets/upload.png"),
                                                  const Text(
                                                    "Upload your PAN Card photo",
                                                    style: TextStyle(
                                                        color: cl0xFFD5D5D5,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            "PoppinsRegular"),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    width: 144,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(29),
                                                        color: cl2F58AB),
                                                    child: const Center(
                                                        child: Text(
                                                      "Browse",
                                                      style: TextStyle(
                                                          color: myWhite,
                                                          fontFamily:
                                                              "PoppinsRegular",
                                                          fontSize: 12),
                                                    )),
                                                  )
                                                ],
                                              )),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<UserProvider>(
                                builder: (context25, val78, child) {
                              return val78.editCheck
                                  ? Container(
                                      width: width / 2.70,
                                      // height: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(4.5)),
                                        color: textColor,
                                      ),
                                      child: Column(
                                        children: [
                                          DropdownSearch<String>(
                                            popupProps: const PopupProps.menu(
                                                // showSelectedItems: true,
                                                fit: FlexFit.loose),
                                            items: const [
                                              "Select id type",
                                              "Aadhaar",
                                              "Passport",
                                              "Driving Licence"
                                            ],
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                                    baseStyle:
                                                        TextStyle(color: myWhite),
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      border: InputBorder.none,
                                                      suffixIconColor: myWhite,
                                                      contentPadding:
                                                          EdgeInsets.all(15),
                                                    )),
                                            onChanged: (e) {
                                              val78.dropDownId(e);
                                            },
                                            selectedItem: "Select id type",
                                            validator: (txt) {
                                              if (txt!.trim().isEmpty ||
                                                  txt == "Select id type") {
                                                return 'Please Select ID Type';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      height: 48,
                                      width: width / 2.70,
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(left: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(4.5)),
                                          color: textColor,
                                          border: Border.all(
                                              color: Colors.transparent)),
                                      child: Text(
                                        val78.kycDropdownID == ""
                                            ? "ID"
                                            : val78.kycDropdownID,
                                        style: const TextStyle(
                                            color: cl0xFFD5D5D5,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "PoppinsRegular"),
                                      ),
                                    );
                            }),
                            Consumer<UserProvider>(
                                builder: (context11, val27, child) {
                              return InkWell(
                                onTap: () {
                                  if (val27.editCheck) {
                                    val27.showBottomSheet(context, "AADHAAR");
                                  }
                                },
                                child: Container(
                                    width: fxdWidth,
                                    height: height / 6,
                                    decoration: BoxDecoration(
                                        // image:val27.fileAdhaarImage==null? DecorationImage(image: FileImage(val27.fileAdhaarImage!)):,
                                        color: textColor,
                                        border: const Border(
                                            bottom: BorderSide(
                                                color: myWhite, width: 0.5))),
                                    child: val27.fileAdhaarImage != null
                                        ? Image.file(val27.fileAdhaarImage!,
                                            fit: BoxFit.fill)
                                        : val27.userAadhaarImage != ""
                                            ? Image.network(
                                                val27.userAadhaarImage,
                                                fit: BoxFit.fill)
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      "assets/upload.png"),
                                                  const Text(
                                                    "Upload your ID Card photo(Side One)",
                                                    style: TextStyle(
                                                        color: cl0xFFD5D5D5,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            "PoppinsRegular"),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    width: 144,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(29),
                                                        color: cl2F58AB),
                                                    child: const Center(
                                                        child: Text(
                                                      "Browse",
                                                      style: TextStyle(
                                                          color: myWhite,
                                                          fontFamily:
                                                              "PoppinsRegular",
                                                          fontSize: 12),
                                                    )),
                                                  )
                                                ],
                                              )),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 48,
                              width: width / 2.70,
                              alignment: Alignment.centerLeft,
                              // padding: const EdgeInsets.only(left: 15),
                              // decoration: BoxDecoration(
                              //     borderRadius: const BorderRadius.only(
                              //         topRight: Radius.circular(4.5)),
                              //     color: textColor,
                              //     border:
                              //     Border.all(color: Colors.transparent)),
                              // child: const Text(
                              //   "Side One",
                              //   style: TextStyle(
                              //       color: cl0xFFD5D5D5,
                              //       fontSize: 12,
                              //       fontWeight: FontWeight.w400,
                              //       fontFamily: "PoppinsRegular"),
                              // ),
                            ),
                            Consumer<UserProvider>(
                                builder: (context10, val28, child) {
                                  return InkWell(
                                    onTap: () {
                                      if (val28.editCheck) {
                                        val28.showBottomSheet(context, "SECON_SIDE");
                                      }
                                    },
                                    child: Container(
                                        width: fxdWidth,
                                        height: height / 6,
                                        decoration: BoxDecoration(
                                            color: textColor,
                                            border: const Border(
                                                bottom: BorderSide(
                                                    color: myWhite, width: 0.5))),
                                        child: val28.fileAdhaarSeconodSideImage != null
                                            ? Image.file(val28.fileAdhaarSeconodSideImage!,
                                            fit: BoxFit.fill)
                                            : val28.userAadhaarSecondSideImage != ""
                                            ? Image.network(val28.userAadhaarSecondSideImage,
                                            fit: BoxFit.fill)
                                            : Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                "assets/upload.png"),
                                            const Text(
                                              "Upload your ID Card photo(Side Two)",
                                              style: TextStyle(
                                                  color: cl0xFFD5D5D5,
                                                  fontSize: 10,
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  fontFamily:
                                                  "PoppinsRegular"),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Container(
                                              height: 30,
                                              width: 144,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(29),
                                                  color: cl2F58AB),
                                              child: const Center(
                                                  child: Text(
                                                    "Browse",
                                                    style: TextStyle(
                                                        color: myWhite,
                                                        fontFamily:
                                                        "PoppinsRegular",
                                                        fontSize: 12),
                                                  )),
                                            )
                                          ],
                                        )),
                                  );
                                }),
                          ],
                        ),


                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Consumer<UserProvider>(
                                builder: (context26, val111, child) {
                              return Container(
                                height: 48,
                                width: width / 2.70,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(4.5)),
                                    color: textColor,
                                    border:
                                        Border.all(color: Colors.transparent)),
                                child: Text(
                                  val111.kycDropdownID != "Select id type"
                                      ? "${val111.kycDropdownID} Number"
                                      : "ID Number",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: cl0xFFD5D5D5,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "PoppinsRegular"),
                                ),
                              );
                            }),
                            Consumer<UserProvider>(
                                builder: (context13, val20, child) {
                              return SizedBox(
                                  width: fxdWidth,
                                  child: TextFieldID(
                                    val20.kycDropdownID,
                                    val20.aadhaarNumberController,
                                  ));
                            })
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 48,
                              width: width / 2.70,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(4.5)),
                                  color: textColor,
                                  border:
                                      Border.all(color: Colors.transparent)),
                              child: const Text(
                                "Account Number",
                                style: TextStyle(
                                    color: cl0xFFD5D5D5,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PoppinsRegular"),
                              ),
                            ),
                            Consumer<UserProvider>(
                                builder: (context15, val17, child) {
                              return SizedBox(
                                  width: fxdWidth,
                                  child: TextField5(
                                    TextInputType.number,
                                    "Account No",
                                    "Account No",
                                    val17.accountNumberController,
                                  ));
                            })
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 48,
                              width: width / 2.70,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(4.5)),
                                  color: textColor,
                                  border:
                                      Border.all(color: Colors.transparent)),
                              child: const Text(
                                "IFSC Code",
                                style: TextStyle(
                                    color: cl0xFFD5D5D5,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PoppinsRegular"),
                              ),
                            ),
                            Consumer<UserProvider>(
                                builder: (context16, val16, child) {
                              return SizedBox(
                                  width: fxdWidth,
                                  child: TextField5(
                                    TextInputType.text,
                                    "IFSC Code",
                                    "IFSC",
                                    val16.ifscCodeController,
                                  ));
                            })
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 48,
                              width: width / 2.70,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(4.5)),
                                  color: textColor,
                                  border:
                                      Border.all(color: Colors.transparent)),
                              child: const Text(
                                "UPI ID",
                                style: TextStyle(
                                    color: cl0xFFD5D5D5,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PoppinsRegular"),
                              ),
                            ),
                            Consumer<UserProvider>(
                                builder: (context16, val15, child) {
                              return SizedBox(
                                width: fxdWidth,
                                child: TextField5(
                                  TextInputType.text,
                                  "UPI ID",
                                  "Upi",
                                  val15.upiIDController,
                                ),
                              );
                            })
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 48,
                              width: width / 2.70,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(4.5)),
                                  color: textColor,
                                  border:
                                      Border.all(color: Colors.transparent)),
                              child: const Text(
                                "Nominee Name",
                                style: TextStyle(
                                    color: cl0xFFD5D5D5,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PoppinsRegular"),
                              ),
                            ),
                            Consumer<UserProvider>(
                                builder: (context16, val16, child) {
                              return SizedBox(
                                  width: fxdWidth,
                                  child: TextField5(
                                    TextInputType.text,
                                    "Nominee Name",
                                    "Nominee",
                                    val16.nomineeController,
                                  ));
                            })
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 48,
                              width: width / 2.70,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(4.5)),
                                  color: textColor,
                                  border:
                                      Border.all(color: Colors.transparent)),
                              child: const Text(
                                "Nominee Phone No",
                                style: TextStyle(
                                    color: cl0xFFD5D5D5,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PoppinsRegular"),
                              ),
                            ),
                            Consumer<UserProvider>(
                                builder: (context16, val16, child) {
                              return SizedBox(
                                  width: fxdWidth,
                                  child: TextField2(
                                      TextInputType.number,
                                      "Nominee Phone No",
                                      "NomineePhoneNo",
                                      val16.nomineePhoneNumberController,
                                      10));
                            })
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 48,
                              width: width / 2.70,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(4.5)),
                                  color: textColor,
                                  border:
                                      Border.all(color: Colors.transparent)),
                              child: const Text(
                                "Nominee Year Of Birth",
                                style: TextStyle(
                                    color: cl0xFFD5D5D5,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PoppinsRegular"),
                              ),
                            ),
                            Consumer<UserProvider>(
                                builder: (context16, val16, child) {
                              return SizedBox(
                                  width: fxdWidth,
                                  child: TextField2(
                                      TextInputType.number,
                                      "Nominee Year Of Birth",
                                      "Nominee Year Of Birth",
                                      val16.nomineeAgeController,
                                      4));
                            })
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 48,
                              width: width / 2.70,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(4.5)),
                                  color: textColor,
                                  border:
                                      Border.all(color: Colors.transparent)),
                              child: const Text(
                                "Relation",
                                style: TextStyle(
                                    color: cl0xFFD5D5D5,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PoppinsRegular"),
                              ),
                            ),
                            Consumer<UserProvider>(
                                builder: (context6, val10, child) {
                              return val10.editCheck
                                  ? Container(
                                      width: fxdWidth,
                                      // height: 48,
                                      decoration: BoxDecoration(
                                        color: textColor,
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(4.5)),

                                        // border: const Border(bottom: BorderSide(color: myWhite, width: 1))
                                      ),
                                      child: DropdownSearch<String>(
                                        popupProps: const PopupProps.menu(
                                            // showSelectedItems: true,
                                            fit: FlexFit.loose),
                                        items: const [
                                          "Select Relation",
                                          "Spouse",
                                          "Child",
                                          "Parent",
                                          "Sibling",
                                          "Friend"
                                        ],
                                        dropdownDecoratorProps:
                                            const DropDownDecoratorProps(
                                                baseStyle:
                                                    TextStyle(color: myWhite),
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  border: InputBorder.none,
                                                  suffixIconColor: myWhite,
                                                  contentPadding:
                                                      EdgeInsets.all(15),
                                                )),
                                        onChanged: (e) {
                                          val10.nomineeRelationDropDown(e);
                                        },
                                        selectedItem: "Select Relation",
                                        validator: (txt) {
                                          if (txt!.trim().isEmpty ||
                                              txt.trim() == "Select Relation") {
                                            return 'Please Select Nominee Relation';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ))
                                  : SizedBox(
                                      width: fxdWidth,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          enabled: false,
                                          fillColor: textColor,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 0),
                                          disabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 0.5),
                                          ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          hintText: val10
                                                      .nomineeDropDownValue ==
                                                  ""
                                              ? "   Select Nominee Relation"
                                              : "   ${val10.nomineeDropDownValue}",
                                          hintStyle: const TextStyle(
                                              color: myWhite,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "PoppinsRegular"),
                                        ),
                                      ),
                                    );
                            }),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Consumer<UserProvider>(builder: (context3, va, child) {
                          return va.editCheck == true
                              ? InkWell(
                                  onTap: () {
                                    final FormState? form =
                                        _formKey.currentState;
                                    if (form!.validate()) {
                                      if (va.filePanImage == null &&
                                          va.userPanImage == "") {
                                        const snackBar = SnackBar(
                                          content: Text(
                                              'Please upload Pan Card image.'),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        if (va.fileAdhaarImage == null &&
                                            va.userAadhaarImage == "") {
                                          var snackBar = SnackBar(
                                            content: Text(
                                                'Please upload ${va.kycDropdownID} image.'),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else {
                                          va.editUserAccount(
                                              context, va.registerID);
                                          va.editCheck = false;
                                        }
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 48,
                                    width: width / 1.7,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(27),
                                        color: clFA721F),
                                    child: const Center(
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "PoppinsRegular",
                                            color: myWhite),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox();
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KycStatusWdget extends StatelessWidget {
  final Widget icon;
  final Color color;

  const KycStatusWdget({
    super.key,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      alignment: Alignment.center,
      // clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: icon,
    );
  }
}
