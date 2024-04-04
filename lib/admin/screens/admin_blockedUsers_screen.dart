import 'package:flutter/material.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:lio_care/models/blocked_members_Model.dart';
import 'package:provider/provider.dart';

import '../../Constants/functions.dart';
import '../../constants/my_colors.dart';
import '../../view/Widgets/my_widgets.dart';
import 'admin_homeScreen.dart';
import 'admin_menu_screen.dart';

class AdminBlockedUsers extends StatelessWidget {
  const AdminBlockedUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    AdminProvider adminProvider =
    Provider.of<AdminProvider>(context, listen: false);
    return Scaffold(
      endDrawer: Drawer(
        width: width,
        child: const AdminMenuScreen(),
      ),
      backgroundColor: bxkclr,
      appBar: AppBar(
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
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [cl001969, cl005BBB])),
        ),
        elevation: 0,
        title: Text(
          "Blocked Users",
          style: appbarStyle,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
            child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(200),
                ),
                child: searchBar("BLOCKED_LIST")),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16,left: 25),
            child: Consumer<AdminProvider>(
                builder: (context,val20,chils) {
                  return InkWell(
                    onTap: (){
         val20.showCalendarDialog(context,"BLOCKLIST");
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
          const SizedBox(height: 10),

          Flexible(
            child: Consumer<AdminProvider>(
              builder: (context,val23,child) {
                return val23.filterBlockedMembersList.isNotEmpty? ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                    ),
                    itemCount: val23.filterBlockedMembersList.length,
                    itemBuilder: (BuildContext context, int index) {
                      BlockedMembersModel item=val23.filterBlockedMembersList[index];
                      return Container(
                        // height: height / 14,
                        width: width / 3,
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Text(
                                  item.name  ,
                                    style: const TextStyle(
                                        color: Color(0xff3D3B3B),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        fontFamily: "PoppinsRegular"),
                                  ),

                                  val23.adminPrivilegeList.contains("Members changes")
                                      ?PopupMenuButton(
                                    color:cl004CA8,
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          onTap: (){
                                            val23.unblockUser(context,item.id);
                                        },

                                          value: 0,
                                          child: Row(
                                            children:  [
                                              Image.asset(
                                                "assets/unblock.png",
                                                color: myWhite,
                                                scale: 1.5,
                                              ),
                                              const SizedBox(width: 4,),
                                              const Text(' Unblock',
                                                style: TextStyle(
                                                    color: myWhite,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "PoppinsRegular"
                                                ),),
                                            ],
                                          ),
                                        ),
                                      ];
                                    },
                                  )
                                      :const SizedBox()
                                ],
                              ),
                               Text(
                                "Blocked date: ${item.date}",
                                style: const TextStyle(
                                    color: Color(0xff252525),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                    fontFamily: "PoppinsRegular"),
                              ),
                               Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Reg.No : ${item.id}",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff5F5F5F),
                                          fontFamily: "PoppinsRegular",
                                          fontWeight: FontWeight.w400),
                                    ),

                                  ],
                                ),
                              ),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "+91 ${item.phone}",
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontFamily: "PoppinsRegular",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      "Inviters: ${item.inviters}",
                                      style: const TextStyle(
                                          color: Color(0xff5F5F5F),
                                          fontFamily: "PoppinsRegular",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                               Row(
                                children: [
                                  Text(
                                   "Reason : ${item.reason}" ,
                                    style: const TextStyle(
                                        color: Color(0xff252525),
                                        fontFamily: "PoppinsRegular",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      );
                    }):const Center(child: Text("No Blocked Users Yet. "),);
              }
            ),
          ),
        ],
      ),
    );
  }
}
