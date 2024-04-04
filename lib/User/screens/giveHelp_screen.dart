import 'package:flutter/material.dart';
import 'package:lio_care/Constants/functions.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/my_colors.dart';

class GiveHelpScreen extends StatelessWidget {

  const GiveHelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bxkclr,
      appBar: AppBar(
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
            'Give Help',
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              margin:const EdgeInsets.only(left: 20.0,right: 20,top: 10,bottom: 10) ,
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
                      children:  [
                        const Text("Total Help",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              fontFamily: "PoppinsRegular"),),
                        Text(value10.totalGiveHelpAmount.toString(),
                          style: const TextStyle(
                              color: cl16B200,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              fontFamily: "PoppinsRegular"),),
                      ],
                    );
                  }
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width - 140,
                    height: 50,
                    child: Consumer<UserProvider>(
                        builder: (context,value3,child) {
                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
                            elevation: 0.5,
                            child: TextField(
                              textAlign: TextAlign.start,
                              onChanged: (text) {
                                value3.filterGiveHelp(text);
                              },
                              decoration: InputDecoration(
                                hintText: "Search",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontFamily: "PoppinsMedium",
                                ),
                                suffixIcon: const Icon(Icons.search),
                                contentPadding: const EdgeInsets.symmetric(vertical: 2,horizontal: 15),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(Radius.circular(27)),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(Radius.circular(27)),
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                  Consumer<UserProvider>(
                      builder: (context,val90,child) {
                        return Container(
                            height: 42,
                            width: width/3.55,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x0C000000),
                                  blurRadius: 6,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: PopupMenuButton<String>(
                              icon: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(val90.selectedStageDropdownItem,style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: cBlack,
                                    fontSize: 12,
                                    fontFamily: "PoppinsRegular",
                                  ),),
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                                ],
                              ),
                              itemBuilder: (context) {
                                return val90.allStagesItems.map((String item) {
                                  return PopupMenuItem<String>(
                                    value: item,
                                    child: Text(item,style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: cBlack,
                                      fontSize: 12,
                                      fontFamily: "PoppinsRegular",
                                    ),),
                                  );
                                }).toList();
                              },
                              onSelected: (String newValue) {
                                val90.allStageSelection(newValue);
                                val90.giveHelpGradeWiseList(newValue);
                              },
                            ));
                      }),
                ]),
            Consumer<UserProvider>(
                builder: (context,value1,child) {
                  return value1.filterUserGiveHelpList.isNotEmpty?

                  Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,),
                        itemCount: value1.filterUserGiveHelpList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var item= value1.filterUserGiveHelpList[index];
                          return Container(
                            // height: height / 14,
                            width: width / 3,
                            padding: const EdgeInsets.all(13),
                            margin: const EdgeInsets.all(10),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              gradient: LinearGradient(
                                begin: const Alignment(-0.00, -1.00),
                                end: const Alignment(0, 1),
                                colors: [Colors.white, const Color(0x00FFFCF8).withOpacity(.5)],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: const Color(0x21000000).withOpacity(.04),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:   [
                                const SizedBox(height: 10,),
                                Text(
                                  item.name,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      fontFamily: "PoppinsRegular"),
                                ),

                                const SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.fromUserId,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          fontFamily: "PoppinsRegular"),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children:  [
                                        const Text(
                                          " Status: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              fontFamily: "PoppinsRegular"),
                                        ),
                                        Text(
                                          item.status=='SUCCESS'?'Paid':'',
                                          style: const TextStyle(
                                              color:cl16B200 ,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              fontFamily: "PoppinsRegular"),
                                        ),
                                      ],
                                    )
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.number,
                                      style: TextStyle(
                                          decoration:  TextDecoration.underline,
                                          color: textColor,
                                          fontFamily: "PoppinsRegular",
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children:  [
                                        const Text(
                                          "Help Amount : ",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              fontFamily: "PoppinsRegular"),
                                        ),
                                        Text(
                                          "₹ ${item.amount}",
                                          style: const TextStyle(
                                              color:Colors.black ,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              fontFamily: "PoppinsRegular"),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(item.tree,style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        fontFamily: "PoppinsRegular"),),
                                     Text(
                                      item.grade,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          fontFamily: "PoppinsRegular"),
                                    ),

                                  ],
                                ),


                              ],
                            ),
                          );
                        }),
                  ):const Center(child: Padding(
                    padding: EdgeInsets.only(top: 120),
                    child: Text("No data Found !!!",style: TextStyle(fontWeight: FontWeight.w600),),
                  ),);
                }
            ),
          ],
        ),
      ),
    );
  }






}