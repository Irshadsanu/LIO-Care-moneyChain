import 'package:flutter/material.dart';
import 'package:lio_care/Constants/functions.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/my_colors.dart';

class HelpLedgerScreen extends StatelessWidget {
  const HelpLedgerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
  int  index=1;
    int rollNumber = index;

    return Scaffold(
        backgroundColor: bxkclr,
      appBar:AppBar(
        backgroundColor: bxkclr,
        elevation: 0,
        leadingWidth: 100,
        centerTitle: true,
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
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child:Text(
            'Help Ledger',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontFamily: 'PoppinsRegular',
              fontWeight: FontWeight.w600,
            ),
          ),

        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
           margin: const EdgeInsets.only(left: 20.0,right: 20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  color: Colors.grey.withOpacity(0.2),
                ),
              ],
            ),
            child: Consumer<UserProvider>(
              builder: (context,value10,child) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children:  [
                            const Text("Total Help Received",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              fontFamily: "PoppinsRegular"),),
                            Text("₹".toString()+value10.totalHelpReceivedAmount.toString(),
                              style: const TextStyle(
                                  color: cl16B200,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  fontFamily: "PoppinsRegular"),),
                          ],
                        ),
                        Column(
                          children:  [
                            const Text("Total give help",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  fontFamily: "PoppinsRegular"),),
                            Text("₹${value10.totalGiveHelpAmount}",
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  fontFamily: "PoppinsRegular"),),
                          ],
                        )
                      ],
                    ),
                  ],
                );
              }
            ),
          ),
          Consumer<UserProvider>(
            builder: (context,value11,child) {
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 3,top: 10),
                    child: SizedBox(
                      width: width/1.55,
                      height: 40,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        elevation: 0.3,
                        child: TextField(
                          textAlign: TextAlign.start,
                          onChanged: (value) {
                            value11.filteruserHelpLedgerSeach(value);
                          },
                          decoration: const InputDecoration(
                            hintText: "Search",
                            hintStyle: TextStyle(
                              color: Colors.black54,
                              fontFamily: "PoppinsMedium",
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 2,horizontal: 15),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(27)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(27)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 30,
                        width: width/3.9,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        color: myWhite,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: InkWell(
                        onTap: () {

                           value11.showCalendarDialogUser(context,value11.registerID);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 5,),
                            Text(
                              "Date",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontFamily: "PoppinsRegular",
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: cl5F9DF7,
                              radius: 14,
                              child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: myWhite,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          ),

          SizedBox(
            height: height*0.714,
            child: Consumer<UserProvider>(
              builder: (context,value5,child) {
                return value5.filterUserHelpLedgerList.isNotEmpty?
                  SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      border: TableBorder.all(
                        width: 1.0,
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      clipBehavior: Clip.hardEdge,
                      showBottomBorder: false,
                      showCheckboxColumn: false,
                      horizontalMargin: 1,
                      dividerThickness: 1,

                      dataRowColor: MaterialStateColor.resolveWith(
                              (states) => myWhite),
                      headingRowHeight: 50,
                      dataRowHeight: 50,
                      headingRowColor: MaterialStateColor.resolveWith(
                              (states) => clCADEFC),
                        columnSpacing: 5,
                      columns: const [
                        DataColumn(
                          label: SizedBox(
                            width: 40,
                            child: Padding(
                              padding: EdgeInsets.only(left: 13.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('SL\nNO.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          tooltip: 'SL\nNO.',
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 140,
                            child: Center(
                              child: Text('Date',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          tooltip: 'Date',
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 220,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('User',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          tooltip: 'User',
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 150,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('Give Help',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          tooltip: 'Give Help',
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 150,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('Help Received',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          tooltip: 'Help Received',
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 150,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('Tree',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          tooltip: 'Tree',
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 150,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('Payment Type',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          tooltip: 'Payment Type',
                        ),
                      ],
                     rows:
                     value5.filterUserHelpLedgerList.map((data) {
                        index = rollNumber++;
                       return
                DataRow(cells: [
                DataCell(Center(child: Text(((value5.filterUserHelpLedgerList.indexOf(data) + 1).toString())),),),
                // DataCell(Center(child: Text(DateFormat('d/MM/yyyy').format(data.date)))),
                DataCell(Center(child: Text(data.date))),
                DataCell(Center(child: Text(data.name))),
                DataCell(Center(child: Text(data.fromAmount))),
                DataCell(Center(child: Text(data.toAmount.toString()))),
                DataCell(Center(child: Text(data.tree.toString()))),
                DataCell(Center(child: data.fromAmount=="-"? const Text("Help Received"):const Text("Help Given"))),
                ],
                  );
                  }).toList(),
                ))):const Center(
                  child: Text("No data Found !!!",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                );
              }
            ),
          ),

    ])
    );
  }
}
