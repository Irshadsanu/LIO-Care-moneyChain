import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lio_care/Constants/functions.dart';
import 'package:provider/provider.dart';
import '../../Provider/user_provider.dart';
import '../../constants/my_colors.dart';
import '../../models/admin_trasnaction_historyModelClass.dart';
import '../../models/userLatestModel.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    String formattedDate='';


    return Scaffold(
      backgroundColor: bxkclr,
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: bxkclr,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: (){
              finish(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios,color: textColor,),
                  Image.asset("assets/bluelogo.png",scale: 18,),
                ],
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text("See Your Notifications",
                   style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: "PoppinsRegular"),),
            ),
            newListView(context),
            Consumer<UserProvider>(
              builder: (context,value2,child) {
                return value2.notificationLength==value2.notificationList.length?const SizedBox():Center(
                  child: InkWell(onTap: (){
                    value2.fetchNotification(value2.registerID,value2.notificationList[value2.notificationList.length - 1].reg_id);
                  }, child:Container(
                      color: loadMoreBg,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30,right: 30,top: 8,bottom: 8),
                        child:  Text("Load More",
                          style:  TextStyle(
                              color: textColor,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 12),),
                      )),),
                );
              }
            )
          ],
        ),
      ),
      // bottomNavigationBar: const BottomNavebar(),
    );
  }

  Widget newListView(BuildContext context){
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Consumer<UserProvider>(
      builder: (context,value,child) {
        return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
        itemCount:  value.tranactionDateList.length,
        itemBuilder: (BuildContext context, int index1) {
          String formattedDate='';
          List<UserNotificationModel> newList = value.notificationList.where((element) => value.tranactionDateList[index1].dateFormat==element.formatteddate).toList();
          DateTime now = DateTime.now();
          DateTime date = value.tranactionDateList[index1].date;
          if (date.year == now.year && date.month == now.month && date.day == now.day) {
            formattedDate = 'Today';
          }
          else if (date.year == now.year && date.month == now.month && date.day == now.day - 1) {
            formattedDate = 'Yesterday';
          }
          else {
            formattedDate = DateFormat('dd MMM, yyyy').format(date);
          }
          return  Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        formattedDate,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PoppinsRegular"),
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            itemCount: newList.length,
                            itemBuilder: (BuildContext context, int index) {
                              UserNotificationModel item = newList[index];
                              return InkWell(
                                onTap: () {
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
                                    child: SingleChildScrollView(
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: width / 1.3,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(height: 10),
                                                Text(
                                                  item.content ,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 15,
                                                      fontFamily: "PoppinsRegular"),
                                                ),
                                                const SizedBox(
                                                  height: 18,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                     Text(
                                                      item.formatteddate,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black54,
                                                          fontFamily:
                                                          "PoppinsMedium",
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                    Text(
                                                      item.time,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black54,
                                                          fontFamily:
                                                          "PoppinsMedium",
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                             const SizedBox(
                                                  height: 8,
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),

                ],
              );
        });
      }
    );
  }
}











