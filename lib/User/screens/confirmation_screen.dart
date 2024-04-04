import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:lio_care/User/screens/home_Screen.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:lio_care/constants/my_colors.dart';
import 'package:provider/provider.dart';

class ConfirmationScreen extends StatelessWidget {
  final String distributionId;
  final String name;
  final String phoneNumber;
  final String date;
  final String time;
  final String regId;
  final String image;
  final String screenShot;
  final File? receiptImage;
  final String from;
  final String paymentType;
  final String tree;
  final String grade;

  const ConfirmationScreen(
      {Key? key,
      required this.distributionId,
      required this.name,
      required this.phoneNumber,
      required this.date,
      required this.time,
      required this.regId,
      required this.image,
      required this.screenShot,
      required this.receiptImage,
        required this.from,
        required this.paymentType, required this.tree, required this.grade
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("grade $grade");
    print("from $from");
    print("payment type  $paymentType");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 68,
        backgroundColor: const Color(0xffFFFCF8),
        elevation: 0,
        centerTitle: true,
        title: const Text("Confirmation"),
        titleTextStyle: const TextStyle(
            color: cl2F7DC1,
            fontSize: 20,
            fontWeight: FontWeight.w700),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: cl2F7DC1,
          ),
          onPressed: () {
            finish(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 17),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              "assets/backgroundimage.png",
                            ),
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              // colors: [Color(0xff1a4aa6), Color(0xff5692ec)]
                              colors: [cl2F7DC1, cl2FC1BC]
                          )),
                      height: 125,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                image == ""
                                    ? const CircleAvatar(
                                        backgroundColor: myWhite,
                                        radius: 15,
                                        child: Icon(Icons.person_rounded),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(image),
                                        radius: 15,
                                      ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "+91$phoneNumber",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),

                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "ID :$regId",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          color: const Color(0xffEDEDED),
                          image:receiptImage!=null? DecorationImage(
                              fit: BoxFit.fill,
                              image: FileImage(receiptImage!)):DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(screenShot
                              ))

                      ),
                      height: 472,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<UserProvider>(
                  builder: (context7,val22,child) {
                    return InkWell(
                      onTap: (){
                        if(from=="UPLOAD"){

                        val22.screenShotUpload(distributionId,val22.registerID,paymentType,name,grade,context);
                        // val22.screenShotUpload(val22.registerID,val22.userGrade,"STAR_CLUB",paymentType,context);

                        }else{
                          val22.showBottomSheet2(context,distributionId, "CHANGE", name, phoneNumber, date, time, regId, image, screenShot,paymentType,tree,grade,);
                        }
                      },
                      child: Container(
                        width: from=="HOME"?200: 170,
                        height: 45,
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color:  cl2F7DC1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(51),
                          ),
                        ),
                        child:  Text(
                         from=="HOME"? "Change Screenshot":"Upload",
                          style: const TextStyle(
                              color: myWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  }
                )
                // SizedBox(
                //   width: MediaQuery.of(context).size.width / 1.2,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       button(context: context, bgColor: Colors.white, text: "Reject",textColor: const Color(0xff1746A2)),
                //       SizedBox(
                //         width: MediaQuery.of(context).size.width / 15,
                //       ),
                //
                //       button(context: context, bgColor: const Color(0xff1746A2), text: "Approve"),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget button(
    {required BuildContext context,
    required Color bgColor,
    required String text,
    Color textColor = Colors.white}) {
  return SizedBox(
    height: MediaQuery.of(context).size.width / 10,
    width: MediaQuery.of(context).size.width / 2.64,
    child: ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(bgColor),
          side: const MaterialStatePropertyAll(
              BorderSide(width: 1, color: Color(0xff1746A2))),
          shape: const MaterialStatePropertyAll(StadiumBorder())),
      onPressed: () {
        callNext(HomeScreen(userID: '',), context);
      },
      child: Text(
        text,
        style: TextStyle(
            color: textColor, fontSize: MediaQuery.of(context).size.width / 30),
      ),
    ),
  );
}
