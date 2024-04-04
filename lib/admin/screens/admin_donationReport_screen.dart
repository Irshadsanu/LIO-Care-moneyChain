import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:provider/provider.dart';

import '../../constants/my_colors.dart';
import '../../models/pmfDetail_model.dart';
import '../../view/Widgets/my_widgets.dart';
import 'admin_homeScreen.dart';
import 'admin_menu_screen.dart';

class AdminDonationReportScreen extends StatelessWidget {
  const AdminDonationReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    AdminProvider adminProvider=Provider.of<AdminProvider>(context,listen: false);
    return Scaffold(endDrawer: Drawer(
      width: width,
      child: const AdminMenuScreen(),
    ),
      backgroundColor: bxkclr,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height*0.17),
        child: AppBar(
          backgroundColor: myWhite,
          toolbarHeight: 65,
          leadingWidth: 30,
          leading:InkWell(
            onTap: (){
              callNextReplacement(const AdminHomeScreen(),context);
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Icon(Icons.arrow_back_ios,color: myWhite,),
            ),
          ),          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors:[
                      cl001969,
                      cl005BBB
                    ])
            ),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 20,),

                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0,bottom: 0),
                    child: Text("CMF Report",
              style: TextStyle(
                  color: myWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: "PoppinsRegular"),),
            ),
                ),
                Consumer<AdminProvider>(
                  builder: (context,value,child) {
                    return Text("₹ ${value.donationTotal}",
                    style: const TextStyle(fontSize: 27,color: myWhite,fontFamily: "PoppinsRegular,",fontWeight: FontWeight.w700),);
                  }
                ),
                const SizedBox(height: 5,)
              ],
            ),
          ),
          elevation: 0,
          title:Image.asset("assets/whitelogo.png",scale: 12,),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 20,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(Icons.menu,color: cWhite,),
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
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<AdminProvider>(
            builder: (context1,value1,child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20,top: 10),
                  child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: searchBar('Admin_CMF')
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: width / 45),
                        child: InkWell(
                          onTap: (){
                            adminProvider.showCalendarDialog(context, "CMF_REPORT");
                          },
                          child: Container(
                            height: width / 15,
                            width: width / 4.5,
                            decoration: const ShapeDecoration(
                                shape: StadiumBorder(), color: Color(0xffF4F6F8)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Date"),
                                Icon(Icons.keyboard_arrow_down_outlined),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Consumer<AdminProvider>(
                        builder: (context,value,child) {
                          return Padding(
                            padding: EdgeInsets.only(top: width / 45),
                            child: InkWell(
                              onTap: (){
                                adminProvider.createExcelDonationReport(value.filterAdminDonationList);
                              },
                              child: Container(
                                height: 30,
                                width: 100,
                                decoration: const ShapeDecoration(
                                    shape: StadiumBorder(), color: Color(0xffF4F6F8)),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Excel"),
                                    Icon(Icons.arrow_downward_outlined),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                ),
                value1.adminDonationList.isNotEmpty? donationListWidget(context):SizedBox(
              height: height*.5,
              child: const Center(child: Text("No Data Found !!!",style: TextStyle(fontWeight: FontWeight.w500),))),
                Consumer<AdminProvider>(builder: (context, value, child) {
                  return value.filterAdminDonationList.isEmpty || value.donationLoadLimit > value.filterAdminDonationList.length
                      ? const SizedBox()
                      :Center(
                    child: InkWell(
                        onTap: () {
                          value.fetchAdminDonationData( false,value.filterAdminDonationList[value.filterAdminDonationList.length - 1].dateTime);
                        },
                        child:Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: loadMoreBg,
                            ),

                            child: Padding(
                              padding: const EdgeInsets.only(left: 40,right: 40,top: 8,bottom: 8),
                              child: Text("Load More",
                                style:  TextStyle(
                                    color: textColor,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),),
                            )),
                  )  );

                }),
                const SizedBox(height:10)
              ],
            );
          }
        ),
      ),
    );
  }

  Widget donationListWidget(BuildContext context){
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Consumer<AdminProvider>(
      builder: (context,value,child) {
        return  value.reportDateList.isNotEmpty?ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: value.reportDateList.length,
            itemBuilder: (BuildContext context, int index) {
             String formattedDate='';

              List<AdminDonationDetails> filterDonationList = value.filterAdminDonationList.where((element)
              => value.reportDateList[index].dateFormat==element.date).toList();
              DateTime now = DateTime.now();
              DateTime date = value.reportDateList[index].date;
              if (date.year == now.year &&
                  date.month == now.month &&
                  date.day == now.day) {
                formattedDate = 'Today';
              } else if (date.year == now.year &&
                  date.month == now.month &&
                  date.day == now.day - 1) {
                formattedDate = 'Yesterday';
              } else {
                formattedDate = DateFormat('dd MMM, yyyy').format(date);
              }

              return filterDonationList.isNotEmpty?Column(
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
                      const SizedBox(width: 20,)
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 12.0,),
                          itemCount: filterDonationList.length,
                          itemBuilder: (BuildContext context, int index) {
                            AdminDonationDetails item=filterDonationList[index];
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: width / 1.9,
                                      child:  Column(
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

                                          const SizedBox(height: 18,),
                                          Text(
                                            DateFormat("MM/dd/yyyy").format(item.dateTime),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10,
                                                fontFamily: "PoppinsRegular"),
                                          ),

                                          Text("Distribution ID:${item.distribution}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black87,
                                                fontFamily: "PoppinsRegular",
                                                fontWeight: FontWeight.w400
                                            ),),

                                          Text(item.phoneNo,
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontFamily: "PoppinsMedium",
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12),
                                          ),
                                          const SizedBox(height: 8,),
                                        ],
                                      ),
                                    ),
                                     Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0,right: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            DateFormat("hh:mm a").format(item.dateTime),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10,
                                                fontFamily: "PoppinsMedium"),
                                          ),
                                          Text(
                                            '₹ ${item.amount}',
                                            style: const TextStyle(
                                                color: cl1746A2,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          )
                                        ],),
                                    )
                                  ],
                                ),
                              ),

                            );
                          }),
            ),
                    ],
                  ),
                ],
              ):const SizedBox();
          }
        ):SizedBox(
          height: height*.45,
          child: const Center(
            child: Text(
              "No Donations Yet.",style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        );
      }
    );

  }
}
