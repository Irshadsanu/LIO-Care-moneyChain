import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lio_care/User/screens/message_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants/functions.dart';
import '../../Provider/admin_provider.dart';
import '../../Provider/user_provider.dart';
import '../../constants/my_colors.dart';
import '../../models/getMessageModel.dart';

class MessageSendRecieve extends StatelessWidget {
  String memberID;
  String registerDocID;
  String userName;
  MessageSendRecieve(
      {Key? key,
      required this.memberID,
      required this.registerDocID,
      required this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    String formattedDate = '';

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: InkWell(
          onTap: () {
            userProvider.getChildForMessage(memberID, registerDocID, userName, context);
          },
          child: Container(
            width: 164,
            height: 35,
            padding:
                const EdgeInsets.only(top: 9, left: 28, right: 29, bottom: 8),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFF2F7DC1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(61.71),
              ),
            ),
            child: const Text('Send Message',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                )),
          ),
        ),
        backgroundColor: const Color(0xFFFFFCF8),
        appBar: AppBar(

          backgroundColor: myWhite,
          elevation: 0,
          leadingWidth: 100,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: () {
                finish(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: textColor,
                    ),
                    Image.asset(
                      "assets/bluelogo.png",
                      scale: 18,
                    ),
                  ],
                ),
              )),
          title: const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              'Messages',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF2F7DC1),
                fontSize: 20,
                fontFamily: 'PoppinsRegular',
                fontWeight: FontWeight.w700,
              ),
            ),
            // child: Text("Lio Care",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Textcolor,fontFamily: "PoppinsRegular"),),
          ),
        ),
        body: SingleChildScrollView(
          child: Consumer<UserProvider>(
            builder: (context,value11,child) {
              return Column(
                children: [
                  Container(
                    width: width / 1.02,
                    height: 70,
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    decoration: const BoxDecoration(
                        color: clFFFCF8,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(22),
                            topLeft: Radius.circular(22))),
                    child: SizedBox(
                      child: TabBar(
                        onTap: (value) {
                          if (value == 0) {
                            // userProvider.getMessages(memberID);
                          } else {
                            // userProvider.getSendedMessage(memberID);
                          }
                        },
                        unselectedLabelColor: cl2F7DC1,
                        indicatorColor: bxkclr,
                        labelColor: Colors.white,
                        indicatorPadding:
                            const EdgeInsets.only(bottom: 12, top: 12),
                        indicator: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(10), // Creates border
                            color: cl2F7DC1),
                        dividerColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: [
                          Tab(
                            child: Container(
                              width: width / 1,
                              // height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: cl2F7DC1,
                                    width: 1,
                                  )),
                              child: const Text("Received",
                                  textAlign: TextAlign.center),
                            ),
                          ),
                          Tab(
                            child: Container(
                              width: width / 1,
                              // height: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: cl2F7DC1, width: 1)),
                              child:
                                  const Text("Sent", textAlign: TextAlign.center),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    height: 670,
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    decoration: const BoxDecoration(
                      color: clFFFCF8,
                    ),
                    child: TabBarView(
                      children: [
                        Consumer<UserProvider>(builder: (context3, value3, child) {

                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemCount: value3.messageDateList.length,
                            itemBuilder: (BuildContext context, int index) {
                              List<GetMessageModel> filteredMessages = value3.getMessageList.where((element) =>
                              value3.messageDateList[index].dateFormat == element.dayDate).toList();
                              DateTime now = DateTime.now();
                              DateTime date = value3.messageDateList[index].date;
                              if (date.year == now.year &&
                                  date.month == now.month &&
                                  date.day == now.day) {
                                formattedDate = 'Today';
                              } else if (date.year == now.year &&
                                  date.month == now.month &&
                                  date.day == now.day - 1) {
                                formattedDate = 'Yesterday';
                              } else {
                                formattedDate =
                                    DateFormat('dd MMM, yyyy').format(date);
                              }
                              return Column(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 20,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(top: 5, left: 10, right: 11, bottom: 2),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFEBEBF0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(53),
                                      ),
                                    ),
                                    child: Text(
                                      formattedDate,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0,
                                      ),
                                      itemCount: filteredMessages.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        var item = filteredMessages[index];
                                        return InkWell(

                                          child: Container(
                                            width: width,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 13, vertical: 13),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            decoration: BoxDecoration(
// color: Color(0xffFFFFFF),
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(13),
                                            ),
                                            child: SizedBox(
                                              width: width / 1,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          item.fromName,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  "PoppinsRegular"),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          item.time.toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  "PoppinsRegular"),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: width/1.4,
                                                          child: Text(
                                                            item.messages,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight.w300,
                                                                fontSize: 11,
                                                                fontFamily:
                                                                    "PoppinsRegular"),
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                    item.messageImage.isNotEmpty?      Align(
                                                      alignment: Alignment.bottomRight,
                                                      child: InkWell(
                                                        onTap: () {
                                                          value3.moreClicked(item.docID);
                                                        },
                                                        child:  Text(
                                                          item.isMoreClicked?"Less": "More",
                                                          style: const TextStyle(
                                                              color: Colors.blue,
                                                              fontWeight:
                                                              FontWeight.w300,
                                                              fontSize: 12,
                                                              fontFamily:
                                                              "PoppinsRegular"),
                                                        ),
                                                      ),
                                                    ):const SizedBox(),
                                                    item.link.isNotEmpty&&item.isMoreClicked
                                                        ? InkWell(
                                                      onTap: () {
                                                        launch(Uri.parse(
                                                            item.link)
                                                            .toString());
                                                      },
                                                          child: Text(
                                                              item.link,
                                                              style: const TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                  color: Colors.blue,
                                                                  fontWeight:
                                                                      FontWeight.w300,
                                                                  fontSize: 11,
                                                                  fontFamily:
                                                                      "PoppinsRegular"),
                                                            ),
                                                        )
                                                        : const SizedBox(),
                                                    item.messageImage.isNotEmpty&&item.isMoreClicked
                                                        ? Container(
                                                            width: width,
                                                            height: 250,
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    5),
                                                            margin: const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 5),
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(25),
                                                              image: DecorationImage(
                                                                image: NetworkImage(
                                                                    item.messageImage),
                                                                fit: BoxFit
                                                                    .fill, // This ensures the image covers the entire container
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox()
                                                  ]),
                                            ),
                                          ),
                                        );
                                      })
                                ],
                              );
                            },
                          );
                        }),
                        Consumer<UserProvider>(builder: (context3, value3, child) {

                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemCount: value3.getMessageDateList.length,
                            itemBuilder: (BuildContext context, int index) {
                              print(value3.getMessageDateList.length);


                              List<GetMessageModel> filteredMessagesNew = value3.getSendMessage.where((element) =>
                              value3.getMessageDateList[index].dateFormat == element.dayDate).toList();
                              DateTime now = DateTime.now();
                              DateTime date = value3.getMessageDateList[index].date;
                              if (date.year == now.year &&
                                  date.month == now.month &&
                                  date.day == now.day) {
                                formattedDate = 'Today';
                              } else if (date.year == now.year &&
                                  date.month == now.month &&
                                  date.day == now.day - 1) {
                                formattedDate = 'Yesterday';
                              } else {
                                formattedDate =
                                    DateFormat('dd MMM, yyyy').format(date);
                              }
                              return Column(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 20,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(top: 5, left: 10, right: 11, bottom: 2),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFEBEBF0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(53),
                                      ),
                                    ),
                                    child: Text(
                                      formattedDate,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                      physics: const BouncingScrollPhysics(),

                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0,
                                      ),
                                      itemCount: filteredMessagesNew.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var item = filteredMessagesNew[index];
                                        return InkWell(
                                          onLongPress: () {
                                            value3.deleteMessageAlert(context,item.docID);
                                          },
                                          child: Container(
                                            width: width,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 13, vertical: 13),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            decoration: BoxDecoration(
// color: Color(0xffFFFFFF),
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(13),
                                            ),
                                            child: SizedBox(
                                              width: width / 1,
                                              child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          item.fromName,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              fontSize: 12,
                                                              fontFamily:
                                                              "PoppinsRegular"),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          item.time.toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              fontSize: 12,
                                                              fontFamily:
                                                              "PoppinsRegular"),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: width/1.4,
                                                          child: Text(
                                                            item.messages,
                                                            textAlign: TextAlign.start,

                                                            style: const TextStyle(

                                                                fontWeight:
                                                                FontWeight.w300,
                                                                fontSize: 11,
                                                                fontFamily:
                                                                "PoppinsRegular"),
                                                          ),
                                                        ),


                                                      ],
                                                    ),
                                                    item.messageImage.isNotEmpty?Align(
                                                      alignment: Alignment.bottomRight,
                                                      child: InkWell(
                                                        onTap: () {
                                                          value3.moreClickedFromSend(item.docID);
                                                        },
                                                        child:  Text(
                                                          item.isMoreClicked?"Less": "More",
                                                          style: const TextStyle(
                                                              color: Colors.blue,
                                                              fontWeight:
                                                              FontWeight.w300,
                                                              fontSize: 12,
                                                              fontFamily:
                                                              "PoppinsRegular"),
                                                        ),
                                                      ),
                                                    ):const SizedBox(),
                                                    item.link.isNotEmpty&&item.isMoreClicked
                                                        ? InkWell(
                                                      onTap: () {
                                                        launch(Uri.parse(
                                                            item.link)
                                                            .toString());
                                                      },
                                                      child: Text(
                                                        item.link,
                                                        style: const TextStyle(
                                                            decoration:
                                                            TextDecoration
                                                                .underline,
                                                            color: Colors.blue,
                                                            fontWeight:
                                                            FontWeight.w300,
                                                            fontSize: 11,
                                                            fontFamily:
                                                            "PoppinsRegular"),
                                                      ),
                                                    )
                                                        : const SizedBox(),
                                                    item.messageImage.isNotEmpty&&item.isMoreClicked
                                                        ? Container(
                                                      width: width,
                                                      height: 250,
                                                      padding:
                                                      const EdgeInsets.all(
                                                          5),
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(25),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              item.messageImage),
                                                          fit: BoxFit
                                                              .fill, // This ensures the image covers the entire container
                                                        ),
                                                      ),
                                                    )
                                                        : const SizedBox()
                                                  ]),
                                            ),
                                          ),
                                        );
                                      })
                                ],
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
