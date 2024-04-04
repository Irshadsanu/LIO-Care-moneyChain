import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lio_care/Constants/functions.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/my_colors.dart';
import '../../models/paymentReportModelClass.dart';



class PaymentReportScreen extends StatelessWidget {
  const PaymentReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = '';
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
            'Payment Report',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: SizedBox(
                width: width, 
                height: 50,
                child: Card(color: const Color(0xFFFFFCF8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                  child: Consumer<UserProvider>(
                    builder: (context,val42,child) {
                      return TextField(
                        textAlign: TextAlign.start,
                        onChanged: (value) {
                         val42.filteruserPaymentReportSeach(value);
                        },
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Colors.black54,
                            fontFamily: "PoppinsMedium",
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(27)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(27)),
                          ),
                        ),
                      );
                    }
                  ),
                ),
              ),
            ),
            Consumer<UserProvider>(builder: (context, value, child) {
              return SizedBox(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemCount:value.reportDateList.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<PaymentReportModel> filteredTransactions = value.filterPaymentReportList.where((element)
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
                      return  filteredTransactions.isNotEmpty
                          ? Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20,bottom: 6,top: 5),
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
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                physics: const ScrollPhysics(),
                                itemCount: filteredTransactions.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  var item=filteredTransactions[index];
                                  return Container(
                                    color: bxkclr,
                                    margin:const EdgeInsets.symmetric(vertical: 10) ,
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.grey.shade100,
                                          child: Transform.rotate(
                                              angle: item.status=='SUCCESS'? 0.785398 : 3.92699,
                                              child: Icon(
                                                Icons.arrow_upward_rounded,
                                                color:item.status=='SUCCESS' ?   cl00AD07:clFF731D,
                                              )),
                                        ),
                                        SizedBox(
                                          width: width / 2.9,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                               item.paymentType,
                                                style: TextStyle(
                                                    color:
                                                   item.status== "FAILED" ? clFF731D : cl00AD07,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10,
                                                    fontFamily: "PoppinsRegular"),
                                              ),
                                              item.grade!=""
                                                  ?Text(
                                                item.grade,
                                                style: const TextStyle(
                                                    fontFamily: "PoppinsRegular",
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 10),
                                              ):const SizedBox(),
                                               Text(
                                                item.tree,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "PoppinsRegular",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                              //  Text(
                                              //   "ID:${item.id}",
                                              //   style: const TextStyle(
                                              //       fontWeight: FontWeight.w300,
                                              //       fontSize: 10,
                                              //       fontFamily: "PoppinsRegular"),
                                              // ),

                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: width / 2.9,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${item.paymentType} ${item.installment}",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "PoppinsRegular",
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                               Text(
                                                item.time,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),

                                              Text(
                                                item.amount.toString(),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: textColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    fontFamily: "PoppinsRegular"),
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
                                }),
                          ],
                        ),
                      )
                          :const SizedBox();
                    }
                ),

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

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

Widget buildSectionWithTitle(String title, item) {
  return Column(
    children: [
      ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}


Widget _createGroupHeader(Element element) {
  return SizedBox(
    height: 40,
    child: Align(
      child: Container(
        width: 120,
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            DateFormat.yMMMd().format(element.date),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}

class Element implements Comparable {
  DateTime date;
  String name;
  bool sender = false;

  Element(this.date, this.name, [this.sender = false]);

  @override
  int compareTo(other) {
    return date.compareTo(other.dateTime);
  }
}
