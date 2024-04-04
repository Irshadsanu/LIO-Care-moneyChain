
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:provider/provider.dart';

import '../../Constants/functions.dart';
import '../../Provider/admin_provider.dart';
import '../../constants/my_colors.dart';
import 'admin_homeScreen.dart';
import 'admin_menu_screen.dart';
class ExchangeUserScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   ExchangeUserScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
    //   endDrawer: Drawer(
    //   width: MediaQuery.of(context).size.width,
    //   child: const AdminMenuScreen(),
    // ),
      backgroundColor: bxkclr,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        // actions: [
        //   Builder(
        //     builder: (context) => IconButton(
        //       icon: const CircleAvatar(
        //         backgroundColor:  Colors.transparent,
        //         radius: 20,
        //         child: Padding(
        //           padding: EdgeInsets.all(5.0),
        //           child: Icon(Icons.menu,color: cWhite,),
        //         ),
        //       ),
        //       onPressed: () => Scaffold.of(context).openEndDrawer(),
        //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //     ),
        //   ),
        //   const SizedBox(
        //     width: 20,
        //   ),
        // ],
        toolbarHeight: 65,
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/whitelogo.png",scale: 12,),
            const Text(
              'User Exchange',
              style: TextStyle(
                fontFamily: 'PoppinsRegular',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: myWhite,
              ),
            ),
            // const Spacer()
          ],
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Consumer<AdminProvider>(
            builder: (context23,valuee,child) {
              return Padding(
                padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const Text(
                      //   'Exchange',
                      //   style: TextStyle(
                      //     fontFamily: 'PoppinsRegular',
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w600,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),


                     valuee.isEligibleToExchange?SizedBox() :Column(children: [

                      const SizedBox(
                        width: 330,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 120,
                                child: Text("From User Id:")),
                            SizedBox(
                                width: 120,
                                child: Text("To User Id:")),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Consumer<AdminProvider>(
                              builder: (context,value2,child) {
                                return SizedBox(
                                  width: 140,
                                  child: Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    elevation: 5,
                                    shadowColor: Colors.white.withOpacity(0.5),
                                    child: TextFormField(
                                      inputFormatters:[
                                        LengthLimitingTextInputFormatter(15)

                                      ],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 13),
                                      controller: value2.fromController,
                                      decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                              borderSide: const BorderSide(color: Colors.white)),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          fillColor: Colors.grey,
                                          filled: false,
                                          hintText: 'Enter Registration ID',
                                          hintStyle: const TextStyle(
                                            color: Color(0xff5F5F5F),
                                            fontSize: 10,
                                            fontFamily: 'PoppinsRegular',
                                          )),
                                      onChanged: (text){
                                        if(value2.fromController.text.length==15){
                                          value2. registrationIdExchange(value2.fromController.text,"FROM");
                                        }
                                        else{
                                          value2.clearExchangeControllers("FROM");
                                        }

                                      },
                                      validator: (txt) {
                                        if (txt!.trim().isEmpty) {
                                          return "Enter ID" ;
                                        }else if (txt.trim()==value2.toController.text) {
                                          return "Don`t Enter Same Id" ;
                                        } else {
                                          return null;
                                        }
                                      },

                                    ),
                                  ),
                                );
                              }
                          ),

                          CircleAvatar(
                            maxRadius: 18,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.repeat),
                              color: const Color(0XFF004AA6),
                            ),
                          ),
                          Consumer<AdminProvider>(
                              builder: (context,value1,child) {
                                return SizedBox(
                                  width: 140,
                                  child: Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    elevation: 5,
                                    shadowColor: Colors.white.withOpacity(0.5),
                                    child: TextFormField(
                                      inputFormatters:[
                                        LengthLimitingTextInputFormatter(15)
                                      ],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize:13),
                                      controller:value1.toController,
                                      decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                              borderSide: const BorderSide(color: Colors.white)),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          fillColor: Colors.grey,
                                          filled: false,
                                          hintText: 'Enter Registration ID',
                                          hintStyle: const TextStyle(
                                            color: Color(0xff5F5F5F),
                                            fontSize: 10,
                                            fontFamily: 'PoppinsRegular',
                                          )),
                                      onChanged: (text){
                                        if(value1.toController.text.length==15){
                                          value1. registrationIdExchange(value1.toController.text,"TO");
                                        }else{
                                          value1.clearExchangeControllers("TO");
                                        }
                                      },
                                      validator: (txt) {
                                        if (txt!.trim().isEmpty) {
                                          return "Enter ID" ;
                                        }else if (txt.trim()==value1.fromController.text) {
                                          return "Don`t Enter Same Id" ;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                );
                              }
                          ),

                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Consumer<AdminProvider>(
                          builder: (context,value1,child) {
                            return Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              elevation: 5,
                              shadowColor: Colors.white.withOpacity(0.5),
                              child: InkWell(
                                onTap: (){
                                       final FormState? form =
                                                      _formKey.currentState;
                                                  if (form!.validate()) {
                                                    value1.checkUserExchangeEligibility(value1.fromController.text, value1.toController.text, context);
                                                  }},
                                child: Container(
                                    alignment: Alignment.center,
                                    width: 330,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: clF4F6F8,width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        begin: Alignment.bottomRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          cl005BBB,
                                          cl001969,
                                        ],
                                      ),
                                    ),
                                    child:value1.isEligibleChecking? const CircularProgressIndicator():const Text("Check Eligibility",
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: myWhite),)),
                              ),
                            );
                          }
                      ),

                      ],),
                      const SizedBox(
                        height: 5,
                      ),



                   valuee.isEligibleToExchange?  Column(children: [
                      ///edit
                      Consumer<AdminProvider>(
                        builder: (context,value2,child) {
                          return Row(
                            children: [
                              boXx(
                                  title1: value2.exchangeFromName,
                                  title2: value2.exchangeFromRegID,
                                  title3: value2.exchangeFromPhone),
                              const SizedBox(
                                width: 10,
                              ),
                              boXx(
                                  title1: value2.exchangeToName,
                                  title2:value2.exchangeToRegID ,
                                  title3:value2.exchangeToPhone),
                            ],
                          );
                        }
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          'Reasons',
                          style: TextStyle(
                            color: Color(0xFF252525),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.24,
                          ),
                        ),
                      ),
                      Consumer<AdminProvider>(
                          builder: (context,val22,child) {

                            return SizedBox(
                              height:250,
                              width: width/1.1,
                              child: ListView.builder(
                                itemCount: 5,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                      height: 45,
                                      padding: const EdgeInsets.only(
                                        top: 11,
                                        left: 11,
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

                                        Radio(value:val22.exchangeReasons[index],
                                          groupValue:val22.selectedExchange,
                                          onChanged: (value){
                                            val22.radioForExchange(value);
                                          },
                                        ),
                                        Text(
                                          val22.exchangeReasons[index],
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
                      Consumer<AdminProvider>(
                          builder: (context,val23,child) {
                            return val23.exchangeOtherCheck==true? Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: myWhite, boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 2),
                                  blurRadius: 1,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ]),
                              width: width/1.1,
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                minLines: 2,
                                maxLines: null,
                                controller: val23.exChangeController,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "PoppinsRegular"),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: myWhite,
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white, width: 0.5),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white, width: 0.5),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white, width: 0.5),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white, width: 0.5),
                                  ),
                                  hintText: "Reason.....",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "PoppinsRegular"),
                                ),
                                validator: (txt) {
                                  if (txt!.trim().isEmpty) {
                                    return "Enter Reason" ;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ):const SizedBox();
                          }
                      ),

                      valuee.fileImage!=null?
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                        color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Your Proof',
                                      style: TextStyle(
                                        color: Color(0xFF252525),
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.30,
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                       valuee.closeButton();
                                      },
                                      child: CircleAvatar(backgroundColor: Colors.grey[300],
                                      radius: 12,child: const Icon(Icons.close,color: Colors.white,),),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(

                                    color: const Color(0xffEDEDED),
                                    image:DecorationImage(
                                        fit: BoxFit.fitHeight,
                                        image: FileImage(valuee.fileImage!))

                                ),
                                height: 472,
                              ),
                            ],
                          ),
                        ),
                      ):const SizedBox(),


                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          valuee.showBottomSheet(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                              color: myWhite, boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 2),
                              blurRadius: 1,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ]),

                          width: width/1.1,
                          height: 60,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text('Upload Proof', style: TextStyle(
                                    color: Color(0xFF252525),
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.30,
                                  ),
                                ),
                              ),

                              Icon(Icons.upload_file)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),


                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                          height: 50,
                          width: 350,
                          child: Consumer<AdminProvider>(
                            builder: (context,value3,child) {
                              return value3.exchangeUserBool==false
                                  ? MaterialButton(
                                onPressed: () {
                                    final FormState? form =
                                        _formKey.currentState;
                                    if (form!.validate()) {
                                      if (value3.fileImage != null&&value3.selectedExchange!="") {
                                        value3.exchangeUsers(value3.fromController.text,value3.toController.text,
                                            value3.exchangeFromRegDocID,value3.exchangeToRegDocID,context);

                                      }else{
                                        final snackDemo = SnackBar(
                                          content:  SizedBox(
                                            width: 284,
                                            height: 20,
                                            child: Text(
                                              value3.selectedExchange==""?"Select Reason":"Upload Image",
                                              style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                                fontFamily: 'PoppinsRegular',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          backgroundColor: myWhite,
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(79),
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackDemo);
                                      }
                                    }
                               //    value3.exchangeUsers(value3.fromController.text,value3.toController.text,context);
                                },
                                  color: const Color(0xff1746A2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                      fontFamily: 'PoppinsRegular',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ):const SizedBox();
                            }
                          )),
                    ),
                  ],):const SizedBox()
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  Widget textField(
      {required String labelText, required TextEditingController controller}) {
    return SizedBox(
      height: 44,
      width: 140,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        shadowColor: Colors.white.withOpacity(0.5),
        child: TextField(
            textAlign: TextAlign.center,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 5),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                fillColor: Colors.grey,
                filled: false,
                hintText: labelText,
                hintStyle: const TextStyle(
                  color: Color(0xff5F5F5F),
                  fontSize: 10,
                  fontFamily: 'PoppinsRegular',
                ))),
      ),
    );
  }

  Widget boXx({
    required String title1,
    required String title2,
    required String title3,
  }) {
    return Expanded(
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        shadowColor: Colors.white.withOpacity(0.5),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 11,bottom: 10),
          // height: 89,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title1,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    fontFamily: 'PoppinsRegular'),
              ),
              const SizedBox(height: 5),
              Text(
                title2,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: 'PoppinsRegular'),
              ),
              Text(
                title3,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: 'PoppinsRegular'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
