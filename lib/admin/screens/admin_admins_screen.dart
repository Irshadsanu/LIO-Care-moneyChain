import 'package:flutter/material.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:lio_care/models/adminsListModel.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/functions.dart';
import '../../constants/my_colors.dart';

import 'admin_addAdmin_screen.dart';
import 'admin_homeScreen.dart';
import 'admin_menu_screen.dart';

class Admins extends StatelessWidget {
  const Admins({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: Drawer(
      width: width,
      child: const AdminMenuScreen(),
    ),

      appBar: AppBar(
        backgroundColor: cWhite,
        toolbarHeight: 65,

        elevation: 0,
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
        title:  const Text("  Admins ",
          style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: cWhite,
        ),),
        flexibleSpace: Container(
          decoration:  const BoxDecoration(
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

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            children: [
              Consumer<AdminProvider>(
                builder: (context,val9,child) {
                  return Container(
                    height:180,
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.all(15),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x11000000),
                          blurRadius: 9,
                          offset: Offset(2, 3),
                          spreadRadius: -1,
                        )
                      ],
                    ),

                  child: Column(children: [
                    Row(
                      children: [
                        val9.adminImage.isEmpty?
                        CircleAvatar(
                          radius: 38,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            'assets/bluelogo.png',scale: 4,
                          ),
                        )
                            :  CircleAvatar(
                          backgroundImage:  NetworkImage(
                            val9.adminImage,scale: 4,
                          ),
                          radius: 38,
                          backgroundColor: Colors.white,

                        ),
                        Expanded(child: SizedBox(


                        width: width,
                        height: 72,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Column(
                            mainAxisAlignment:MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                            Text(val9.adminName, style: TextStyle(
                  fontSize: width / 24,
                  fontWeight: FontWeight.w600),
                  ),
                            Text("+91 ${val9.adminPhone}",style: TextStyle(
                                fontSize: width / 32.5,
                                fontWeight: FontWeight.w400))
                          ],),
                        ),

                        )),
                        Consumer<AdminProvider>(builder: (context7, value1, child) {
                          return value1.adminPrivilegeList.contains("Admins changes")
                              ?Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: width / 15,
                              width: width / 4.75,
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(cl004CA8),
                                    shape: MaterialStatePropertyAll(StadiumBorder())),
                                onPressed: () {
                                  value1.clearAddAdminCT();
                                  callNext( AddAdmin(from: 'ADD',userID: '',), context);
                                },
                                child: Text(
                                  "Add ＋",
                                  style: TextStyle(
                                    color: Colors.white,
                                      fontWeight: FontWeight.w600, fontSize: width / 40),
                                ),
                              ),
                            ),
                          ):const SizedBox(height: 15,);
                        }
                        ),
                      ],
                    ),
const Spacer(),

                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: SizedBox(
                        height: 50,
                        child: Consumer<AdminProvider>(
                            builder: (context8,val,child) {
                              return TextFormField(
                                onChanged: (value){
                                  val.filterAdminLists(value);
                                },
                                cursorColor: clBlack54,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(left: 10),
                                    hintText: "Search...",
                                    suffixIcon: const Icon(Icons.search_rounded,
                                        color: cBlack, size: 30),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(200)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(Radius.circular(200)))),
                              );
                            }
                        ),
                      ),
                    ),

                  ],),
                  );
                }
              ),



              Consumer<AdminProvider>(builder: (context4, val50, child) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: val50.filterAdminList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      AdminsListModel item = val50.filterAdminList[index];
                      return InkWell(
                        onTap: (){
                          if(val50.adminPrivilegeList.contains("Admins changes")) {
                            val50. fetchAdminForEdit(item.id);
                            callNext( AddAdmin(from: 'EDIT', userID: item.id,), context);
                          }
                        },
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(width / 48),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: width/1.5,
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                            fontSize: width / 24,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    val50.adminPrivilegeList.contains("Admins changes")
                                    ?SizedBox(
                                      width: width/7,
                                      child:  Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              val50. fetchAdminForEdit(item.id);
                                              callNext( AddAdmin(from: 'EDIT', userID: item.id,), context);
                                            },
                                            child: const Icon(
                                              Icons.edit,size: 19,color: cl0F41A1,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){

                                              approveExchange(context,item.id);


                                            //  val50.deleteAdmin(item.id,context );
                                            },
                                            child: const Icon(
                                                Icons.delete, size: 19,color: cl637BFF
                                            ),
                                          ),
                                        ],
                                      )
                                    )
                                        :const SizedBox(height: 10,width: 10,),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "+91${item.phNumber}",
                                      style: TextStyle(
                                          fontSize: width / 32.5,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      item.date,
                                      style: TextStyle(
                                          fontSize: width / 48,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        launch('whatsapp://send?phone=${item.phNumber}');
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(width / 48),
                                        child: Container(
                                          height: width / 14,
                                          width: width / 5,
                                          decoration: ShapeDecoration(
                                              color: grdintclr2,
                                              shape: const StadiumBorder()),
                                          child:
                                              Image.asset("assets/whatsapp.png"),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        launch("tel://${item.phNumber}");
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(width / 48),
                                        child: Container(
                                          height: width / 14,
                                          width: width / 5,
                                          decoration: ShapeDecoration(
                                              color: grdintclr2,
                                              shape: const StadiumBorder()),
                                          child: const Icon(
                                            Icons.phone,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              })

            ],
          ),
        ),
      ),
    );
  }
  approveExchange(BuildContext context,String id) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        scrollable: true,
        content: Container(
          // height: height*0.26,
          width: width,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFFEBEBEB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x1C000000),
                blurRadius: 11,
                offset: Offset(0, 9),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Are you Sure to Delete?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF252525),
                        fontSize: 16,
                        fontFamily: 'PoppinsRegular',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),

              const SizedBox(height: 20),
              Consumer<AdminProvider>(builder: (context, val10, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              finish(context);
                            },
                            child: Container(
                              width: 120,
                              height: 39,
                              alignment: Alignment.center,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFFFFCF8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(62),
                                ),
                              ),
                              child: const Text(
                                'Cancel',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF252525),
                                  fontSize: 16,
                                  fontFamily: 'PoppinsRegular',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              val10.deleteAdmin(id,context );
                              finish(context);
                            },
                            child: Container(
                              width: 120,
                              height: 39,
                              alignment: Alignment.center,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF2F7DC1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(62),
                                ),
                              ),
                              child: const Text(
                                "Delete",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFFFFCF8),
                                  fontSize: 16,
                                  fontFamily: 'PoppinsRegular',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 20),
            ],
          ),
       )] )));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
