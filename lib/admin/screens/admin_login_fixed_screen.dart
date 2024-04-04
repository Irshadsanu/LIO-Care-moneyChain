import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../Provider/admin_provider.dart';
import '../../Provider/login_provider.dart';

class AdminFixedLogin extends StatelessWidget {
   AdminFixedLogin({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    LoginProvider loginProvider =
    Provider.of<LoginProvider>(context, listen: false);
    AdminProvider adminProvider =
    Provider.of<AdminProvider>(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Scaffold(


      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Consumer<LoginProvider>(
            builder: (context5,value5,child) {
              return Form(
                key: _formKey,
                child: Column(
                    children: [
                      SizedBox(height: height*0.1,),
                      Image.asset('assets/bluelogo.png', width: 103.31,
                        height: 71,),
                       SizedBox(height: height*0.01),
                      const Text(
                        'Admin Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.32,
                        ),
                      ),  Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: height*0.02),
                          child: const SizedBox(
                              width: 184.05,
                              height: 137.39,
                              child: Image(
                                image: AssetImage("assets/loginpage.png"),
                                fit: BoxFit.fill,
                              )),
                        ),
                      ),
                      SizedBox(height: height*0.01),
                      Padding(

                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              children: [
                                TextFormField(
                                  controller: value5.userLoginPhoneCT,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10)
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'Phone Number',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF5E5E5E),
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.32,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),                  labelStyle: TextStyle(
                                    color: Color(0xFF5E5E5E),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.32,
                                  ),
                                    hintText: 'Enter your Phone Number',
                                  ),
                                  validator: (text) => text!.trim().isEmpty
                                      ? "Enter Phone Number"
                                      : text.trim().length!=10
                                      ?"Enter Correct Phone Number"
                                      :null,
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  controller: value5.userLoginPasswordCT,
                                  obscureText: value5.hidePassword, // hides entered text (for password fields)
                                  decoration:  InputDecoration(
                                    suffixIcon: InkWell(
                                        onTap: (){
                                          value5.showHidePassword();
                                        },
                                        child: const Icon(Icons.remove_red_eye_outlined,)
                                    ),
                                    labelText: ' password ',
                                    labelStyle: const TextStyle(
                                      color: Color(0xFF5E5E5E),
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.32,
                                    ),
                                    hintText: 'Enter your password',
                                    hintStyle: const TextStyle(
                                      color: Color(0xFF5E5E5E),
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.32,
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  validator: (text) => text!.trim().isEmpty
                                      ? "Enter Password"
                                      : null,
                                ),

                                SizedBox(
                                  height: height*0.1,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  width: width / 1.06,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: const Color(0xFF2F7DC1),
                                  ),
                                  child: TextButton(
                                    child: const Text(
                                        'Log In',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.32,
                                        )),
                                    onPressed: () {
                                      final FormState? form =
                                          _formKey.currentState;
                                      if(form!.validate()) {
                                        db.collection("USERS").where("PHONE",isEqualTo: loginProvider.userLoginPhoneCT.text.trim())
                                            .where("PASSWORD",isEqualTo: loginProvider.userLoginPasswordCT.text).get().then((adminValue) {
                                          if(adminValue.docs.isNotEmpty){
                                            loginProvider.userAuthorized("OTHER","+91${loginProvider.userLoginPhoneCT.text}","", context);
                                          }else{
                                            const snackBar = SnackBar(
                                              content: Text('Sorry, No user found with this number.'),
                                            );
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                          }
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ])),]),
              );
            }
        ),






      ),
    );
  }
}
