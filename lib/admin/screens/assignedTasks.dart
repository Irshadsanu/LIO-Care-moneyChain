import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Constants/functions.dart';
import '../../Provider/admin_provider.dart';
import '../../constants/my_colors.dart';
import '../../models/assigned_task_model.dart';
import 'admin_homeScreen.dart';
import 'admin_taskAssign_screen.dart';

class AssignedTasks extends StatelessWidget {
  AssignedTasks({super.key});

  ValueNotifier<String> isActive = ValueNotifier("ACTIVE");

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    String formattedDate = '';
    return Scaffold(
      backgroundColor: bxkclr,
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
        leading: InkWell(
          onTap: () {
            finish(context);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: myWhite,
            ),
          ),
        ),
        toolbarHeight: 65,
        elevation: 0,
        title: const Text(" Tasks List"),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: cWhite,
        ),
      ),
      floatingActionButton:
          Consumer<AdminProvider>(builder: (context1, val2, child) {
        return InkWell(
          onTap: () {
            val2.addTaskClearController();
            isActive.value = "ACTIVE";

            callNext(
                AdminTaskAssignScreen(
                  from: 'ADD',
                  taskId: '',
                ),
                context);
          },
          child: Container(
            width: 150,
            height: 40,
            padding:
                const EdgeInsets.only(top: 9, left: 28, right: 29, bottom: 8),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFF2F7DC1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(61.71),
              ),
            ),
            child: const Text('+ New Task',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                )),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        //val2.filterForAssignedTasksActive();

        //val2.filterForAssignedTasksEXPAIRED();
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Consumer<AdminProvider>(builder: (context5, val2, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ValueListenableBuilder(
                    valueListenable: isActive,
                    builder: (context, String dIsActive, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                val2.filterForAssignedTasksActive();
                                isActive.value = "ACTIVE";
                              },
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: dIsActive == "ACTIVE"
                                        ? cl2F7DC1
                                        : bxkclr,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: cl2F7DC1,
                                      width: 1,
                                    )),
                                child: Text(
                                  "Active",
                                  style: TextStyle(
                                      color: dIsActive == "ACTIVE"
                                          ? bxkclr
                                          : cl2F7DC1,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                val2.filterForAssignedTasksEXPAIRED();
                                isActive.value = "EXPIRED";
                              },
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: dIsActive == "EXPIRED"
                                        ? cl2F7DC1
                                        : bxkclr,
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: cl2F7DC1, width: 1)),
                                child: Text(
                                  "Expired",
                                  style: TextStyle(
                                      color: dIsActive == "EXPIRED"
                                          ? bxkclr
                                          : cl2F7DC1,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              );
            }),
            const SizedBox(
              height: 10,
            ),
            Consumer<AdminProvider>(builder: (context5, val2, child) {
              return val2.filterAssignedTaskList.isNotEmpty
                  ? SizedBox(
                      width: 500,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemCount: val2.assignedTaskDateList.length,
                          itemBuilder: (BuildContext context, int index) {
                            List<AssignedTaskModel> filteredTasks = val2.filterAssignedTaskList.where((element) => val2.assignedTaskDateList[index].dateFormat == element.addedDate).toList();
                            DateTime now = DateTime.now();
                            DateTime date = val2.assignedTaskDateList[index].date;
                            if (date.year == now.year && date.month == now.month && date.day == now.day) {
                              formattedDate = 'Today';
                            } else if (date.year == now.year && date.month == now.month && date.day == now.day - 1) {
                              formattedDate = 'Yesterday';
                            } else {
                              formattedDate =
                                  DateFormat('dd/MM/yyyy').format(date);
                            }
                            return filteredTasks.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20, bottom: 6),
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
                                            itemCount: filteredTasks.length,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              var item = filteredTasks[index];

                                              return InkWell(
                                                onTap: () {
                                                  val2.fetchTaskEdit(
                                                      item.taskId,
                                                      item.addedName,
                                                      item.addedTime,
                                                      item.taskHeading);
                                                  callNext(
                                                      AdminTaskAssignScreen(
                                                        from: 'EDIT',
                                                        taskId: item.taskId,
                                                      ),
                                                      context);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      gradient:
                                                          const LinearGradient(
                                                              colors: [
                                                            clFFFCF8,
                                                            myWhite
                                                          ]),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: const Offset(
                                                              0, 2),
                                                          blurRadius: 3,
                                                          color: Colors.black
                                                              .withOpacity(0.1),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: width / 1.25,
                                                          height: 25,
                                                          child: Text(
                                                            item.taskHeading,
                                                            style: const TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "PoppinsRegular"),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "By : ${item.addedName}",
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Color(
                                                                  0xff252525),
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  "PoppinsMedium"),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              item.duration,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Color(
                                                                      0xff252525),
                                                                  fontSize: 13,
                                                                  fontFamily:
                                                                      "PoppinsMedium"),
                                                            ),
                                                            Text(
                                                              item.taskStatus,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: item.taskStatus ==
                                                                          "ACTIVE"
                                                                      ? cl0F41A1
                                                                      : cl637BFF,
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      "PoppinsMedium"),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                  )
                                : const SizedBox();
                          }),
                    )
                  : SizedBox(
                      height: height * .5,
                      child: const Center(
                        child: Text(
                          "No Tasks Found !!!",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
            }),
            // Consumer<AdminProvider>(builder: (context6, value, child) {
            //   return double.parse(value.membersCount) ==
            //               value.membersList.length ||
            //           value.filterMembersList.isEmpty ||
            //           value.isDateSelected
            //       ? const SizedBox()
            //       : Center(
            //           child: value.kycValue == 'Kyc Status' ||
            //                   value.kycValue == 'All'
            //               ? InkWell(
            //                   onTap: () {
            //                     value.firstFetchMembers(
            //                         false,
            //                         value
            //                             .membersList[
            //                                 value.membersList.length - 1]
            //                             .regDateTime);
            //                   },
            //                   child: Container(
            //                       decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(7),
            //                         color: loadMoreBg,
            //                       ),
            //                       child: Padding(
            //                         padding: const EdgeInsets.only(
            //                             left: 40, right: 40, top: 8, bottom: 8),
            //                         child: Text(
            //                           "Load More",
            //                           style: TextStyle(
            //                               color: textColor,
            //                               fontFamily: 'Inter',
            //                               fontWeight: FontWeight.bold,
            //                               fontSize: 13),
            //                         ),
            //                       )),
            //                 )
            //               : const SizedBox(),
            //         );
            // }),
            const SizedBox(
              height: 35,
            )
          ],
        ),
      ),
    );
  }
}
