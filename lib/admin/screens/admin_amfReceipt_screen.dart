import 'package:flutter/material.dart';
import 'package:lio_care/Constants/functions.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/my_colors.dart';
import '../../view/Widgets/my_widgets.dart';

class AdminAmfReceiptScreen extends StatelessWidget {
  String amount;
  String phonenumber;
  String stage;
  String regid;
  String transid;
  String date;
  String name;
  String totalamount;
   AdminAmfReceiptScreen({Key? key,required this.date,required this.amount,
     required this.phonenumber,required this.stage,required this.regid,required this.transid,
   required this.name,required this.totalamount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bxkclr,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height*0.16),
        child: AppBar(
          backgroundColor: myWhite,
          leading:InkWell(
              onTap: () {
                finish(context);
              },

              child: const Icon(Icons.arrow_back_ios,color: myWhite,)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors:[
                      cl001969,
                      cl005BBB
                    ])
            ),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Text("₹ $totalamount",
                  style: const TextStyle(fontSize: 27,color: myWhite,fontFamily: "PoppinsRegular,",fontWeight: FontWeight.w700),),
                const SizedBox(height: 10,)
              ],
            ),
          ),
          elevation: 0,
          title: Text("Lio Club",style: appbarStyle,),
          actions:  [


            SizedBox(width: 10,)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<AdminProvider>(
          builder: (context,value1,child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15,),
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Colors.white,
                      gradient: const LinearGradient(
                          colors: [
                            clFFFCF8,
                            myWhite
                          ]
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 25,),
                        Image.asset("assets/paymentSuccess.png",scale: 2,),
                        const Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: Text("Payment Successful",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                             fontFamily: "PoppinsRegular"
                          ),),
                        ),
                         Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Text("₹ $amount",
                            style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w400,
                            ),),
                        ),
                         Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0,top: 38),
                            child: Text(name,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "PoppinsRegular"
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 11.0),
                              child: Text("Stage",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "PoppinsRegular",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 11.0),
                              child: Text(stage,
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "PoppinsRegular",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),),
                            )
                          ],
                        ),
                        const SizedBox(height: 6,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 11.0),
                              child: Text("Phone Number",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "PoppinsRegular",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 11.0),
                              child: Text(phonenumber,
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "PoppinsRegular",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),),
                            )
                          ],
                        ),
                        const SizedBox(height: 6,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 11.0),
                              child: Text("Register ID",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "PoppinsRegular",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 11.0),
                              child: Text(regid,
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "PoppinsRegular",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),),
                            )
                          ],
                        ),
                        const SizedBox(height: 6,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 11.0),
                              child: Text("Transaction ID",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "PoppinsRegular",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 11.0),
                              child: Text(transid,
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "PoppinsRegular",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),),
                            )
                          ],
                        ),
                        const SizedBox(height: 6,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            const Padding(
                              padding: EdgeInsets.only(left: 11.0),
                              child: Text("Date Time",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "PoppinsRegular",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 11.0),
                              child: Text(date,
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "PoppinsRegular",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),),
                            )
                          ],
                        ),
                        const SizedBox(height: 6,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            const Padding(
                              padding: EdgeInsets.only(left: 11.0),
                              child: Text("SGST",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "PoppinsRegular",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 11.0),
                              child: Text("₹ ${value1.adminGstCalc(double.parse(amount))}",
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "PoppinsRegular",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),),
                            )
                          ],
                        ),
                        const SizedBox(height: 6,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            const Padding(
                              padding: EdgeInsets.only(left: 11.0),
                              child: Text("CGST",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "PoppinsRegular",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 11.0),
                              child: Text("₹ ${value1.adminGstCalc(double.parse(amount))}",
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "PoppinsRegular",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),),
                            )
                          ],
                        ),
                        const SizedBox(height: 6,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            const Padding(
                              padding: EdgeInsets.only(left: 11.0),
                              child: Text("Total",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "PoppinsRegular",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 11.0),
                              child: Text("₹ ${((double.parse(amount))/1.18).toStringAsFixed(2)}",
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "PoppinsRegular",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),),
                            )
                          ],
                        ),
                        const SizedBox(height: 17,)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    value1. createExcelPMCReciept(name,stage,phonenumber,regid,transid,date,amount);
                  },
                  child: Container(
                    height: 50,
                    width: 350,
                    decoration:BoxDecoration(
                      color: textColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Excel ",
                          style: TextStyle(
                              color: myWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "PoppinsRegular"
                          ),),
                        Icon(Icons.arrow_downward_outlined,color: myWhite,),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
              ],
            );
          }
        ),
      ),
    );
  }
}
