import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lio_care/Constants/functions.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/my_colors.dart';

import '../../models/admin_trasnaction_historyModelClass.dart';
import 'admin_menu_screen.dart';

class AddAdmin extends StatelessWidget {
String from,userID;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AddAdmin({Key? key,required this.from,required this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: Drawer(
        width: width,
        child: const AdminMenuScreen(),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 50,
        toolbarHeight: 65,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              finish(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(CupertinoIcons.back),
            )),
        title: const Text("Admins",
          style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: cWhite,
        ),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.92, -0.40),
              end: Alignment(-0.92, 0.4),
              colors: [cl2FC1BC, cl2F7DC1],
            ),
          ),
        ),
      ),

      body: Form(
        key: formKey,
        child: Consumer<AdminProvider>(builder: (context, val, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, left: 20, right: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Add New Admin",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 37,),

                  val.fileImage != null
                      ? Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: FileImage(val.fileImage!),
                                    fit: BoxFit.fill),
                              ))):val.adminProfile!=""
                      ?Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(val.adminProfile),
                                    fit: BoxFit.fill),
                              )))
                      : Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              width: 119.92,
                              height: 107,
                              child: Image.asset(
                                "assets/addNewAdmin.png",
                              )),
                        ),

                  const SizedBox(height: 20),

                  InkWell(
                    onTap: () {
                      val.showBottomSheet(context);
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 168,
                        height: 30,
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: clFFFCF8,
                          shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(width: 0.25, color: cl2F7DC1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: const Text(
                          'Upload Photo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: cl2F7DC1,
                            fontSize: 12,
                            fontFamily: 'PoppinsRegular',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.24,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40,),

                  TextFormField(
                    controller: val.addAdminNameCT,
                    cursorColor: cBlack,
                    keyboardType: TextInputType.name,
                    maxLength: 30,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      counterText: "",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: cBlack)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: cBlack)),
                      labelText: "Enter your Name",
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter your Name';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20,),

                  TextFormField(
                    controller: val.addAdminNumberCT,
                    cursorColor: cBlack,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      counterText: "",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: cBlack)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: cBlack)),
                      labelText: "Enter your Number",
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 10) {
                        return '10 Number is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20,),

                  TextFormField(
                      controller: val.addAdminPasswordCT,
                      cursorColor: cBlack,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        counterText: "",
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: cBlack)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: cBlack)),
                        labelText: "Enter Password",
                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter Password';
                        } else {
                          return null;
                        }
                      }),

                   Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Privilege",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontFamily: "PoppinsRegular"),
                          ),
                          Consumer<AdminProvider>(
                            builder: (context,value,child) {
                              return Row(
                                children: [
                                  InkWell(
                                      onTap: (){
                                        value.selectAllPrivilege(value.checkAll);
                                      },
                                      child: const Text("All",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500))),
                                  Checkbox(
                                    value:value.checkAll,
                                    activeColor: Colors.blue,
                                    checkColor: Colors.white,
                                    onChanged: (newValue) {
                                      value.checkAll = newValue!;
                                      value.notifyListeners();
                                      value.selectAllPrivilege(newValue);
                                    },

                                  ),
                                ],
                              );
                            }
                          )
                        ],
                      ),
                    ),
                  ),
                  Consumer<AdminProvider>(
                      builder: (context,val22,child) {

                        return SizedBox(
                          height:230,
                          width: width/1.1,
                          child:
                          ListView.builder(
                            itemCount: 4,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                  height: 45,
                                  padding: const EdgeInsets.only(
                                    top: 11,
                                    left: 11,
                                    right: 91,
                                    bottom: 12,
                                  ),
                                  margin: const EdgeInsets.only(bottom: 4),
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(0.00, -1.00),
                                      end: Alignment(0, 1),
                                      colors: [Color(0xFFFFFCF8), Colors.white],
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
                                  child:
                                  Row(children: [


                                    Checkbox(
                                      value: val22.privilegeList[index].select,
                                      checkColor: Colors.white,
                                      activeColor: Colors.blue,
                                      onChanged: (val) {
                                        val22.adminPrivilege(index,val!);
                                      },
                                    ),

                                    Text(
                                      val22.privilegeList[index].item,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "PoppinsRegular"),
                                    ),],)
                              );
                            },
                          ),
                        );
                      }
                  ),

                  const SizedBox(height: 50),

                  SizedBox(
                    height: 50,
                    width: width,
                    child: Consumer<AdminProvider>(
                        builder: (context, value3, child) {
                      return value3.addAdminBool == false
                          ? ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(cl22A2B1),
                                  shape: MaterialStatePropertyAll(
                                      StadiumBorder())),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if(from=="ADD"){
                                    val.addAdmin('','ADD',val.adminName, val.adminId, context);
                                  }else{
                                    val.addAdmin(userID,"EDIT",val.adminName, val.adminId, context);

                                  }
                                }
                              },
                              child:  Text(
                                from=='ADD'
                                ?"Add Admin"
                                :'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            )
                          : const SizedBox(
                              height: 10.0,
                              width: 10.0,
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: cl004CA8,
                              )),
                            );
                    }),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
