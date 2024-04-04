import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../Constants/functions.dart';
import '../../constants/my_colors.dart';
import '../../models/lastTrasactionModel.dart';

class LastTransactionsScreen extends StatelessWidget {
  const LastTransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = '';

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bxkclr,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: bxkclr,
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
            "Recent Transactions",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: "PoppinsRegular",
                color: cBlack),
          ),
          // child: Text("Lio Care",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Textcolor,fontFamily: "PoppinsRegular"),),
        ),
      ),
      body: SizedBox(
        width:width ,
        height: height,
        child: Consumer<UserProvider>(builder: (context, value1, child) {
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount:value1.lastTransactionDateList.length,
              itemBuilder: (BuildContext context, int index) {
                List<LastTransactionModel> filteredTransactions = value1
                      .lastTransactionList
                    .where((element) =>
                value1.lastTransactionDateList[index].dateFormat ==
                    element.topperDate)
                    .toList();
                filteredTransactions.sort((a, b) => b.date1.compareTo(a.date1));
                DateTime now = DateTime.now();
                DateTime date =value1.lastTransactionDateList[index].date;
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
              return value1.lastTransactionDateList.isNotEmpty
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
                            itemBuilder: (BuildContext context, int index) {
                              var item = filteredTransactions[index];

                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 0.3,
                                  child: ListTile(
                                    // isThreeLine: true,
                                    leading:
                                        Image.asset("assets/lastTransLead.png"),
                                    title: Text(
                                      item.topperName,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "PoppinsRegular"),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Received from ${item.senderName}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "PoppinsRegular"),
                                        ),
                                        Text(
                                         value1.outputDayNode2.format(item.date1)
                                            // item.topperDate.toString()
                                    ,
                                          style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "PoppinsRegular"
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        // const SizedBox(
                                        //   height: 3,
                                        // ),
                                        Text(
                                          item.transactionType,
                                          style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                              // fontFamily: "PoppinsRegular"
                                          ),
                                        ),
                                        // const SizedBox(
                                        //   height: 3,
                                        // ),
                                        Text(
                                          "₹ ${item.topperAmount}",
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              // fontFamily: "PoppinsRegular",

                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  )
                  : SizedBox();
            }
          );
        }),
      ),
    );
  }
}
