import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Provider/admin_provider.dart';
import '../../constants/functions.dart';
import '../../constants/my_colors.dart';
import '../../models/admin_trasnaction_historyModelClass.dart';
import 'admin_menu_screen.dart';

class AdminTransactionHistory extends StatelessWidget {
  const AdminTransactionHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider =
    Provider.of<AdminProvider>(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String formattedDate='';



    return WillPopScope(
      onWillPop: ()async {
        // adminProvider.fetchTransactionHistory('',true);
        return true;
      },
      child: Scaffold( endDrawer: Drawer(
        width: width,
        child: const AdminMenuScreen(),
      ),
        appBar: AppBar(
          elevation: 0,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 20,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(Icons.menu,color: Colors.white,),
                  ),
                ),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
            const SizedBox(
              width : 20,
            ),
          ],
          leadingWidth: 25,
          toolbarHeight: 65,
          leading: IconButton(
            onPressed: () {finish(context);},
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
          ),
          title: const Text("Transaction History "),
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xffFFFCF8),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
                colors: [
                  cl001969,cl005BBB
                  ,
                ],
              ),
            ),
          ),
        ),
        body: Consumer<AdminProvider>(
          builder: (context,value,child) {
          // value.transcation_HistoryList.sort((b, a) => a.paymentTime.compareTo(b.paymentTime));

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                    child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child:TextFormField(
                          cursorColor: Colors.black54,
                          controller: value.searchTransactionCT,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10),
                              hintText: "Search...",
                              suffixIcon: const Icon(Icons.search_sharp,
                                  color: cBlack, size: 30),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(200)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(200)))),
                          onChanged: (text){
                            value.searcTransaction(text);

                          },
                        ),

                    ),

                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16,left: 25),
                        child: Consumer<AdminProvider>(
                            builder: (context,val20,child) {
                              return InkWell(
                                onTap: (){
                                  val20.showCalendarDialog(context,"Transaction");
                                },
                                child:val20.showSelectedDate!=""
                                    ? Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 200,
                                  decoration: const ShapeDecoration(
                                      shape: StadiumBorder(),
                                      color: clF4F6F8
                                  ),
                                  child: Text(val20.showSelectedDate),)
                                    : Container(
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
                    ],
                  ),

   //    SizedBox(
   //      width: 500,
   //      child:
   //      ListView.builder(
   //          shrinkWrap: true,
   //          scrollDirection: Axis.vertical,
   //          physics: const BouncingScrollPhysics(),
   //          itemCount: value.transcation_HistoryList.length,
   //          itemBuilder: (BuildContext context, int index) {
   //            AdminsTransactionListModel data = value.transcation_HistoryList[index];
   //            DateTime now = DateTime.now();
   //            DateTime date = data.paymentTime;
   //            if (date.year == now.year &&
   //                date.month == now.month &&
   //                date.day == now.day) {
   //              formattedDate = 'Today';
   //
   //            } else if (date.year == now.year &&
   //                date.month == now.month &&
   //                date.day == now.day - 1) {
   //              formattedDate = 'Yesterday';
   //
   //
   //            } else {
   //              formattedDate = DateFormat('d MMM, yyyy').format(date);
   // }
   //
   //            return
   //              Padding(
   //                padding: const EdgeInsets.symmetric(horizontal: 10),
   //                child: Column(
   //                    crossAxisAlignment: CrossAxisAlignment.start,
   //
   //                    children: [
   //                      Row(
   //                        children: [
   //
   //                          Spacer(),
   //                          Padding(
   //                            padding: const EdgeInsets.symmetric(horizontal: 10),
   //                            child: Text(
   //                              formattedDate,
   //
   //                              style: TextStyle(
   //                                color: Color(0xFF5E5E5E),
   //                                fontSize: 12,
   //                                fontFamily: 'Poppins',
   //                                fontWeight: FontWeight.w400,
   //                              ),
   //                            ),
   //                          ),
   //
   //                        ],
   //                      ),
   //
   //                      Container(
   //
   //                        margin: const EdgeInsets.all(10),
   //                        decoration: BoxDecoration(
   //                          color: Colors.white,
   //                          gradient:
   //                          const LinearGradient(colors: [clFFFCF8, myWhite]),
   //                          boxShadow: [
   //                            BoxShadow(
   //                              offset: const Offset(0, 2),
   //                              blurRadius: 3,
   //                              color: Colors.black.withOpacity(0.1),
   //                            ),
   //                          ],
   //                        ),
   //                        child:  Padding(
   //                          padding: EdgeInsets.only(left: 8.0),
   //                          child: Row(
   //                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
   //                            crossAxisAlignment: CrossAxisAlignment.start,
   //                            children: [
   //                              Column(
   //                                crossAxisAlignment: CrossAxisAlignment.start,
   //                                mainAxisAlignment: MainAxisAlignment.center,
   //                                children: [
   //                                  SizedBox(height: 10),
   //                                  Text(
   //                                    "LIO FOUNDATION",
   //                                    style: TextStyle(
   //                                        color: Colors.black,
   //                                        fontWeight: FontWeight.w600,
   //                                        fontSize: 16,
   //                                        fontFamily: "PoppinsRegular"),
   //                                  ),
   //                                  SizedBox(
   //                                    height: 18,
   //                                  ),
   //                                  Text(
   //                                    formattedDate,
   //                                    style: TextStyle(
   //                                        color: Colors.black,
   //                                        fontWeight: FontWeight.w500,
   //                                        fontSize: 10,
   //                                        fontFamily: "PoppinsRegular"),
   //                                  ),
   //                                  Row(
   //                                    children: [
   //                                      Text(
   //                                        "Reg.ID :",
   //                                        style: TextStyle(
   //                                            fontSize: 12,
   //                                            color: Color(0XFF5F5F5F),
   //                                            fontFamily: "PoppinsRegular",
   //                                            fontWeight: FontWeight.w400),
   //                                      ),
   //                                      Text(
   //                                        data.toUserID,
   //                                        style: TextStyle(
   //                                            fontSize: 12,
   //                                            color: Color(0XFF252525),
   //                                            fontFamily: "PoppinsMedium",
   //                                            fontWeight: FontWeight.w400),
   //                                      ),
   //                                    ],
   //                                  ),
   //                                  Row(
   //                                    children: [
   //                                      Text(
   //                                        "+91 9587 8564 25 ",
   //                                        style: TextStyle(
   //                                            color: Color(0XFF5F5F5F),
   //                                            fontFamily: "PoppinsMedium",
   //                                            fontWeight: FontWeight.w500,
   //                                            fontSize: 12),
   //                                      ),
   //                                    ],
   //                                  ),
   //                                  SizedBox(
   //                                    height: 8,
   //                                  ),
   //                                ],
   //                              ),
   //                              Padding(
   //                                padding:
   //                                EdgeInsets.only(bottom: 8.0, right: 10),
   //                                child: Column(
   //                                  crossAxisAlignment: CrossAxisAlignment.end,
   //                                  children: [
   //                                    SizedBox(
   //                                      height: 50,
   //                                    ),
   //                                    Text(
   //                                      "09:10 AM",
   //                                      style: TextStyle(
   //                                          fontWeight: FontWeight.w500,
   //                                          color: Color(0xff252525),
   //                                          fontSize: 10,
   //                                          fontFamily: "PoppinsMedium"),
   //                                    ),
   //
   //                                    Row(
   //                                      children: [
   //                                        Text(
   //                                          "Donation :",
   //                                          style: TextStyle(
   //                                              fontWeight: FontWeight.w400,
   //                                              fontSize: 10,
   //                                              color: Color(0xff5F5F5F),
   //                                              fontFamily: "PoppinsMedium"),
   //                                        ),
   //                                        Text(
   //                                          value.transcation_HistoryList[index].amount.toString(),
   //                                          style: TextStyle(
   //                                              fontWeight: FontWeight.w400,
   //                                              fontSize: 16,
   //                                              color: Color(0xff1646A2),
   //                                              fontFamily: "PoppinsMedium"),
   //                                        ),
   //                                      ],
   //                                    ),
   //                                    Text(
   //                                      'Paid',
   //                                      style: TextStyle(
   //                                          color: Color(0xff16AD00),
   //                                          fontWeight: FontWeight.w400,
   //                                          fontSize: 12),
   //                                    ),
   //
   //                                  ],
   //                                ),
   //                              )
   //                            ],
   //                          ),
   //                        ),
   //
   //
   //                      ),
   //
   //
   //
   //                    ]),
   //
   //              );
   //          },
   //
   //      ),
   //    ),
                  value.reportDateList.isNotEmpty
                  ?SizedBox(
                    width: 500,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount:value.reportDateList.length,
                        itemBuilder: (BuildContext context, int index) {
                          List<AdminsTransactionListModel> filteredTransactions = value.filter_Transcation_HistoryList.where((element)
                          => value.reportDateList[index].dateFormat==element.dateFormat).toList();
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
                            formattedDate = DateFormat('dd/MM/yyyy').format(date);
                          }
                          return  filteredTransactions.isNotEmpty? Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20,bottom: 6),
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
                                  ],
                                ),


                                  ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      physics: const ScrollPhysics(),
                                      itemCount: filteredTransactions.length,
                                      shrinkWrap: true,
                                      itemBuilder: (BuildContext context, int index) {
                                        var item=filteredTransactions[index];

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(

                                                  margin: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    gradient:
                                                    const LinearGradient(colors: [clFFFCF8, myWhite]),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        offset: const Offset(0, 2),
                                                        blurRadius: 3,
                                                        color: Colors.black.withOpacity(0.1),
                                                      ),
                                                    ],
                                                  ),
                                                  child:  Padding(
                                                    padding: const EdgeInsets.only(left: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Text(
                                                              item.username,
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
                                                                Text(
                                                                  item.grade,
                                                                  style: const TextStyle(
                                                                      fontWeight: FontWeight.w500,
                                                                      color: Color(0xff252525),
                                                                      fontSize: 10,
                                                                      fontFamily: "PoppinsMedium"),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  "Reg.ID :",
                                                                  style: TextStyle(
                                                                      fontSize: 12,
                                                                      color: Color(0XFF5F5F5F),
                                                                      fontFamily: "PoppinsRegular",
                                                                      fontWeight: FontWeight.w400),
                                                                ),
                                                                Text(
                                                                  item.id,
                                                                  style: const TextStyle(
                                                                      fontSize: 12,
                                                                      color: Color(0XFF252525),
                                                                      fontFamily: "PoppinsMedium",
                                                                      fontWeight: FontWeight.w400),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                 item.phone,
                                                                  style: const TextStyle(
                                                                      color: Color(0XFF5F5F5F),
                                                                      fontFamily: "PoppinsMedium",
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 12),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(bottom: 8.0, right: 10),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: [
                                                              const SizedBox(
                                                                height: 50,
                                                              ), Text(
                                                             DateFormat("hh:mm a").format(item.paymentTime),
                                                                style: const TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    color: Color(0xff252525),
                                                                    fontSize: 10,
                                                                    fontFamily: "PoppinsMedium"),
                                                              ),


                                                              Row(
                                                                children: [

                                                                  Text(
                                                                   "₹ ${value.transcation_HistoryList[index].amount}",
                                                                    style: const TextStyle(
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 16,
                                                                        color: Color(0xff1646A2),
                                                                        fontFamily: "PoppinsMedium"),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                item.paymentType,
                                                                style: const TextStyle(
                                                                    color: Color(0xff16AD00),
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: 12),
                                                              ),

                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        );
                                      }),
                                ],
                              ),
                            )
                                :const SizedBox();
                          }
                      ),
                    )
                  : SizedBox(
                      height: height*.5,
            child: const Center(child: Text("No Transactions Yet.")),
            ),

                  // value.transactionLoadMore||
                      value.reportDateList.isEmpty||
            value.transcation_HistoryList.isEmpty||value.filter_Transcation_HistoryList.isEmpty||
                      // value.transcation_HistoryList.length<value.limit||
                      value.transcation_HistoryList.length == value.listLength ?
                     const SizedBox():
                  Center(
                    child:  InkWell(
                      onTap: () {
                        value.fetchTransactionHistory('',false,value.filter_Transcation_HistoryList[value.filter_Transcation_HistoryList.length - 1].paymentTime);

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

                    )


                  ),
                  const SizedBox(height: 20,)



                ]));

                      }),





      ),
    );
  }
}



