import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Provider/user_provider.dart';
import '../../constants/my_colors.dart';
import '../../models/distributionModel.dart';

class PmcAndPtcfScreen extends StatelessWidget {
   PmcAndPtcfScreen({Key? key}) : super(key: key);
    TabController? controller;
  @override

  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      initialIndex: 0,  //optional, starts from 0, select the tab by default
      length:2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          backgroundColor: bxkclr,
          leadingWidth: 100,
          leading:InkWell(
            onTap: (){
              finish(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              const Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(CupertinoIcons.back),
              ),
              Image.asset(
                'assets/bluelogo.png',
                scale: 18,
              ),
            ],),
          ),
          bottom: TabBar(
            controller: controller,
            unselectedLabelColor: cl2F7DC1,
            indicatorColor: bxkclr,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Creates border
                color: cl2F7DC1),
            dividerColor:  Colors.transparent,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: clF3F3F3,
            onTap: (index){

            },
            tabs: [

              Tab(
                child: Container(
                  width: width / 1,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: cl2F7DC1,
                        width: 1,
                      )),
                  child: const Text("PMC"),
                ),
              ),
              Tab(
                child: Container(
                  width: width / 1,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: cl2F7DC1, width: 1)),
                  child: const Text("CMF"),
                ),
              ),

            ],
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: [

            Consumer<UserProvider>(builder: (context6, val565, child) {
              return Column(
                children: [
                  const SizedBox(height: 10,),
                  Flexible(
                    fit: FlexFit.tight,
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                        physics: const ScrollPhysics(),
                        itemCount: val565.totalPmcList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context,int index1) {
                          var gradeItem= val565.totalPmcList[index1];
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: 50,
                                      width: width*.9,
                                      color: Colors.yellow,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(gradeItem.item),
                                          InkWell(
                                              onTap: (){
if(val565.hidePmcBool){

  val565.filterPmc(gradeItem.item,index1);
}else{

  val565.hideFilterPmc(index1);
}
                                              },
                                              child:  SizedBox(
                                                  width: 80,
                                                  child: Icon(gradeItem.select?Icons.expand_less:Icons.expand_more, size: 30,)))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              !gradeItem.select?const SizedBox(): Row(
                                children: [

                                  Flexible(
                                    fit: FlexFit.tight,
                                    child:  Consumer<UserProvider>(builder: (context, val566, child) {
                                      return  ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: val566.sortStatusDistributionList.length,
                                          padding: const EdgeInsets.only(left: 10,right: 10),
                                          physics: const ScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (BuildContext context,int index) {
                                            DistributionModel item = val565.sortStatusDistributionList[index];
                                            return Container(
                                              width: width / 1.1,
                                              clipBehavior: Clip.antiAlias,
                                              margin: const EdgeInsets.only(top: 0,bottom: 5),
                                              decoration: BoxDecoration(color: bck),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor: bck,
                                                    child: Image.asset(
                                                        "assets/bluelogo.png",
                                                        fit: BoxFit.fill),
                                                  ),

                                                  SizedBox(
                                                    width: width / 2.3,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,

                                                      children: [
                                                        Text(
                                                          item.type,
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 14),
                                                        ),
                                                        Text(

                                                          item.tree,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              fontSize: 10),
                                                        ),
                                                        Text(
                                                          item.fromGrade,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              fontSize: 10),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width / 3.2,
                                                    child:
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        children: [
                                                          Text(item.status,
                                                              style: TextStyle(
                                                                  color: item.status !=
                                                                      "PAID"
                                                                      ? clFFA500
                                                                      : cl16B200)),
                                                          Text(
                                                            "₹${item.amount}",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                FontWeight.w600,
                                                                fontSize: 12),
                                                          ),

                                                          const SizedBox(),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                      );
                                    }
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                      }
                    ),
                  ),


                ],
              );
            }
          ),


Column(
  children: [
    Flexible(
      fit: FlexFit.tight,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          padding: const EdgeInsets.only(left: 15,right: 15),
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context,int index) {
            return Container(
              width: width / 1.1,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: bck),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: bck,
                    child: Image.asset(
                        "assets/bluelogo.png",
                        fit: BoxFit.fill),
                  ),
                  SizedBox(
                    width: width / 2.3,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Type",
                          style: const TextStyle(
                              fontWeight:
                              FontWeight.w600,
                              fontSize: 14),
                        ),
                        Text(
                          "_TREE",
                          style: const TextStyle(
                              fontWeight:
                              FontWeight.w500,
                              fontSize: 10),
                        ),
                        Text(
                          "Grade",
                          style: const TextStyle(
                              fontWeight:
                              FontWeight.w400,
                              fontSize: 10),
                        ),
                        // Text(
                        //   item.tree,
                        //   style: const TextStyle(
                        //       fontWeight: FontWeight.w400,
                        //       fontSize: 10),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width / 3.2,
                    child: Padding(
                      padding:
                      const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.end,
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                        children: [
                          Text("Status",
                              style: TextStyle(
                                  color:
                                  // item.status !=
                                  //     "PAID"
                                  //     ? clFFA500
                                  //     :
                                  cl16B200)),
                          Text(
                            "₹200",
                            style: const TextStyle(
                                fontWeight:
                                FontWeight.w600,
                                fontSize: 12),
                          ),
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    ),
  ],
)

          ],
        ),
      ),
    );
  }
}
