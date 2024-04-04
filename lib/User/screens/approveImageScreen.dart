
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:lio_care/constants/my_colors.dart';
import 'package:provider/provider.dart';

import 'bottomNavigation.dart';

class ApproveImageScreen extends StatelessWidget {
final String name;
final String number;
final String id;
final String date;
final String time;
final String image;
final String screenShort;
final String distributionId;
final String grade;
final String amount;
final String paymentType;
final String tree;
final String userDocId;
  const ApproveImageScreen (
      {Key? key, required this.name, required this.number, required this.id,
        required this.date, required this.time, required this.image,
        required this.screenShort, required this.distributionId, required this.grade,
        required this.amount, required this.paymentType, required this.tree, required this.userDocId,

       })
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 68,
        backgroundColor: const Color(0xffFFFCF8),
        elevation: 0,
        centerTitle: true,
        title: const Text("Confirmation"),
        titleTextStyle: const TextStyle(
            color: Color(0xff1746A2),
            fontSize: 20,
            fontWeight: FontWeight.w700),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xff1746A2),
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
                              colors: [Color(0xff1a4aa6), Color(0xff5692ec)])),
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
                                      "+91$number",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                     Text(date,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Color(0xffD3D3D3))),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "ID :$id",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                     Text(time,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Color(0xffD3D3D3))),
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
                          image:DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(screenShort
                              ))

                      ),
                      height: 472,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      button(
                          context: context, bgColor: Colors.white, text: "Reject",textColor: const Color(0xff1746A2),
                        amount: amount,distributionId: distributionId,grade: grade,memberId: id,
                          paymentType: paymentType,tree: tree,userDocId: "",
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 15,
                      ),

                      button(context: context, bgColor: const Color(0xff1746A2), text: "Approve", amount: amount,distributionId: distributionId,
                          grade: grade,memberId: id, paymentType: paymentType,tree: tree,userDocId: userDocId)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget button(
    {
      required BuildContext context,
      required Color bgColor,
      required String text,required String distributionId, required String memberId,required String grade,
      required String amount,required String paymentType,required String tree,required String userDocId,
      Color textColor = Colors.white
    }) {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  return SizedBox(
    height: MediaQuery.of(context).size.width / 10,
    width: MediaQuery.of(context).size.width / 2.64,
    child: Consumer<UserProvider>(
      builder: (context5,value5,child) {
        return ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(bgColor),
              side: const MaterialStatePropertyAll(
                  BorderSide(width: 1, color: Color(0xff1746A2))),
              shape: const MaterialStatePropertyAll(StadiumBorder())),
          onPressed: () async {
            var toValue = await db
                .collection("DISTRIBUTIONS")
                .doc(distributionId)
                .get();
            Map<dynamic, dynamic> toMap =
            toValue.data() as Map;
            String userIncomeStatus =
            toMap["STATUS"].toString();
            if (userIncomeStatus == "PROCESSING") {
              if(text=="Approve"){
                approveShowAlertDialog(context,distributionId, memberId, grade, amount, paymentType, tree, userDocId);
              }else{
                rejectShowAlertDialog(context, distributionId, memberId, grade, paymentType);
              }
            }

          },
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontSize: MediaQuery.of(context).size.width / 30),
          ),
        );
      }
    ),
  );
}

  void rejectShowAlertDialog(BuildContext context,String distributionId,String userId,String fromLevel,String paymentType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                contentPadding: EdgeInsets.zero,
                content: Container(
                  height: 222,
                  width: 335,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.bottomLeft,
                        colors: [Color(0xff005BBB), Color(0xff001969)]),
                  ),
                  child: Consumer<UserProvider>(
                    builder: (context5,value2,child) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            '       Are you sure\nyou want to Reject ?',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 39,
                                width: 120,
                                child: ElevatedButton(
                                    style: ButtonStyle(elevation: MaterialStateProperty.all(0),
                                        textStyle: MaterialStateProperty.all(const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900)),
                                        backgroundColor:
                                        MaterialStateProperty.all( grdintclr1),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(60)))),
                                    onPressed: () {finish(context);},
                                    child: const Text('Cancel',
                                        style: TextStyle(
                                             color: Color(0xffFFFCF8),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900))),
                              ),
                              SizedBox(
                                height: 39,
                                width: 120,
                                child: ElevatedButton(
                                    style: ButtonStyle(elevation: MaterialStateProperty.all(0),
                                        textStyle: MaterialStateProperty.all(const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900)),
                                        backgroundColor:
                                        MaterialStateProperty.all(                                              const Color(0xffFFFCF8),),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(60)))),
                                    onPressed: () {
                                      value2.rejectPayments(distributionId, userId, fromLevel, paymentType);
                                      finish(context);
                                      finish(context);
                                    },
                                    child: const Text('Reject',
                                        style: TextStyle(
                                           color:  Color(0xff1746A2),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900))),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                  ),
                ));
}
    );
}
  void approveShowAlertDialog(BuildContext context,String distributionId, String memberId,String grade,
      String amount,String paymentType,String tree,String userDocId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.zero,
              content: Container(
                height: 222,
                width: 335,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xff005BBB), Color(0xff001969)]),
                ),
                child: Consumer<UserProvider>(
                  builder: (context2,valuw3,child) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          '       Are you sure\nyou want to Approve ?',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 39,
                              width: 120,
                              child: ElevatedButton(
                                  style: ButtonStyle(elevation: MaterialStateProperty.all(0),
                                      textStyle: MaterialStateProperty.all(const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900)),
                                      backgroundColor:
                                      MaterialStateProperty.all(const Color(0xff1746A2)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(60)))),
                                  onPressed: () {finish(context);},
                                  child: const Text('Cancel',
                                      style: TextStyle(
                                          color: Color(0xffFFFCF8),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900))),
                            ),
                            SizedBox(
                              height: 39,
                              width: 120,
                              child: ElevatedButton(
                                  style: ButtonStyle(elevation: MaterialStateProperty.all(0),
                                      textStyle: MaterialStateProperty.all(const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900)),
                                      backgroundColor:
                                      MaterialStateProperty.all(const Color(0xffFFFCF8),),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(60)))),
                                  onPressed: () async {
                                    print("selected count out");
                                    if(!valuw3.approveWaitingBool){
                                      valuw3.approveWaitingBool=true;
                                      valuw3.notifyListeners();
                                      print("selected count");
                                      if(tree=="MASTER_CLUB") {
                                        await valuw3.approveBasicUpgradePayments(distributionId, memberId, grade, amount, paymentType, tree, userDocId);
                                        finish(context);
                                        callNextReplacement(BottomNavigationScreen(Userid:valuw3.registerID), context);
                                      }else if(tree=="STAR_CLUB"){
                                        await valuw3.approveAutoUpgradePayments(distributionId, memberId, grade, amount, paymentType, tree,"ONE", userDocId);
                                        finish(context);
                                        callNextReplacement(BottomNavigationScreen(Userid:valuw3.registerID), context);
                                      }else if(tree=="CROWN_CLUB"){
                                        await valuw3.approveAutoUpgradePayments(distributionId, memberId, grade, amount, paymentType, tree,"TWO", userDocId);
                                        finish(context);
                                        callNextReplacement(BottomNavigationScreen(Userid:valuw3.registerID), context);
                                      }}
                                  },
                                  child: const Text('Approve',
                                      style: TextStyle(
                                          color:  Color(0xff1746A2),

                                          fontSize: 16,
                                          fontWeight: FontWeight.w900))),
                            ),
                          ],
                        )
                      ],
                    );
                  }
                ),
              ));
        }
    );
  }