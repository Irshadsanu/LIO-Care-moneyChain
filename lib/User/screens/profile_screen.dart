import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lio_care/Constants/functions.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants/my_colors.dart';
import '../../view/Widgets/my_widgets.dart';
import 'make_dynamic_Link_Screen.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;


    final fxdWidth=width*.78;
    return Scaffold(
      backgroundColor: myWhite,
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: myWhite,
        elevation: 0,
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
      ),
      body:  Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.topEnd,
        children: [

          Padding(
            padding:  EdgeInsets.only(top: height*0.05),
            child: Container(
              height: height*.94,
              decoration: BoxDecoration(
                  color: textColor,
                  gradient: const LinearGradient(
                    begin: Alignment(0.92, -0.40),
                    end: Alignment(-0.92, 0.40),
                    colors: [ Color(0xFF2FC1BC),Color(0xFF2F7DC1),],
                  ),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(38),
                      topRight: Radius.circular(38)
                  )),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0,top: 12),
                        child: Consumer<UserProvider>(
                          builder: (context,val40,child) {

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:   [
                                InkWell(
                                  onTap: (){
                                    val40.editCheckFun2();
                                  },
                                  child: Column(
                                    children: [
                                      const Text(
                                        "My Profile",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "PoppinsRegular",
                                            fontSize: 20),
                                      ),
                                      val40.editCheck2
                                        ?const SizedBox()
                                      :Row(
                                          children: [
                                          const Opacity(
                                          opacity: 0.90,
                                          child: Text(
                                            'Edit Profile',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.24,
                                            ),
                                          ),
                                        ),
                                          const SizedBox(width: 8.6,),
                                          Container( width: 20,
                                          height: 10,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFF2FA8BD),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ),
                                          child: Image.asset("assets/edit.png",color: myWhite,scale: 2,),

                                        )],)
                                    ],
                                  ),
                                ),

                                // Flexible(
                                //   fit: FlexFit.tight,
                                //   child: InkWell(
                                //     onTap: (){
                                //       finish(ctx);
                                //     },
                                //   ),
                                // ),
                              ],);
                          }
                        ),
                      ),


                      const SizedBox(height: 20,),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              const SizedBox(height: 20,),

                              SizedBox(
                                width: fxdWidth,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Name",
                                            style: profileStyle,),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(right: 8.0,top: 4),
                                        //   child: Image.asset("assets/edit.png",color: myWhite,scale: 1.3,),
                                        // ),
                                      ],
                                    ),
                                    Consumer<UserProvider>(
                                      builder: (context,val3,child) {
                                        return SizedBox(
                                            width: fxdWidth,
                                            height: 43,
                                            child: profileTextField(val3.myProfileNAMEEditingController, Colors.transparent)
                                        );
                                      }
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20,),

                              SizedBox(
                                width: fxdWidth,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Mobile Number",
                                            style: profileStyle,),
                                        ),
                                        // Container(
                                        //   // width:35,
                                        //   //   height: 28,
                                        //   // decoration: BoxDecoration(
                                        //   //   borderRadius: const BorderRadius.only(topRight: Radius.circular(30)),
                                        //   //     gradient: RadialGradient(
                                        //   //         center: Alignment.topRight,
                                        //   //         radius: 0.9,
                                        //   //         colors: [
                                        //   //           Textcolor,
                                        //   //           clD9D9D9.withOpacity(0.7),
                                        //   //           ],
                                        //   //         stops: const [0.5, 2,]
                                        //   //     ),
                                        //   // ),
                                        //     child: Padding(
                                        //       padding: const EdgeInsets.only(right: 8.0,top: 4),
                                        //       child: Image.asset("assets/edit.png",color: myWhite,scale: 1.3,),
                                        //     )),
                                      ],
                                    ),
                                    Consumer<UserProvider>(
                                        builder: (context,val4,child) {
                                        return SizedBox(
                                            width: fxdWidth,
                                            height: 43,
                                            child: profileTextFieldPhone(val4.myProfileNUMBEREditingController,"Number", Colors.transparent,10)

                                        );
                                      }
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 42.0),
                                  child: Text("Registration Date",
                                    style: profileStyle,),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Consumer<UserProvider>(
                                      builder: (context,val5,child) {
                                      return SizedBox(
                                          width: fxdWidth,
                                          height: 43,
                                          child:  TextField(
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.32,
                                            ),
                                            enabled: false,
                                            decoration: InputDecoration(
                                              filled: true,
                                              enabled: true,
                                              fillColor:Colors.transparent,
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                              disabledBorder:  const UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white,width: 0.5),
                                              ),
                                              enabledBorder: const UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),


                                              hintText: val5.registrationDate,
                                              hintStyle: const TextStyle(color: myWhite),
                                            ),
                                          )

                                      );
                                    }
                                  )
                                ],
                              ),

                              const SizedBox(height: 20,),
                              Consumer<UserProvider>(
                                builder: (context,val90,child) {
                                  return SizedBox(
                                    width: fxdWidth,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("UPI ID",
                                                style: profileStyle,),
                                            ),
                                            InkWell(
                                              onTap: (){
                                                Clipboard.setData(ClipboardData(
                                                    text: val90.myProfileUPIIDEditingController
                                                        .text));
                                                const snackBar = SnackBar(duration: Duration(milliseconds: 700),
                                                  elevation: 6.0,
                                                  backgroundColor: myWhite,
                                                  behavior: SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(20))),
                                                  content: Text(
                                                    "Copied",
                                                    style: TextStyle(color: Colors.red),
                                                  ),
                                                );
                                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 8.0,top: 4),
                                                child: Image.asset("assets/copy.png",color: myWhite,scale: 3,),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Consumer<UserProvider>(
                                          builder: (context,val6,child) {
                                            return SizedBox(
                                                width: fxdWidth,
                                                height: 43,
                                                child: profileTextField(val6.myProfileUPIIDEditingController, Colors.transparent,)

                                            );
                                          }
                                        )
                                      ],
                                    ),
                                  );
                                }
                              ),
                              const SizedBox(height: 20,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 42.0),
                                  child: Text("Registration ID",
                                    style: profileStyle,),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Consumer<UserProvider>(
                                    builder: (context,val17,child) {
                                      return SizedBox(
                                          width: fxdWidth,
                                          height: 43,
                                          child:  TextField(
                                            enabled: false,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.32,
                                            ),
                                            decoration: InputDecoration(
                                              filled: true,
                                              enabled: true,
                                              fillColor:Colors.transparent,
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                              disabledBorder:  const UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white,width: 0.5),
                                              ),
                                              enabledBorder: const UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),


                                              hintText: val17.registerID,
                                              hintStyle: const TextStyle(color: myWhite),
                                            ),
                                          )



                                      );
                                    }
                                  )
                                ],
                              ),
                              const SizedBox(height: 30,),
                               Consumer<UserProvider>(
                                 builder: (context3,value3,child) {
                                   return value3.editCheck2
                                   ?const SizedBox()
                                   :InkWell(
                                     onTap: () async {
                                       String generatedDeepLink=await FirebaseDynamicLinkService.createDynamicLink(true,value3.userPhone);
                                       Share.share('${"Lio club"}:\n\nDownload Lio club to read more and be updated $generatedDeepLink \nID: ${value3.userPhone}',
                                           subject:
                                           'Look what I made!');

                                     },
                                     child: const SizedBox(
                                      child: Text("Invite Member",
                                        style: TextStyle(
                                          color: myWhite,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),),
                                     ),
                                   );
                                 }
                               ),
                              const SizedBox(height: 10,),

                            ],
                          )),
                      const SizedBox(height: 10,),

                      Consumer<UserProvider>(
                        builder: (context,val50,child) {
                          return val50.editCheck2
                              ? InkWell(onTap: (){

                            final FormState? form = _formKey.currentState;
                            if (form!.validate()){
                            val50.editMyProfile(context,val50.registerID,val50.registerDocID,);
                            }

                          },
                            child: Container(
                              width: fxdWidth,
                              height: 40,
                              alignment: Alignment.center,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFFFFCF8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(44),
                                ),
                              ),
                              child: const Text(
                                'Save',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF2F7DC1),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ):const SizedBox();
                        }
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 33,
            top: 2,

            child: Consumer<UserProvider>(
                builder: (context, val, child) {
                return InkWell(
                  onTap: (){
                    if(val.editCheck2==true){
                    val.showBottomSheet(context, "PROFILE");}
                  },
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: textColor,
                    child:
                    val.fileImage!=null?CircleAvatar(
                      radius: 55,
                      backgroundImage: FileImage(
                        val.fileImage!,
                      ),
                    ): val.userProfileImage!=""?CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(
                        val.userProfileImage,
                      ),
                    ): const CircleAvatar(
                      radius: 55,
                      child: Icon(Icons.person_rounded),
                    ),
                  ),
                );
              }
            ),
          ),
          Positioned(
            right: 35,
            top: 80,
            child: Consumer<UserProvider>(
                builder: (context,va,child) {
                  return va.editCheck2==true? CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/edit.png",color: Colors.black,scale: 1.5,),
                  ):const SizedBox();
                }
            ),
          )
        ],
      )
    );
  }
}


