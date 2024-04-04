import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/functions.dart';
import '../../constants/my_colors.dart';
import '../../models/basic_treeListModel.dart';
import '../../models/user_giveHelpModel.dart';
import '../../view/Widgets/my_widgets.dart';
import 'admin_menu_screen.dart';

class AdminReferralScreen extends StatelessWidget {
  double totalAmount;
  AdminReferralScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
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
          leading: IconButton(
            onPressed: () {
              finish(context);
            },
            icon: const Padding(
              padding: EdgeInsets.only(left: 21),
              child: Icon(
                Icons.arrow_back_ios,
                color: myWhite,
              ),
            ),
          ),
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
                      "Total Referrals",
                      style: TextStyle(
                          color: myWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "PoppinsRegular"),
                    ),
                  ),
                ),
                Consumer<AdminProvider>(
                  builder: (context,value,child) {
                    return Text(
                      "₹${ value.referralTotal}",
                      style: const TextStyle(
                          fontSize: 27,
                          color: myWhite,
                          fontFamily: "PoppinsRegular,",
                          fontWeight: FontWeight.w700),
                    );
                  }
                ),
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
      body: Consumer<AdminProvider>(builder: (context, value5, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: searchBar('referral')),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: width / 45),
                      child: Consumer<AdminProvider>(
                          builder: (context, value2, child) {
                        return InkWell(
                          onTap: () {
                            // value2.showCalendarDialog(context,"Referral");
                            // value2.showCalendarDialog(context, "Referral");
                            value2.filterOpened();
                            value2.secondDropDownOpened();

                          },
                          child: Container(
                            height: 35,
                            width: 100,
                            decoration: const ShapeDecoration(
                                shape: StadiumBorder(),
                                color: Color(0xffF4F6F8)),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Filter",style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: cBlack,
                                  fontSize: 13,
                                  fontFamily: "PoppinsRegular",
                                ),),
                                Icon(value2.isOpenedFilter==false?Icons.keyboard_arrow_down_outlined:Icons.keyboard_arrow_up),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    value5.isOpenedFilter==true?

                    Padding(
                      padding: EdgeInsets.only(top: width / 45),
                      child: Consumer<AdminProvider>(
                          builder: (context, value2, child) {
                        return InkWell(
                          onTap: () {
                            // value2.showCalendarDialog(context,"Referral");
                            // value2.showCalendarDialog(context, "Referral");
                            value2.filterOpened();
                            value2.clearFilter();
                          },
                          child: Container(
                            height: 35,
                            width: 120,
                            decoration: const ShapeDecoration(
                                shape: StadiumBorder(),
                                color: Color(0xffF4F6F8)),
                            child:  const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Filter Reset",style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: cBlack,
                              fontSize: 13,
                              fontFamily: "PoppinsRegular",
                            ),),
                                Icon(Icons.close),
                              ],
                            ),
                          ),
                        );
                      }),
                    ):const SizedBox(),

                  ],
                ),
              ),
              value5.isOpenedFilter==true?
              Padding(
                padding: EdgeInsets.only(top: width / 45),
                child: Consumer<AdminProvider>(
                    builder: (context,value2,child) {
                      return InkWell(
                        onTap: (){
                          value2.showCalendarDialog(context,"Referral");
                        },
                        child: Container(
                          height: 30,
                          width: 349,
                          decoration: const ShapeDecoration(
                              shape: StadiumBorder(), color: Color(0xffF4F6F8)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              children: [
                                Text("Date",style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: cBlack,
                              fontSize: 12,
                              fontFamily: "PoppinsRegular",
                            ),),
                                Spacer(),
                                Icon(Icons.keyboard_arrow_down_outlined),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ):const SizedBox.shrink(),
              const SizedBox(height: 5,),

                value5.isOpenedFilter==true?
              SizedBox(
                height: 30,
                width: 349,
                child: Consumer<UserProvider>(
                  builder: (context,value2,child) {
                    return Container(
                      height: 35,
                      width: 400,
                      decoration: const ShapeDecoration(
                        shape: StadiumBorder(),
                        color: Color(0xffF4F6F8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Consumer<AdminProvider>(
                          builder: (context, value1, child) {
                            return PopupMenuButton<String>(
                              icon: Row(
                                children: [
                                  Text(value1.selectedUserTree!,style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: cBlack,
                                    fontSize: 12,
                                    fontFamily: "PoppinsRegular",
                                  ),),
                                  const Spacer(),
                                  const Icon(Icons.keyboard_arrow_down),
                                ],
                              ),
                              itemBuilder: (BuildContext context) {
                                return value2.treeList.map((TreeListModel option) {
                                  return PopupMenuItem<String>(
                                    value: option.levelName,
                                    child: Text(option.levelName, style: const TextStyle(fontSize: 14)),
                                  );
                                }).toList();
                              },
                              onSelected: (String newValue) {
                                value5.filterListForDropDown(newValue);
                                value1.selectedUserTree = newValue;

                                value1.filterForGrade('STARTER',newValue);
                                value5.enableSecondDropdown();
                              },
                            );
                          },
                        ),
                      ),
                    );

                  }
                )
              )
                    :const SizedBox(),
              const SizedBox(height: 5,),
                    value5.isSecondDropdownEnabled==true&&value5.isOpenedFilter==true?
                    Consumer<AdminProvider>(
                      builder: (context,value1,child) {
                        print(value5.isSecondDropdownEnabled.toString()+value5.isOpenedFilter.toString());
                        return Container(
                          width: 349,
                          height: 30,
                          decoration: const ShapeDecoration(
                            shape: StadiumBorder(),
                            color: Color(0xffF4F6F8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: PopupMenuButton<String>(
                              icon: Row(
                                children: [
                                  Text( value1.selectedUserGrade! ,style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: cBlack,
                                    fontSize: 12,
                                    fontFamily: "PoppinsRegular",
                                  ),),
                                  const Spacer(),

                                  const Icon(Icons.keyboard_arrow_down),
                                ],
                              ),
                              onSelected: (String newValue) {
                                value1.selectedUserGrade = newValue;
                                // value1.filterForGrade(newValue, value1.selectedUserTree!);
                                value1.filterForGrade(newValue,value1.selectedUserTree!);

                              },
                              itemBuilder: (BuildContext context) {
                                return value5.partialItemList.map((String option) {
                                  return PopupMenuItem<String>(
                                    value: option,
                                    child: Text(option, style: const TextStyle(fontSize: 14)),
                                  );
                                }).toList();
                              },
                            ),
                          ),
                        );

                      }
                    )
                        :const SizedBox(),
              const SizedBox(height: 5,),
              pmcListWidget(context),
            ],
          ),
        );
      }),
    );
  }

  Widget pmcListWidget(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Consumer<AdminProvider>(builder: (context, value, child) {
      return value.adminReferralList.isNotEmpty
          ? Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                    ),
                    itemCount: value.refferalDateList.length,
                    itemBuilder: (BuildContext context, int index) {
                      String formattedDate = '';
                      List<AdminReferralLedgerModel> newList = value
                          .filterAdminReferralList
                          .where((element) =>
                              value.refferalDateList[index].dateFormat ==
                              element.paymentTime)
                          .toList();
                      DateTime now = DateTime.now();
                      DateTime date = value.refferalDateList[index].date;
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

                      return newList.isNotEmpty
                          ? Column(
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
                                          itemBuilder: (BuildContext context,
                                              int index1) {
                                            AdminReferralLedgerModel item =
                                                newList[index1];
                                            return InkWell(
                                              onTap: () {
                                                // callNext( AdminAmfReceiptScreen(regid: '',phonenumber: '',amount: '',date: '',stage: '',transid: '',name: '',totalamount: ''), context);
                                              },
                                              child: Container(
                                                // height: height / 14,
                                                width: width / 3,
                                                margin:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  gradient:
                                                      const LinearGradient(
                                                          colors: [
                                                        clFFFCF8,
                                                        myWhite
                                                      ]),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                          const Offset(0, 2),
                                                      blurRadius: 3,
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: width / 1.7,
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
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      "PoppinsRegular"),
                                                            ),
                                                            const SizedBox(
                                                              height: 18,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  "Phone :",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          "PoppinsRegular",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                                Text(
                                                                  item.fromNumber,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
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
                                                                const Text(
                                                                  "to  : ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black45,
                                                                      fontFamily:
                                                                          "PoppinsMedium",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Text(
                                                                  item.toName,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black87,
                                                                      fontFamily:
                                                                          "PoppinsMedium",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      fontSize:
                                                                          12),
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
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0,
                                                                right: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            const SizedBox(
                                                              height: 22,
                                                            ),
                                                            Text(
                                                              '₹ ${item.amount}',
                                                              style: TextStyle(
                                                                  color:
                                                                      clFF731D,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
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
                          : const SizedBox();
                    }),
                Consumer<AdminProvider>(builder: (context, value, child) {
                  return value.referralLoadLimit>value.adminReferralList.length || value.adminReferralList.isEmpty
                      ? const SizedBox()
                      : InkWell(
                    onTap: () {
                      AdminProvider adminProvider =
                      Provider.of<AdminProvider>(context,
                          listen: false);
                      adminProvider.fetchReferralLedger(
                          false,
                          value.filterAdminReferralList[
                          value.filterAdminReferralList.length -
                              1]
                              .paymentTimeDateTime);
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
                  );
                }),
              ],
            )
          : SizedBox(
              height: height * .45,
              child: const Center(
                child: Text("No Data Found !!!",
                    style: TextStyle(fontWeight: FontWeight.w500)),
              ),
            );
    });
  }
}
