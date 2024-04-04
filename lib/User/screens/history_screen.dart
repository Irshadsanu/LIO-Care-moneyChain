import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Provider/user_provider.dart';
import '../../constants/my_colors.dart';
import '../../models/paymentReportModelClass.dart';
import '../../models/transactions_model.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = '';

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgrnd,
      appBar: AppBar(
        backgroundColor: backgrnd,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Image.asset(
          'assets/bluelogo.png',
          scale: 18,
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "Transaction History",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: textColor,
                fontFamily: "PoppinsRegular"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Consumer<UserProvider>(builder: (context3, value, child) {
              return value.historyLoader
                ? Padding(
                  padding: EdgeInsets.only(top: height/2.8,left: width/2.2),
                  child: const CircularProgressIndicator(color: Colors.green),
                )
              :SizedBox(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemCount: value.historyDateList.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<TransactionsModel> filteredTransactions = value
                          .userTransactionsList
                          .where((element) =>
                              value.historyDateList[index].dateFormat ==
                              element.dateFormat)
                          .toList();
                      filteredTransactions.sort((a, b) => b.date.compareTo(a.date));
                      DateTime now = DateTime.now();
                      DateTime date = value.historyDateList[index].date;
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
                      return value.historyDateList.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 6, top: 5),
                                      child: Text(
                                        formattedDate,
                                        style: const TextStyle(
                                          color: cl5F5F5F,
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                      ),
                                      itemCount: filteredTransactions.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var item = filteredTransactions[index];
                                        return Container(
                                          width: width / 3,
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          clipBehavior: Clip.antiAlias,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFFFFFCF8),
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(width: 1, color: Color(0xFFECECEC)),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            shadows: [
                                              BoxShadow(
                                                color: Color(0x1E7C7C7C),
                                                blurRadius: 5,
                                                offset: Offset(0, 0),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundColor:
                                                    Colors.grey.shade50,
                                                child: Transform.rotate(
                                                    angle: item.flow == "IN"
                                                        ? 4
                                                        : 1,
                                                    child: Icon(
                                                      Icons
                                                          .arrow_upward_rounded,
                                                      color: item.flow == "IN"
                                                          ? cl00AD07
                                                          : clAD0000,
                                                    )),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              SizedBox(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    item.type=="HELP"
                                                    ?Text(
                                                      item.flow == "IN"
                                                      ? "${item.type} RECEIVED":"${item.type} GIVEN",
                                                      style: TextStyle(
                                                          color:
                                                          item.flow == "IN"
                                                              ? cl00AD07
                                                              : clAD0000,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize: 10,
                                                          fontFamily:
                                                          "PoppinsRegular"),
                                                    )
                                                    :Text(
                                                      item.type,
                                                      style: TextStyle(
                                                          color:
                                                              item.flow == "IN"
                                                                  ? cl00AD07
                                                                  : clAD0000,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 10,
                                                          fontFamily:
                                                              "PoppinsRegular"),
                                                    ),
                                                    Text(
                                                      item.name,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              "PoppinsRegular",
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      "ID:${item.id}",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 10,
                                                          fontFamily:
                                                              "PoppinsRegular"),
                                                    ),
                                                    item.number!=""
                                                    ?Text(
                                                      item.number,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              "PoppinsRegular",
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 10),
                                                    )
                                                    :Text(
                                                      "${item.type} ${item.installment}",
                                                      style: const TextStyle(
                                                          fontFamily:
                                                          "PoppinsRegular",
                                                          fontWeight:
                                                          FontWeight.w300,
                                                          fontSize: 10),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                              SizedBox(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      item.tree,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 12,
                                                      ),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                    item.grade!=""
                                                    ?Text(
                                                      item.grade,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 12,
                                                      ),
                                                      textAlign: TextAlign.end,
                                                    ):const SizedBox(),
                                                    Text(
                                                      item.time,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12,
                                                      ),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                    Text(
                                                      "₹${item.amount}",
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                          color: textColor,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                          fontFamily:
                                                              "PoppinsRegular"),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    )
// Text("9075896490",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 10),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      })
                                ],
                              ),
                            )
                          : const SizedBox();
                    }),
              );
            }),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
//
// value3.userTransactionsList.isNotEmpty
// ? Flexible(
// fit: FlexFit.loose,
// child: ListView.builder(
// shrinkWrap: true,
// physics: const ScrollPhysics(),
// scrollDirection: Axis.vertical,
// padding: const EdgeInsets.symmetric(
// horizontal: 12.0,
// ),
// itemCount: value3.userTransactionsList.length,
// itemBuilder:
// (BuildContext context, int index) {
// var item = value3.userTransactionsList[index];
// return Container(
// width: width / 3,
// margin: const EdgeInsets.all(5),
// padding: const EdgeInsets.only(left: 10,right: 10),
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(13),
// ),
// child: Row(
// children: [
// CircleAvatar(
// radius: 25,
// backgroundColor: Colors.grey.shade50,
// child: Transform.rotate(
// angle: item.flow=="IN"?1:4,
// child: Icon(Icons.arrow_upward_rounded,color: item.flow=="IN"?cl00AD07:clAD0000,)),
// ),
// const SizedBox(width: 8,),
// SizedBox(
// child:  Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// mainAxisAlignment:
// MainAxisAlignment.center,
// children:  [
// const SizedBox(height: 10,),
// Text(
// item.type,
// style: TextStyle(
// color: item.flow=="IN"?cl00AD07:clAD0000,
// fontWeight: FontWeight.w600,
// fontSize: 10,
// fontFamily: "PoppinsRegular"),
// ),
// Text(
// item.name,
// style: const TextStyle(
// color: Colors.black,
// fontFamily: "PoppinsRegular",
// fontWeight: FontWeight.w500,
// fontSize: 14),
// ),
// Text(
// "ID:${item.id}",
// style: const TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 10,
// fontFamily: "PoppinsRegular"),
// ),
//
// Text(
// item.number,
// style: const TextStyle(
// fontFamily: "PoppinsRegular",
// fontWeight: FontWeight.w300,
// fontSize: 10),
// ),
// const SizedBox(height: 10,),
// ],
// ),
// ),
// const Spacer(),
// SizedBox(
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.end,
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children:  [
// Text(
// item.time,
// style: const TextStyle(
// fontWeight: FontWeight.w600,
// fontSize: 12,),textAlign: TextAlign.end,
// ),
// Text(
// "₹${item.amount}",
// textAlign: TextAlign.right,
// style: TextStyle(
// color: textColor,
// fontWeight: FontWeight.w500,
// fontSize: 16,
// fontFamily: "PoppinsRegular"),
// ),
// const SizedBox(height: 2,)
// // Text("9075896490",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 10),),
// ],
// ),
// ),
// ],
// ),
// );
// }),
// )
//     : const SizedBox(
// height: 80,
// child: Center(child: Text("No Approved Transactions.")),
// );
// }),
