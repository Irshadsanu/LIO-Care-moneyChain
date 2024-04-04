import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:lio_care/admin/screens/admin_amfReceipt_screen.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:provider/provider.dart';

import '../../constants/my_colors.dart';
import '../../models/pmfDetail_model.dart';
import '../../view/Widgets/my_widgets.dart';
import 'admin_homeScreen.dart';
import 'admin_menu_screen.dart';

class AdminAmfReportScreen extends StatelessWidget {
  String type;
  AdminAmfReportScreen({Key? key,required this.type}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    AdminProvider adminProvider=Provider.of<AdminProvider>(context,listen: false);

    return Scaffold(
      endDrawer: Drawer(
        width: width,
        child: const AdminMenuScreen(),
      ),
      backgroundColor: bxkclr,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.17),
        child: AppBar(
          backgroundColor: myWhite,
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
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [cl001969, cl005BBB])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0, bottom: 0,top: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      type=="PMC"?
                      "PMC Report":"PRC Report",
                      style: TextStyle(
                          color: myWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "PoppinsRegular"),
                    ),
                  ),
                ),
                Consumer<AdminProvider>(builder: (context, value, child) {
                  return Text(
                    type=="PMC"?
                    "₹ ${value.pmcTotal}":"₹ ${value.prcTotal}",
                    style: const TextStyle(
                        fontSize: 27,
                        color: myWhite,
                        fontFamily: "PoppinsRegular,",
                        fontWeight: FontWeight.w700),
                  );
                }),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
          elevation: 0,
          title: Image.asset("assets/whitelogo.png",scale: 12,
          ),
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
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
              child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: searchBar("AdminPMC")),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: width / 45),
                    child: Consumer<AdminProvider>(
                        builder: (context, value, child) {
                      return InkWell(
                        onTap: () {
                          if(type=="PMC") {
                            value.showCalendarDialog(context, "PMC_REPORT");
                          }else{
                            value.showCalendarDialog(context, "PRC_REPORT");
                          }
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
                      );
                    }),
                  ),
                  Consumer<AdminProvider>(
                    builder: (context,value,child) {
                      return Padding(
                        padding: EdgeInsets.only(top: width / 45),
                        child: InkWell(
                          onTap: (){
                            adminProvider.createExcelPMCReport(value.filterAdminPMCDetailsList);
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
            pmcListWidget(context),
            const SizedBox(height: 20,),
            Consumer<AdminProvider>(
              builder: (context, value, child) {
                ///fix this
                if (value.filterAdminPMCDetailsList.isEmpty || value.pmcLoadMoreLimit > value.filterAdminPMCDetailsList.length) {
                  return const SizedBox();
                } else {
                  return Center(
                    child: InkWell(
                      onTap: () {
                        if(type=="PMC") {
                          value.fetchAdminPMCData("PMC",false, value.filterAdminPMCDetailsList[value.filterAdminPMCDetailsList.length - 1].pmcDateTime);
                        }else{
                          value.fetchAdminPMCData("PRC",false, value.filterAdminPMCDetailsList[value.filterAdminPMCDetailsList.length - 1].pmcDateTime);
                        }

                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 180,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: loadMoreBg,
                        ),
                        child: Text(
                          "Load More",
                          style: TextStyle(
                            color: textColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20,)

          ],
        ),
      ),
    );
  }

  Widget pmcListWidget(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AdminProvider>(builder: (context, value, child) {
      return value.filterAdminPMCDetailsList.isNotEmpty? ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount:  value.reportDateList.length,
          itemBuilder: (BuildContext context, int index1) {
   String formattedDate='';
            List<AdminPMCDetails> filteredPmc = value.filterAdminPMCDetailsList.where((element)
            => value.reportDateList[index1].dateFormat==element.date).toList();
            DateTime now = DateTime.now();
            DateTime date = value.reportDateList[index1].date;
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
            return filteredPmc.isNotEmpty?Column(
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
                          itemCount: filteredPmc.length,
                          itemBuilder: (BuildContext context, int index) {
                            AdminPMCDetails item = filteredPmc[index];
                            // value.adminGstCalc(item.amount);

                            return InkWell(
                              onTap: () {
                                callNext( AdminAmfReceiptScreen(date: item.date,amount: item.amount,phonenumber: item.phone,regid: item.regId,
                                    stage:item.level,transid: item.transactionId,name: item.name,totalamount: value.pmcTotal.toStringAsFixed(1),), context);
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width / 1.5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 10),
                                            Text(
                                              item.name ,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  fontFamily: "PoppinsRegular"),
                                            ),
                                            const SizedBox(
                                              height: 18,
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Distribution ID :",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black54,
                                                      fontFamily:
                                                          "PoppinsRegular",
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  item.regId,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black87,
                                                      fontFamily:
                                                          "PoppinsMedium",
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Transaction ID: ",
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontFamily:
                                                          "PoppinsMedium",
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  item.transactionId,
                                                  style: const TextStyle(
                                                      color: Colors.black87,
                                                      fontFamily:
                                                          "PoppinsMedium",
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8.0, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              item.level,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54,
                                                  fontSize: 12,
                                                  fontFamily: "PoppinsMedium"),
                                            ),
                                            const SizedBox(
                                              height: 22,
                                            ),
                                            // Text(
                                            //   "GST: ${item.gst}%",
                                            //   style:  const TextStyle(
                                            //       fontWeight: FontWeight.w500,
                                            //       fontSize: 12,
                                            //       color: Colors.black45,
                                            //       fontFamily: "PoppinsMedium"),
                                            // ),
                                            Text(
                                              '₹ ${item.amount}',
                                              style: TextStyle(
                                                  color: clFF731D,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ],
            )
            :const SizedBox();
          }):SizedBox(
          height: height*.5,
          child: const Center(child: Text("No Data Found !!!",style: TextStyle(fontWeight: FontWeight.w500),)));
    });
  }
}
