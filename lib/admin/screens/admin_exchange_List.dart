import 'package:flutter/material.dart';
import 'package:lio_care/models/exchangeModel.dart';
import 'package:provider/provider.dart';

import '../../Constants/functions.dart';
import '../../Provider/admin_provider.dart';
import '../../constants/my_colors.dart';
import 'admin_exchangeUser_screen.dart';
import 'admin_exchange_approve_Screen.dart';
import 'admin_homeScreen.dart';
import 'admin_menu_screen.dart';

class ExchangeUserList extends StatelessWidget {
  const ExchangeUserList({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () =>  callNextReplacement(const AdminHomeScreen(), context),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          endDrawer: Drawer(
            width: MediaQuery.of(context).size.width,
            child: const AdminMenuScreen(),
          ),
          backgroundColor: bxkclr,
          resizeToAvoidBottomInset: false,
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
                      child: Icon(
                        Icons.menu,
                        color: cWhite,
                      ),
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
            toolbarHeight: 65,
            leadingWidth: 30,
            leading: InkWell(
              onTap: () {
                callNextReplacement(const AdminHomeScreen(), context);
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: myWhite,
                ),
              ),
            ),
            title: Image.asset(
              "assets/whitelogo.png",
              scale: 12,
            ),
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
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton:
              Consumer<AdminProvider>(builder: (context, val5, child) {
            return InkWell(
              onTap: () {
                val5.clearAllExchangeControllers();
                val5.exchangeOtherCheck = false;
                val5.fileImage = null;
                val5.selectedExchange = '';
                callNext(ExchangeUserScreen(), context);
              },
              child: Container(
                width: 250,
                height: 40,
                padding:
                    const EdgeInsets.only(top: 9, left: 27, right: 28, bottom: 8),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFF2F7DC1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(61.71),
                  ),
                ),
                child: const Text(
                  'User Exchange',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            );
          }),
          body: SizedBox(
            // height: height / 1.238872403560831,
            height: height / 1.3,
            child: Column(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Consumer<AdminProvider>(
                      builder: (context, val, child) {
                        return ListView.builder(
                            itemCount:
                            val.filterApprovedExchangeUsers.length,
                            itemBuilder: (context, index) {
                              ExchangeModel item =
                              val.filterApprovedExchangeUsers[index];
                              return InkWell(
                                onTap: () {
                                  // val.exchangeUserName(item.fromId,item.toId);

                                  callNext(
                                      ExchangeApproveScreen(
                                          from:"APPROVED",
                                          docId: item.docId,
                                          apId: item.apId,
                                          apName: item.apName,
                                          apPhone:item. apPhone,
                                          apTime:item. apTime,
                                          reqId: item.reqId,
                                          reqName:item. reqName,
                                          reqPhone:item. reqPhone,
                                          reqTime: item.reqTime,
                                          proofImage:item. proofImage,
                                          fromId:item. fromId,
                                          fromName:item. fromName,
                                          fromNumber:item. fromNumber,
                                          toId: item.toId,
                                          toName: item.toName,
                                          toNumber: item.toNumber,
                                          reason:item. reason,
                                          status:item. status),
                                      context);

                                },
                                child: Container(
                                  height: 110,
                                  margin: const EdgeInsets.fromLTRB(
                                      15, 0, 15, 10),
                                  padding: const EdgeInsets.all(10),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(0.00, -1.00),
                                      end: Alignment(0, 1),
                                      colors: [
                                        Color(0xFFFFFCF8),
                                        Colors.white
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x11000000),
                                        blurRadius: 8,
                                        offset: Offset(2, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              child: Text(
                                                item.apName,
                                                overflow:
                                                TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Color(0xFF252525),
                                                  fontSize: 16,
                                                  fontFamily:
                                                  'PoppinsRegular',
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  letterSpacing: 0.32,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              item.apTime,
                                              style: const TextStyle(
                                                color: Color(0xFF252525),
                                                fontSize: 10,
                                                fontFamily:
                                                'PoppinsRegular',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.20,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Opacity(
                                        opacity: 0.80,
                                        child: Text(
                                          "Reg.No : ${item.apId}",
                                          style: const TextStyle(
                                            color: Color(0xFF252525),
                                            fontSize: 12,
                                            fontFamily: 'PoppinsRegular',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.24,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                item.fromName,
                                                style: const TextStyle(
                                                  color: Color(0xFF252525),
                                                  fontSize: 12,
                                                  fontFamily: 'PoppinsRegular',
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.24,
                                                ),
                                              )),
                                          const Opacity(
                                            opacity: 0.80,
                                            child: Text(
                                              'To',
                                              style: TextStyle(
                                                color: Color(0xFF252525),
                                                fontSize: 12,
                                                fontFamily:
                                                'PoppinsRegular',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.24,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              child: Align(
                                                  alignment:
                                                  Alignment.centerRight,
                                                  child: Text(
                                                    item.toName,
                                                    style: const TextStyle(
                                                      color:
                                                      Color(0xFF252525),
                                                      fontSize: 12,
                                                      fontFamily:
                                                      'PoppinsRegular',
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      letterSpacing: 0.24,
                                                    ),
                                                  )))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                )
              ],
            ),
          )
          // Column(
          //   children: [
          //     const SizedBox(
          //       height: 9,
          //     ),
          //     Consumer<AdminProvider>(builder: (context, val1, child) {
          //       return TabBar(
          //         onTap: (index) {
          //           if (index == 0) {
          //             val1.filterForExchangeAppList();
          //           } else {
          //             val1.filterForExchangeReqList();
          //           }
          //         },
          //         unselectedLabelColor: cl2F7DC1,
          //         indicatorColor: bxkclr,
          //         labelColor: Colors.white,
          //         indicator: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10),
          //             // Creates border
          //             color: cl2F7DC1),
          //         dividerColor: Colors.transparent,
          //         indicatorSize: TabBarIndicatorSize.label,
          //         tabs: [
          //           Tab(
          //             child: Container(
          //               width: width / 1,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(10),
          //                   border: Border.all(color: cl2F7DC1, width: 1)),
          //               child: const Text("Exchange List"),
          //             ),
          //           ),
          //           Tab(
          //             child: Container(
          //               width: width / 1,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(10),
          //                   border: Border.all(
          //                     color: cl2F7DC1,
          //                     width: 1,
          //                   )),
          //               child: const Text("Request"),
          //             ),
          //           ),
          //         ],
          //       );
          //     }),
          //     const SizedBox(
          //       height: 10,
          //     ),
          //     SizedBox(
          //       // height: height / 1.238872403560831,
          //       height: height / 1.3,
          //       child: TabBarView(
          //           physics: const NeverScrollableScrollPhysics(),
          //           children: [
          //             Column(
          //               children: [
          //                 Flexible(
          //                   fit: FlexFit.tight,
          //                   child: Consumer<AdminProvider>(
          //                       builder: (context, val, child) {
          //                         return ListView.builder(
          //                             itemCount:
          //                             val.filterApprovedExchangeUsers.length,
          //                             itemBuilder: (context, index) {
          //                               ExchangeModel item =
          //                               val.filterApprovedExchangeUsers[index];
          //                               return InkWell(
          //                                 onTap: () {
          //                                   val.exchangeUserName(item.fromId,item.toId);
          //
          //                                   callNext(
          //                                       ExchangeApproveScreen(
          //                                           from:"APPROVED",
          //                                           docId: item.docId,
          //                                           apId: item.apId,
          //                                           apName: item.apName,
          //                                           apPhone:item. apPhone,
          //                                           apTime:item. apTime,
          //                                           reqId: item.reqId,
          //                                           reqName:item. reqName,
          //                                           reqPhone:item. reqPhone,
          //                                           reqTime: item.reqTime,
          //                                           proofImage:item. proofImage,
          //                                           fromId:item. fromId,
          //                                           toId: item.toId,
          //                                           reason:item. reason,
          //                                           status:item. status),
          //                                       context);
          //
          //                                 },
          //                                 child: Container(
          //                                   height: 86,
          //                                   margin: const EdgeInsets.fromLTRB(
          //                                       15, 0, 15, 10),
          //                                   padding: const EdgeInsets.all(10),
          //                                   clipBehavior: Clip.antiAlias,
          //                                   decoration: const BoxDecoration(
          //                                     gradient: LinearGradient(
          //                                       begin: Alignment(0.00, -1.00),
          //                                       end: Alignment(0, 1),
          //                                       colors: [
          //                                         Color(0xFFFFFCF8),
          //                                         Colors.white
          //                                       ],
          //                                     ),
          //                                     boxShadow: [
          //                                       BoxShadow(
          //                                         color: Color(0x11000000),
          //                                         blurRadius: 8,
          //                                         offset: Offset(2, 4),
          //                                         spreadRadius: 0,
          //                                       )
          //                                     ],
          //                                   ),
          //                                   child: Column(
          //                                     mainAxisAlignment:
          //                                     MainAxisAlignment.start,
          //                                     crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                     children: [
          //                                       Row(
          //                                         children: [
          //                                           Expanded(
          //                                             child: SizedBox(
          //                                               child: Text(
          //                                                 item.apName,
          //                                                 overflow:
          //                                                 TextOverflow.ellipsis,
          //                                                 style: const TextStyle(
          //                                                   color: Color(0xFF252525),
          //                                                   fontSize: 16,
          //                                                   fontFamily:
          //                                                   'PoppinsRegular',
          //                                                   fontWeight:
          //                                                   FontWeight.w600,
          //                                                   letterSpacing: 0.32,
          //                                                 ),
          //                                               ),
          //                                             ),
          //                                           ),
          //                                           Align(
          //                                             alignment: Alignment.topRight,
          //                                             child: Text(
          //                                               item.apTime,
          //                                               style: const TextStyle(
          //                                                 color: Color(0xFF252525),
          //                                                 fontSize: 10,
          //                                                 fontFamily:
          //                                                 'PoppinsRegular',
          //                                                 fontWeight: FontWeight.w400,
          //                                                 letterSpacing: 0.20,
          //                                               ),
          //                                             ),
          //                                           )
          //                                         ],
          //                                       ),
          //                                       Opacity(
          //                                         opacity: 0.80,
          //                                         child: Text(
          //                                           "Reg.No : ${item.apId}",
          //                                           style: const TextStyle(
          //                                             color: Color(0xFF252525),
          //                                             fontSize: 12,
          //                                             fontFamily: 'PoppinsRegular',
          //                                             fontWeight: FontWeight.w400,
          //                                             letterSpacing: 0.24,
          //                                           ),
          //                                         ),
          //                                       ),
          //                                       Row(
          //                                         children: [
          //                                           Expanded(
          //                                               child: Text(
          //                                                 "ID : ${item.fromId}",
          //                                                 style: const TextStyle(
          //                                                   color: Color(0xFF252525),
          //                                                   fontSize: 12,
          //                                                   fontFamily: 'PoppinsRegular',
          //                                                   fontWeight: FontWeight.w400,
          //                                                   letterSpacing: 0.24,
          //                                                 ),
          //                                               )),
          //                                           const Opacity(
          //                                             opacity: 0.80,
          //                                             child: Text(
          //                                               'To',
          //                                               style: TextStyle(
          //                                                 color: Color(0xFF252525),
          //                                                 fontSize: 12,
          //                                                 fontFamily:
          //                                                 'PoppinsRegular',
          //                                                 fontWeight: FontWeight.w400,
          //                                                 letterSpacing: 0.24,
          //                                               ),
          //                                             ),
          //                                           ),
          //                                           Expanded(
          //                                               child: Align(
          //                                                   alignment:
          //                                                   Alignment.centerRight,
          //                                                   child: Text(
          //                                                     "ID : ${item.toId}",
          //                                                     style: const TextStyle(
          //                                                       color:
          //                                                       Color(0xFF252525),
          //                                                       fontSize: 12,
          //                                                       fontFamily:
          //                                                       'PoppinsRegular',
          //                                                       fontWeight:
          //                                                       FontWeight.w400,
          //                                                       letterSpacing: 0.24,
          //                                                     ),
          //                                                   )))
          //                                         ],
          //                                       )
          //                                     ],
          //                                   ),
          //                                 ),
          //                               );
          //                             });
          //                       }),
          //                 )
          //               ],
          //             ),
          //             Column(
          //               children: [
          //                 Flexible(
          //                   fit: FlexFit.tight,
          //                   child: Consumer<AdminProvider>(
          //                       builder: (context, val, child) {
          //                     return ListView.builder(
          //                         itemCount:
          //                             val.filterApprovedExchangeUsers.length,
          //                         itemBuilder: (context, index) {
          //                           ExchangeModel item =
          //                               val.filterApprovedExchangeUsers[index];
          //                           return InkWell(
          //                             onTap: () {
          //                               val.exchangeUserName(item.fromId,item.toId);
          //                               callNext(
          //                                   ExchangeApproveScreen(
          //                                   from:"REQUEST",
          //                                       docId: item.docId,
          //                                       apId: item.apId,
          //                                       apName: item.apName,
          //                                       apPhone:item. apPhone,
          //                                       apTime:item. apTime,
          //                                       reqId: item.reqId,
          //                                       reqName:item. reqName,
          //                                       reqPhone:item. reqPhone,
          //                                       reqTime: item.reqTime,
          //                                       proofImage:item. proofImage,
          //                                       fromId:item. fromId,
          //                                       toId: item.toId,
          //                                       reason:item. reason,
          //                                       status:item. status),
          //                                   context);
          //                             },
          //                             child: Container(
          //                               height: 86,
          //                               margin: const EdgeInsets.fromLTRB(
          //                                   15, 0, 15, 10),
          //                               padding: const EdgeInsets.all(10),
          //                               clipBehavior: Clip.antiAlias,
          //                               decoration: const BoxDecoration(
          //                                 gradient: LinearGradient(
          //                                   begin: Alignment(0.00, -1.00),
          //                                   end: Alignment(0, 1),
          //                                   colors: [
          //                                     Color(0xFFFFFCF8),
          //                                     Colors.white
          //                                   ],
          //                                 ),
          //                                 boxShadow: [
          //                                   BoxShadow(
          //                                     color: Color(0x11000000),
          //                                     blurRadius: 8,
          //                                     offset: Offset(2, 4),
          //                                     spreadRadius: 0,
          //                                   )
          //                                 ],
          //                               ),
          //                               child: Column(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.start,
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 children: [
          //                                   Row(
          //                                     children: [
          //                                       Expanded(
          //                                         child: SizedBox(
          //                                           child: Text(
          //                                             item.reqName,
          //                                             overflow:
          //                                                 TextOverflow.ellipsis,
          //                                             style: const TextStyle(
          //                                               color: Color(0xFF252525),
          //                                               fontSize: 16,
          //                                               fontFamily:
          //                                                   'PoppinsRegular',
          //                                               fontWeight:
          //                                                   FontWeight.w600,
          //                                               letterSpacing: 0.32,
          //                                             ),
          //                                           ),
          //                                         ),
          //                                       ),
          //                                       Align(
          //                                         alignment: Alignment.topRight,
          //                                         child: Text(
          //                                           item.reqTime,
          //                                           style: const TextStyle(
          //                                             color: Color(0xFF252525),
          //                                             fontSize: 10,
          //                                             fontFamily:
          //                                                 'PoppinsRegular',
          //                                             fontWeight: FontWeight.w400,
          //                                             letterSpacing: 0.20,
          //                                           ),
          //                                         ),
          //                                       )
          //                                     ],
          //                                   ),
          //                                   Opacity(
          //                                     opacity: 0.80,
          //                                     child: Text(
          //                                       "Reg.No : ${item.reqId}",
          //                                       style: const TextStyle(
          //                                         color: Color(0xFF252525),
          //                                         fontSize: 12,
          //                                         fontFamily: 'PoppinsRegular',
          //                                         fontWeight: FontWeight.w400,
          //                                         letterSpacing: 0.24,
          //                                       ),
          //                                     ),
          //                                   ),
          //                                   Row(
          //                                     children: [
          //                                       Expanded(
          //                                           child: Text(
          //                                         "ID : ${item.fromId}",
          //                                         style: const TextStyle(
          //                                           color: Color(0xFF252525),
          //                                           fontSize: 12,
          //                                           fontFamily: 'PoppinsRegular',
          //                                           fontWeight: FontWeight.w400,
          //                                           letterSpacing: 0.24,
          //                                         ),
          //                                       )),
          //                                       const Opacity(
          //                                         opacity: 0.80,
          //                                         child: Text(
          //                                           'To',
          //                                           style: TextStyle(
          //                                             color: Color(0xFF252525),
          //                                             fontSize: 12,
          //                                             fontFamily:
          //                                                 'PoppinsRegular',
          //                                             fontWeight: FontWeight.w400,
          //                                             letterSpacing: 0.24,
          //                                           ),
          //                                         ),
          //                                       ),
          //                                       Expanded(
          //                                           child: Align(
          //                                               alignment:
          //                                                   Alignment.centerRight,
          //                                               child: Text(
          //                                                 "ID : ${item.toId}",
          //                                                 style: const TextStyle(
          //                                                   color:
          //                                                       Color(0xFF252525),
          //                                                   fontSize: 12,
          //                                                   fontFamily:
          //                                                       'PoppinsRegular',
          //                                                   fontWeight:
          //                                                       FontWeight.w400,
          //                                                   letterSpacing: 0.24,
          //                                                 ),
          //                                               )))
          //                                     ],
          //                                   )
          //                                 ],
          //                               ),
          //                             ),
          //                           );
          //                         });
          //                   }),
          //                 )
          //               ],
          //             ),
          //           ]),
          //     )
          //   ],
          // ),
        ),
      ),
    );
  }
}
