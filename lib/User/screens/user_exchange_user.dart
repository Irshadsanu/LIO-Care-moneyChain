import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../Constants/functions.dart';
import '../../Provider/admin_provider.dart';
import '../../constants/my_colors.dart';

class UserExchangeUserScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UserExchangeUserScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bxkclr,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: bxkclr,
        elevation: 0,
        leadingWidth: 100,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              finish(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: textColor,
                  ),
                  Image.asset(
                    "assets/bluelogo.png",
                    scale: 18,
                  ),
                ],
              ),
            )),
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            'Exchange Members',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontFamily: 'PoppinsRegular',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Consumer<AdminProvider>(builder: (context, valuee, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Consumer<AdminProvider>(
                        builder: (context, value2, child) {
                      return SizedBox(

                        width: 140,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
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
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
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
                              onChanged: (text) {
                                if (value2.fromController.text.length == 15) {
                                  value2.registrationIdExchange(
                                      value2.fromController.text, "FROM");
                                } else{
                                  value2.clearExchangeControllers("FROM");
                                }
                              },
                              validator: (txt) {
                                if (txt!.trim().isEmpty) {
                                  return "Enter ID";
                                } else {
                                  return null;
                                }
                              }),
                        ),
                      );
                    }),
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
                        builder: (context, value1, child) {
                      return SizedBox(
                        width: 140,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 5,
                          shadowColor: Colors.white.withOpacity(0.5),
                          child: TextFormField(
                            inputFormatters:[
                              LengthLimitingTextInputFormatter(15)
                            ],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 13),
                            controller: value1.toController,
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: Colors.white)),
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
                            onChanged: (text) {
                              if (value1.toController.text.length == 15) {
                                value1.registrationIdExchange(
                                    value1.toController.text, "TO");
                              } else{
                                value1.clearExchangeControllers("TO");
                              }
                            },
                            validator: (txt) {
                              if (txt!.trim().isEmpty) {
                                return "Enter ID";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),

                ///edit
                Consumer<AdminProvider>(builder: (context, value2, child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10),
                    child: Row(
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
                            title2: value2.exchangeToRegID,
                            title3: value2.exchangeToPhone),
                      ],
                    ),
                  );
                }),
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
                Consumer<AdminProvider>(builder: (context, val22, child) {
                  return SizedBox(
                    height: 250,
                    width: width / 1.1,
                    child: ListView.builder(
                      itemCount: 5,
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
                            child: Row(
                              children: [
                                Radio(
                                  value: val22.exchangeReasons[index],
                                  groupValue: val22.selectedExchange,
                                  onChanged: (value) {
                                    val22.radioForExchange(value);
                                  },
                                ),
                                Text(
                                  val22.exchangeReasons[index],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "PoppinsRegular"),
                                ),
                              ],
                            ));
                      },
                    ),
                  );
                }),
                Consumer<AdminProvider>(builder: (context, val23, child) {
                  return val23.exchangeOtherCheck == true
                      ? Container(
                          alignment: Alignment.center,
                          decoration:
                              BoxDecoration(color: myWhite, boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 2),
                              blurRadius: 1,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ]),
                          width: width / 1.1,
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
                                borderSide: BorderSide(
                                    color: Colors.white, width: 0.5),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 0.5),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 0.5),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 0.5),
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
                                return "Enter Reason";
                              } else {
                                return null;
                              }
                            },
                          ),
                        )
                      : const SizedBox();
                }),

                valuee.fileImage != null
                    ? Padding(
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
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[300],
                                        radius: 12,
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffEDEDED),
                                    image: DecorationImage(
                                        fit: BoxFit.fitHeight,
                                        image: FileImage(valuee.fileImage!))),
                                height: 472,
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),

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
                        color: myWhite,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 2),
                            blurRadius: 1,
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ]),
                    width: width / 1.1,
                    height: 60,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Upload Proof',
                            style: TextStyle(
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
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                      height: 50,
                      width: 350,
                      child: Consumer<UserProvider>(
                          builder: (context, userpro, child) {
                        return Consumer<AdminProvider>(
                            builder: (context, value3, child) {
                          return value3.exchangeUserBool == false
                              ? MaterialButton(
                                  onPressed: () {
                                    if (value3.fileImage != null) {
                                      final FormState? form =
                                          _formKey.currentState;
                                      if (form!.validate()) {
                                        userpro.userExchangeRequest(
                                          context,
                                            userpro.registerID,
                                            value3.fileImage,
                                            value3.fromController,
                                            value3.toController,
                                            value3.exChangeController,
                                            value3.selectedExchange);

                                      }
                                    } else {
                                      final snackDemo = SnackBar(
                                        content: const SizedBox(
                                          width: 284,
                                          height: 20,
                                          child: Text(
                                            "Upload Image",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
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
                                  },
                                  color: const Color(0xff1746A2),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50)),
                                  child: const Text(
                                    'Send Request',
                                    style: TextStyle(
                                        fontFamily: 'PoppinsRegular',
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              : const SizedBox();
                        });
                      })),
                ),
              ],
            );
          }),
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
          padding: const EdgeInsets.only(top: 10, left: 11, bottom: 10),
          // height: 89,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title1,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    fontFamily: 'PoppinsRegular'),
              ),
              const SizedBox(
                height: 5,
              ),
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
