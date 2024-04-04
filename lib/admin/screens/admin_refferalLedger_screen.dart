import 'package:flutter/material.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:provider/provider.dart';

import '../../Constants/functions.dart';
import '../../constants/my_colors.dart';
import 'admin_homeScreen.dart';
import 'admin_menu_screen.dart';

class ReferralLedger extends StatelessWidget {
  const ReferralLedger({Key? key}) : super(key: key);

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

        elevation: 0,
        title: const Text("Referral Income  "),
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
            children: [
              SizedBox(
                height: 50,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: Consumer<AdminProvider>(
                    builder: (context,value1,child) {
                      return TextFormField(
                        cursorColor: Colors.black54,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: "Search...",
                            suffixIcon: const Icon(Icons.search_rounded,
                                color: cBlack, size: 30),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(200)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(200)))),
                        onChanged: (text){
                         value1. filterFetchReferralLedger(text);
                        },
                      );
                    }
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: width / 45),
                    child: Consumer<AdminProvider>(
                      builder: (context,val,child) {
                        return InkWell(
                          onTap: (){
                            val.showCalendarDialog(context,"REFERRAL_LEDGER");

                          },
                          child: Container(
                            height: width / 15,
                            width: width / 4.5,
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
                        );
                      }
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: width / 45),
                    child: Consumer<AdminProvider>(
                      builder: (context,value3,child) {
                        return InkWell(
                          onTap: (){
                            value3.createExcelReferralLedgerReport(value3.filterAdminReferralList);
                          },
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration: const ShapeDecoration(
                                shape: StadiumBorder(), color: clF4F6F8),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Excel"),
                                Icon(Icons.arrow_downward_outlined),
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: width / 56.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Consumer<AdminProvider>(
                      builder: (context,value2,child) {
                        return value2.filterAdminReferralList.isNotEmpty?DataTable(
                          border: TableBorder.all(
                            width: 1.0,
                            color: cWhite,
                            borderRadius: BorderRadius.circular(25),
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
                                width: 140,
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
                                width: 140,
                                child: Center(
                                  child: Text('Name',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                              tooltip: 'Name',
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 220,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text('Phone Number',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                              tooltip: 'Phone Number',
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 150,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text('From Id',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                              tooltip: 'From Id',
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 150,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text('To Id',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                              tooltip: 'To Id',
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 150,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text('Payment Time',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                              tooltip: 'Payment Time',
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 150,
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
                          rows: value2.filterAdminReferralList
                              .map((e) => DataRow(
                            cells: <DataCell>[
                              DataCell(Center(child: Text( (value2.filterAdminReferralList.indexOf(e) + 1).toString(),))),
                              DataCell(Center(child: Text(e.transactionID))),
                              DataCell(Center(child: Text(e.fromName))),
                                DataCell(Center(child: Text(e.fromNumber))),
                              DataCell(Center(child: Text(e.fromId))),

                              DataCell(Center(child: Text(e.toId))),
                                DataCell(Center(child: Text(e.paymentTimeDateTimeString))),
                                DataCell(Center(child: Text(e.amount, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),),),
                            ],
                          )).toList()):SizedBox(
                          height: height*.5,
                          child: const Center(
                            child: Text("No Data Found !!!",style: TextStyle(fontWeight: FontWeight.w500),),
                          ),
                        );
                      }
                    ),
                ),

                )),
            ],
          ),
        ),
      ),
    );
  }
}
