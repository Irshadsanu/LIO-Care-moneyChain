import 'package:flutter/material.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:provider/provider.dart';

import '../../constants/my_colors.dart';

class HelpReceivedScreen extends StatelessWidget {
  const HelpReceivedScreen({Key? key}) : super(key: key);

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
            'Help Received',
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
            width: width,
           margin: const EdgeInsets.only(left: 20.0,right: 20,top: 10),
            padding: const EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  [
                    const Text("Total Help Received",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontFamily: "PoppinsRegular"),),
                    Text(value10.totalHelpReceivedAmount.toString(),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: width-160,
                  height: 50,
                  child: Consumer<UserProvider>(
                    builder: (context,provider,child) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        elevation: 1,
                        child: TextField(
                          textAlign: TextAlign.start,
                          onChanged: (text) {
                            provider.filterGiveHelpReceived(text);
                          },
                          decoration:
                          const InputDecoration(
                            suffixIcon: Icon(Icons.search),
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
                      );
                    }
                  ),
                ),
                Consumer<UserProvider>(
                    builder: (context,val77,child) {
                      return Container(
                          height: 42,
                          width: 120,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(val77.selectedStageDropdownItem,style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: cBlack,
                                  fontSize: 12,
                                  fontFamily: "PoppinsRegular",
                                ),),
                                const Icon(Icons.keyboard_arrow_down_rounded),
                              ],
                            ),
                            itemBuilder: (context) {
                              return val77.allStagesItems.map((String item) {
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
                            onSelected: (String? newValue) {
                              val77.allStageSelection(newValue!);
                              val77.helpReceivedGradeWiseList(newValue);
                            },
                          ));
                    }
                ),
              ],
            ),
          ),

          Consumer<UserProvider>(
            builder: (context,value2,child) {
              return  value2.filterUserHelpReceiveList.isNotEmpty? Flexible(
                fit: FlexFit.tight,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics:  const ScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,),
                    itemCount: value2.filterUserHelpReceiveList.length,
                    itemBuilder: (BuildContext context, int index) {
                     var item=value2.filterUserHelpReceiveList[index];
                      return Container(
                        // height: height / 14,
                        width: width / 3,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(13),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:   [
                             Text(
                               item.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  fontFamily: "PoppinsRegular"),
                            ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text(
                                  "ID : ${item.fromUserId}",
                                   style: const TextStyle(
                                       fontWeight: FontWeight.w400,
                                       fontSize: 12,
                                       fontFamily: "PoppinsRegular"),
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   children:  [
                                     const Text(
                                       "Status: ",
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
                                 item.number.toString(),
                                  style: TextStyle(
                                      decoration:  TextDecoration.underline,
                                      color: textColor,
                                      fontFamily: "PoppinsRegular",
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children:  [
                                    const Text(
                                      "Help Amount :",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11.2,
                                          fontFamily: "PoppinsRegular"),
                                    ),
                                    Text(
                                      item.amount.toString(),
                                      style: const TextStyle(
                                          color:Colors.black ,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          fontFamily: "PoppinsRegular"),
                                    ),
                                  ],
                                )
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
              ):const Column(
                children: [
                  SizedBox(height: 100,),
                  Center(child: Text("No data Found !!!",style: TextStyle(fontWeight: FontWeight.w600),)),
                ],
              );
            }
          ),
        ],
      ),
    );
  }
}
