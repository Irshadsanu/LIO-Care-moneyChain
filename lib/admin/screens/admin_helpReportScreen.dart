import 'package:flutter/material.dart';
import 'package:lio_care/Constants/functions.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/my_colors.dart';
import 'admin_homeScreen.dart';
import 'admin_menu_screen.dart';

class HelpReport extends StatelessWidget {
  const HelpReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: clFFFCF8,
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
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const CircleAvatar(
                backgroundColor:  Colors.transparent,
                radius: 20,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(Icons.menu),
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


        elevation: 0,
        title: const Text("Help Report "),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: cWhite,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(left: width / 22.5, right: width / 22.5, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<AdminProvider>(
                builder: (context,value,child) {
                  return SizedBox(
                    height: 50,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: TextFormField(
                        cursorColor: Colors.black54,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "Search...",
                            suffixIcon: Icon(Icons.search_rounded,
                                color: cBlack, size: 30),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(200)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(200)))),
                        onChanged: (text){
                         value.filterHelpReport(text);
                        },
                      ),
                    ),
                  );
                }
              ),
              Consumer<AdminProvider>(
                builder: (context,value1,child) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: InkWell(
                      onTap: (){
                        value1.showCalendarDialog(context,"HELP_REPORT");

                      },
                      child: Container(
                        height:30,
                        width: width / 4,
                        decoration: const ShapeDecoration(
                            shape: StadiumBorder(), color: clF4F6F8),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Date"),
                            Icon(Icons.keyboard_arrow_down_outlined),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              ),
              Padding(
                padding: const EdgeInsets.only(top:15),
                child: Consumer<AdminProvider>(
                  builder: (context,value2,child) {
                    return value2.filterAdminHelpReport.isNotEmpty?

                      SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(

                        border: TableBorder.all(
                          width: 1.0,
                          color: cWhite,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.hardEdge,
                        showBottomBorder: false,
                        showCheckboxColumn: false,
                        horizontalMargin: 1,
                        dividerThickness: 1,
                        dataRowColor:
                            MaterialStateColor.resolveWith((states) => myWhite),
                        headingRowHeight: 50,
                        dataRowHeight: 50,
                        headingRowColor:
                            MaterialStateColor.resolveWith((states) => clCADEFC),
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
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            tooltip: 'SL\nNO.',
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 150,
                              child: Center(
                                child: Text('Transaction Id',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            tooltip: 'Transaction Id',
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 230,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('From Name',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            tooltip: 'From Name',
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 220,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('From Number',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            tooltip: 'From Number',
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 230,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('To Name',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            tooltip: 'To Name',
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 150,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('To Number',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            tooltip: 'To Number',
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 170,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Payment Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            tooltip: 'Payment Date',
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 170,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Payment Type',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            tooltip: 'Payment Type',
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 170,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Tree',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            tooltip: 'Tree',
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 160,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Amount',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            tooltip: 'Amount',
                          ),
                        ],
                        rows:value2.filterAdminHelpReport
                            .map((e) => DataRow(
                          cells: <DataCell>[
                              DataCell(Center(child: Text( (value2.filterAdminHelpReport.indexOf(e) + 1).toString(),))),
                              DataCell(Center(child: Text(e.transactionID))),
                              DataCell(Center(child: Text(e.fromName))),
                              DataCell(Center(child: Text(e.fromNumber))),
                              DataCell(Center(child: Text(e.toName))),
                              DataCell(Center(child: Text(e.toNumber))),
                              DataCell(Center(child: Text(e.paymentDate))),
                              DataCell(Center(child: Text(e.tree=="MASTER_CLUB"?e.paymentType:"HELP"))),
                              DataCell(Center(child: Text(e.tree))),
                              DataCell(
                                Center(
                                  child: Text(
                                    e.amount,
                                  ),
                                ),
                              ),
                            ],
                        )).toList()),
                ):SizedBox(
                      height: height*.45,
                      child: const Center(
                        child: Text("No Data Found !!!",style: TextStyle(fontWeight: FontWeight.w500),),
                      ),
                    );
                  }
                ),
              ),
              const SizedBox(height: 15,),
              Consumer<AdminProvider>(
                  builder: (context5,value,child) {
                    return
                      value.adminGiveHelpList.isEmpty||
                      // value.adminGiveHelpList.length<value.limit||
                      double.parse(value.giveHelpCount)==value.adminGiveHelpList.length
                      ?const SizedBox():Center(
                          child: InkWell(
                            onTap: () {
                              value.fetchAdminHelpReport(false,value.filterAdminHelpReport[value.filterAdminHelpReport.length - 1].paymentDateTime);

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

              const SizedBox(height: 15,),

            ],
          ),
        ),
      ),
    );
  }
}
