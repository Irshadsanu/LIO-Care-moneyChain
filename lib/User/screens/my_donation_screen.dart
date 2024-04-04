import 'package:flutter/material.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../Constants/functions.dart';
import '../../constants/my_colors.dart';

class MyDonationScreen extends StatelessWidget {
  const MyDonationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List color = [clrcntnr1, myWhite];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [textColor, clCADEFC, clFFFCF8])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leadingWidth: 100,
          backgroundColor: cl2E7DC0,
          elevation: 0,
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          )),
          leading: InkWell(
              onTap: (){
                finish(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios,color: Colors.white,),
                    Image.asset("assets/whitelogo.png",scale: 12,),
                  ],
                ),
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  height: 120,
                  width: width / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffFFFCF8),
                    image: const DecorationImage(
                        image: AssetImage("assets/invitationsBg.png"),
                        fit: BoxFit.fill),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(),
                      const Text(
                        "My Total CMF",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: cBlack,
                          fontSize: 14,
                          fontFamily: 'PoppinsMedium',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Consumer<UserProvider>(builder: (context, val77, child) {
                        return RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "₹ ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                  color: clFF731D)),
                          TextSpan(
                              text: val77.totalDon.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                  fontFamily: "PoppinsMedium",
                                  color: clFF731D)),
                        ]));
                      }),
                      const SizedBox(),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: width / 1.1,
                height: height -230,
                padding: const EdgeInsets.only(top: 28, left: 10, right: 10),
                decoration: const BoxDecoration(
                    color: clFFFCF8,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(22),
                        topLeft: Radius.circular(22))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "My CMF",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              fontFamily: "PoppinsRegular"),
                        ),
                        Consumer<UserProvider>(
                            builder: (context, val44, child) {
                          return InkWell(
                            onTap: () {
                              val44.payPmcFromMyPmc(
                                  val44.registerID, "CMF", context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 21,
                              width: width / 5.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clFF731D,
                              ),
                              child: const Text(
                                "Pay CMF",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: Colors.white),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Consumer<UserProvider>(
                          builder: (context, provider, child) {
                        return provider.donationDetailsList.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                itemCount: provider.donationDetailsList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var item =
                                      provider.donationDetailsList[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Container(
                                      height: 100,
                                      width: width,
                                      color: color[index % 2],
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: InkWell(
                                              onTap: () {},
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 26,
                                                child: Image.asset(
                                                  "assets/bluelogo.png",
                                                  scale: 6,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: SizedBox(
                                              height: 60,
                                              width: 100,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    item.levelName,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 10,
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    "₹${item.amount}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 21,
                                                        color: textColor),
                                                  ),
                                                  Text(
                                                    item.tree,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 10,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // Text(
                                                  //   item.status,
                                                  //   style: TextStyle(
                                                  //       color: Textcolor2,
                                                  //       fontSize: 10,
                                                  //       fontWeight:
                                                  //           FontWeight.w400),
                                                  // ),
                                                  // const SizedBox(
                                                  //   height: 20,
                                                  // ),
                                                  Text(
                                                    "CMF ${item.installment}",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    item.date,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),Text(
                                                    item.time,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text("No CMF Transactions Yet.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                  )
                                ],
                              );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
