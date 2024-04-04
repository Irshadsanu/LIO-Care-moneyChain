import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:lio_care/Provider/login_provider.dart';
import 'package:lio_care/help_tree/tree_provider.dart';
import 'package:provider/provider.dart';

import 'constants/my_colors.dart';

class RegistrationTest extends StatelessWidget {
   RegistrationTest({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return  Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: Consumer<TreeProvider>(
          builder: (context2,value2,child) {
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 100,),
                    Container(
                      alignment: Alignment.center,
                      width: width / 1.1,
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.only(left: 7),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFFCF8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 7,
                            offset: Offset(1, 1),
                            spreadRadius: -1,
                          )
                        ],
                      ),
                      child: TextFormField(
                        controller: value2.numberController,
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 12,
                          fontFamily: 'PoppinsRegular',
                          fontWeight: FontWeight.w400,
                          height: 1.31,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter your Number here',
                          // This is the hintText
                          hintStyle: TextStyle(fontSize: 14),
                          // This is the hintText
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent, width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent, width: 1),
                          ),
                        ),
                        validator: (text) {
                          if (text!.trim().isEmpty||text.trim().length!=10) {
                            return 'Enter number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: width / 1.1,
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.only(left: 7),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFFCF8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 7,
                            offset: Offset(1, 1),
                            spreadRadius: -1,
                          )
                        ],
                      ),
                      child: TextFormField(
                        controller: value2.nameController,
                        style: const TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 12,
                          fontFamily: 'PoppinsRegular',
                          fontWeight: FontWeight.w400,
                          height: 1.31,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter your Name here',
                          // This is the hintText
                          hintStyle: TextStyle(fontSize: 14),
                          // This is the hintText
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent, width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent, width: 1),
                          ),
                        ),
                        validator: (text) {
                          if (text!.trim().isEmpty) {
                            return 'Enter Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: width / 1.1,
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.only(left: 7),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFFCF8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 7,
                            offset: Offset(1, 1),
                            spreadRadius: -1,
                          )
                        ],
                      ),
                      child: TextFormField(
                        controller: value2.refNumberController,
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 12,
                          fontFamily: 'PoppinsRegular',
                          fontWeight: FontWeight.w400,
                          height: 1.31,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter your Ref Number here',
                          // This is the hintText
                          hintStyle: TextStyle(fontSize: 14),
                          // This is the hintText
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent, width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent, width: 1),
                          ),
                        ),
                        validator: (text) {
                          if (text!.trim().isEmpty||text.trim().length!=10) {
                            return 'Enter ref number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    InkWell(
                      onTap: (){
                        // value2.loopInTreeToDistributions();
                        // value2.loopReferenceName();
                        // value2.changeName();
                        // value2.nghfdfadsx();
                        // value2.addDummyParents();
                        // value2.loopToClubs();
                        // value2.addMyTaskInToTection();
                        // value2.loopParentsToParents();
                        // value2.deleteCollection();
                        // value2.addDummyParents();
                        // value2.addFonts();
                        // value2.addTotalPayments();
                        // value2.createDummyTreeNodes();
                         //value2.printListNames();
                         // value2.clearAllData();
                         // value2.loopPasswords();
                         // value2.changeLeadersData();
                         // value2.castToNewName();

                        // if (formKey.currentState!.validate()) {
                        //   value2.userRegistration(value2.refNumberController.text.trim(), context);
                        // }

                      },
                      child: Container(
                        height: 50,
                        width: 200,
                        color: clFFA500,
                        alignment: Alignment.center,
                        child: const Text("Register",style: TextStyle(color: myWhite,fontSize: 20),),
                      ),
                    ),
                    const SizedBox(height: 50),
                    // InkWell(
                    //   onTap: (){
                    //     print("login  +91${value2.numberController.text.trim()}");
                    //
                    //     LoginProvider loginProvider =
                    //     Provider.of<LoginProvider>(context, listen: false);
                    //     loginProvider.userAuthorized("OTHER","+91${value2.numberController.text.trim()}","", context);
                    //   },
                    //   child: Container(
                    //     alignment: Alignment.center,
                    //     height: 50,
                    //     width: 200,
                    //     color: clFFA500,
                    //     child: const Text("Login",style: TextStyle(color: myWhite,fontSize: 20),),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
