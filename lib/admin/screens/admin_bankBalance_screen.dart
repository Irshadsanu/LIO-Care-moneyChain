import 'package:flutter/material.dart';

import '../../constants/my_colors.dart';

import 'admin_menu_screen.dart';

class BankBalance extends StatelessWidget {
  const BankBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: Drawer(
        width: width,
        child: const AdminMenuScreen(),
      ),
      appBar: AppBar(

        flexibleSpace: Container(
          decoration:  const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
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
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: SizedBox(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment(-0.9, 0),
                  child: Text(
                    "Bank Balance",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: myWhite),
                  ),
                ),
                Text(
                  "₹ 2323234",
                  style: TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 27, color: cWhite),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: cWhite,
        leadingWidth: 25,
        //toolbarHeight: 100,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.transparent,
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: cWhite,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        title: Image.asset("assets/whitelogo.png",scale: 12,),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width / 19.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: width / 45),
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
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 totalCard(width: width,type: "Income",amount: 24253),
                 totalCard(width: width,type: "Debit",amount: 24253),

                ],
              ),
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                child: Text(
                  "Activity",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),

              listview(
                totalIncome: 7658,
                  totalDebit: 74685,
                  date: "Today",
                  debited: true,
                  width: width,
                  count: 3,
                  name: "swalih",
                  regNo: "gerhgrtjhtrj",
                  id: "gerhreth",
                  amount: 3478,
                  time: "75:67am"),

              listview(date: "Yeasterdy",
                  totalDebit: 11567,
                  totalIncome: 756343276,
                  debited: false,
                  width: width,
                  count: 3,
                  name: "swalih",
                  regNo: "gerhgrtjhtrj",
                  id: "gerhreth",
                  amount: 3478,
                  time: "75:67am"),listview(date: "Yeasterdy",
                  totalDebit: 11567,
                  totalIncome: 756343276,
                  debited: false,
                  width: width,
                  count: 3,
                  name: "swalih",
                  regNo: "gerhgrtjhtrj",
                  id: "gerhreth",
                  amount: 3478,
                  time: "75:67am"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget listview({
  required bool debited,
  required double width,
  required int count,
  required String name,
  required String regNo,
  required String id,
  required double amount,
  required String time,
  required String date,
  required double totalIncome,
  required double totalDebit,
}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(
            date,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(
            children: [
              Card(
                shape: const StadiumBorder(),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: width / 39,
                      right: width / 39,
                      top: width / 78,
                      bottom: width / 78),
                  child: Text(
                    "$totalIncome" ,
                    style: TextStyle(
                        color: incmIconclr,
                        fontWeight: FontWeight.w400,
                        fontSize: width / 24.37),
                  ),
                ),
              ),
              Card(
                shape: const StadiumBorder(),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: width / 39,
                      right: width / 39,
                      top: width / 78,
                      bottom: width / 78),
                  child: Text(
                    "$totalDebit",
                    style: TextStyle(
                        color:  dbtIconclr,
                        fontWeight: FontWeight.w400,
                        fontSize: width / 24.37),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: count,
        itemBuilder: (context, index) {
          return Card(
            child: SizedBox(
              height: width / 5,
              width: width / 1.11,
              child: Padding(
                padding: EdgeInsets.all(width / 48.75),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: width / 24.37, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: width / 39,
                        ),
                        CircleAvatar(
                          radius: width / 43.33,
                          backgroundColor: debited == true
                              ?  dbtIconclr
                              : incmIconclr,
                          child: Transform.rotate(
                            angle: debited == true
                                ? 180 * 3.14 / 220
                                : 180 * 3.14 / 100,
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_sharp,
                                color: cWhite,
                                size: width / 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          id,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: width / 32.5,
                              color:  const Color(0xff252525)),
                        ),
                        Text(
                          debited == true ? "-₹$amount" : "+₹$amount",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: width / 24.3,
                            color: debited == true
                                ? dbtIconclr
                                :  incmIconclr,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Reg. No :",
                              style: TextStyle(
                                  fontSize: width / 32.5,
                                  fontWeight: FontWeight.w400,
                                  color:  const Color(0xff5F5F5F)),
                            ),
                            Text(
                              regNo,
                              style: TextStyle(
                                  fontSize: width / 32.5,
                                  fontWeight: FontWeight.w400,
                                  color: cBlack),
                            ),
                          ],
                        ),
                        Text(
                          " $time",
                          style: TextStyle(
                              fontSize: width / 39,
                              fontWeight: FontWeight.w500,
                              color: cBlack),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ],
  );
}
Widget totalCard({required double width,
required String type,
required double amount}){
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)),
    child: SizedBox(
      height: width / 5,
      width: width / 2.5,
      child: Padding(
        padding: EdgeInsets.all(width / 27.85),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type,
              style: TextStyle(
                fontSize: width / 24.3,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: width / 43.33,
                  backgroundColor:type=="Income"? incmIconclr: dbtIconclr,
                  child: Transform.rotate(
                    angle: type=="Income"?180 * 3.14 / 100:180 * 3.14 / 220,
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_sharp,
                        color: cWhite,
                        size: width / 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width / 48.75,
                ),
                Text(
                  "₹ + $amount",
                  style: TextStyle(
                      color:type=="Income"?  incmIconclr:dbtIconclr,
                      fontSize: width / 39,
                      fontWeight: FontWeight.w400),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}