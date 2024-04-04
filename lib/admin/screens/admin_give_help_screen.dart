import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:lio_care/models/user_giveHelpModel.dart';
import 'package:provider/provider.dart';

import '../../constants/functions.dart';
import '../../constants/my_colors.dart';
import '../../view/Widgets/my_widgets.dart';
import 'admin_homeScreen.dart';
import 'admin_menu_screen.dart';

class AdminGiveHelp extends StatelessWidget {
  const AdminGiveHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 37),
                    child: Text(
                      "Total Give Help",
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
                    "₹ ${value.giveHelpTotal}",
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
          title: Image.asset(
            "assets/whitelogo.png",
            scale: 12,
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
      body: Consumer<AdminProvider>(builder: (context, value1, child) {
        return SingleChildScrollView(
          // physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: searchBar('ADMIN_UPGRADE')),
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
                                value.showCalendarDialog(context, "HELP_REPORT");
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
                  ],
                ),
              ),

              SizedBox(
                width: 500,
                // height: height * 0.59,
                child:value1.filterAdminGiveHelpList.isNotEmpty
                    ? ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemCount: value1.reportDateList.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<AdminGiveHelpModel> filteredTransactions = value1.filterAdminGiveHelpList.where((element) => value1.reportDateList[index].dateFormat == element.paymentDate).toList();
                      filteredTransactions.sort((a, b) => b.paymentDateTime.compareTo(a.paymentDateTime));
                      return filteredTransactions.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20, bottom: 6),
                                        child: Text(
                                          value1.reportDateList[index].dateFormat,
                                          style: const TextStyle(
                                            color: cl5F5F5F,
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      physics: const ScrollPhysics(),
                                      itemCount: filteredTransactions.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var item = filteredTransactions[index];

                                        return Container(
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
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: width / 1.5,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                        item.fromName,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16,
                                                            fontFamily:
                                                                "PoppinsRegular"),
                                                      ),

                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            "Reg.ID :",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54,
                                                                fontFamily:
                                                                    "PoppinsRegular",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          Text(
                                                            item.transactionID,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black87,
                                                                fontFamily:
                                                                    "PoppinsMedium",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            item.fromNumber,
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff252525),
                                                                fontFamily:
                                                                    "PoppinsMedium",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 12
                                                            ),
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0,
                                                          right: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                       "₹${item.amount}",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 18,
                                                            color: Color(
                                                                0xff1746A2),

                                                            fontFamily:
                                                                "PoppinsMedium"),
                                                      ),
                                                      Text(
                                                        item.tree,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 8.8,
                                                            color: Color(
                                                                0xff1746A2),
                                                            fontFamily:
                                                                "PoppinsMedium"),
                                                      ),
                                                      Text(
                                                          DateFormat(
                                                              'hh:mm:a')
                                                              .format(item
                                                              .paymentDateTime),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 8.8,
                                                            color: Color(
                                                                0xff1746A2),
                                                            fontFamily:
                                                                "PoppinsMedium"),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            )
                          : const SizedBox();
                    }):SizedBox(
                  height: height*.5,
                  child: const Center(
                    child: Text("No Data Found !!!",style: TextStyle(fontWeight: FontWeight.w500),),
                  ),
                ),
              ),  const SizedBox(),
              Consumer<AdminProvider>(
                builder: (context,value,child) {
                  return
                    value.filterAdminGiveHelpList.isEmpty || value.helpsLoadLimit > value.filterAdminGiveHelpList.length
                        ?const SizedBox():Center(
                        child: InkWell(
                          onTap: () {
                            value.fetchAdminTotalGiveHelp(false,value.filterAdminGiveHelpList[value.filterAdminGiveHelpList.length - 1].paymentDateTime);

                          },
                          child:  Container(
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

                        ));
                }
              ),
              const SizedBox(height: 20,)

            ],
          ),
        );
      }),
    );
  }
}
