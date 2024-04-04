import 'package:flutter/material.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constants/functions.dart';
import '../../constants/my_colors.dart';
import '../../view/Widgets/my_widgets.dart';
import 'admin_homeScreen.dart';
import 'admin_menu_screen.dart';

class AdminTotalRegistrationsScreen extends StatelessWidget {
  const AdminTotalRegistrationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bxkclr,
      endDrawer: Drawer(
        width: width,
        child: const AdminMenuScreen(),
      ),
      appBar: AppBar(
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
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const CircleAvatar(
                backgroundColor:  Colors.transparent,
                radius: 20,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child:Icon(Icons.menu,color: cWhite,),
                ),
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),

        ],

        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        titleSpacing: .015,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: width/2.5,child: const Text("Total Registrations",maxLines: 3,textAlign: TextAlign.center,)),
            Consumer<AdminProvider>(builder: (context1, val20, child) {
              return Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0,bottom: 4,top: 5,left: 8),
                    child: InkWell(
                      onTap: () {
                        val20.downloadExcelForMembers(val20.filterRegistrationPendingList,"DOWNLOAD");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        // width: 200,
                        decoration: const ShapeDecoration(
                            shape: StadiumBorder(), ),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0,bottom: 4),
                    child: InkWell(
                      onTap: () {
                        val20.downloadExcelForMembers(val20.filterRegistrationPendingList,"SHARE");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        // width: 200,
                        decoration: const ShapeDecoration(
                            shape: StadiumBorder(),),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 5.0, right: 5),
                          child: Row(
                            children: [
                              Icon(Icons.share,color: Colors.white,size: 18,)
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
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: cWhite,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20,top: 10),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(200),
              ),
              child: searchBar("TOTAL_REGISTRATION")
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16,left: 25),
            child: Consumer<AdminProvider>(
              builder: (context,value1,child) {
                return InkWell(
                  onTap: (){
                    value1.showCalendarDialog(context,'TOTAL_REGISTRATION');
                  },
                  child: Container(
                    height: 30,
                    width: 100,
                    decoration: const ShapeDecoration(
                        shape: StadiumBorder(),
                        color: clF4F6F8
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Date",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "PoppinsRegular"
                        ),),
                        Icon(Icons.keyboard_arrow_down_outlined),
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
          
          Consumer<AdminProvider>(
            builder: (context,value2,child) {
              return Flexible(
                child:  value2.filterRegistrationPendingList.isNotEmpty?ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,),
                    itemCount: value2.filterRegistrationPendingList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item=value2.filterRegistrationPendingList[index];
                      return Container(
                        // height: height / 14,
                        width: width / 3,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: const LinearGradient(
                            colors: [
                              clFFFCF8,
                              myWhite
                            ]
                          ),
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
                              const SizedBox(height: 10),
                               Text(
                                item.name,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    fontFamily: "PoppinsRegular"),
                              ),

                               Text(
                                "Registration date:${item.regDate}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    fontFamily: "PoppinsRegular"),
                              ),

                               Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text("Reg.No :${item.regid}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                      fontFamily: "PoppinsRegular",
                                      fontWeight: FontWeight.w400
                                  ),),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                  Text(
                                   item.phone,
                                    style: const TextStyle(
                                        decoration:  TextDecoration.underline,
                                        color: Colors.black87,
                                        fontFamily: "PoppinsRegular",
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12),
                                  ),

                                ],
                              ),
                              const SizedBox(height: 15,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      launch('whatsapp://send?phone=${item.phone}');

                                    },
                                    child: Container(
                                        height: 30,
                                        width: width / 6,
                                        decoration: BoxDecoration(
                                            color: grdintclr2,
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        child: Image.asset( "assets/whatsapp.png",scale: 1,)),
                                  ),
                                  SizedBox(
                                    width: width * .02,
                                  ),
                                  InkWell(
                                    onTap: (){
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
                              const SizedBox(height: 14,),
                            ],
                          ),
                        ),

                      );
                    }):const Center(child: Text("No Data found !!!",style: TextStyle(fontSize: 16),)),
              );
            }
          ),
          Consumer<AdminProvider>(
              builder: (context,value,child) {
                return value.pendingRegistrationLimit > value.registrationPendingList.length||
                    value.filterRegistrationPendingList.isEmpty?
                SizedBox():
                Center(
                  child: InkWell(
                    onTap: (){
                      value.fetchPendingRegistrations(
                          false,
                          value
                              .registrationPendingList[
                          value.registrationPendingList.length - 1]
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
                  ),
                );
              }
          )
        ],
      ),
    );
  }
}
