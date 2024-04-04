import 'package:appwrite/appwrite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lio_care/Provider/login_provider.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../Provider/user_provider.dart';
import '../../constants/alerts.dart';
import '../../constants/my_colors.dart';
import '../../view/Widgets/reg_Screen_textformfield.dart';
import 'dart:math' as math;

enum MobileVarificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
  SHOW_MOBILE_FORM_VERIFIED,
}

class RegistrationScreen extends StatefulWidget {
  String referralId;
   RegistrationScreen({Key? key,required this.referralId}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  MobileVarificationState currentSate =
      MobileVarificationState.SHOW_MOBILE_FORM_STATE;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final otpController = TextEditingController();

  final FocusNode _pinPutFocusNode = FocusNode();
  late String verificationId;
  late var tocken;
  bool showLoading = false;

  // bool showTick = false;
  String code = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> signInWithPhoneAuthCredential(
      BuildContext context, PhoneAuthCredential phoneAuthCredential) async {
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    if (kDebugMode) {
      print('done 1  $phoneAuthCredential');
    }
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);
      if (kDebugMode) {
        print(' 1  $phoneAuthCredential');
      }
      setState(() {
        showLoading = false;
      });
      try {
        var loginUser = authCredential.user;
        if (loginUser != null) {
          // var phone = loginUser.phoneNumber!.substring(3, 13);
          db
              .collection("USERS")
              .where("MOBILE", isEqualTo: loginUser.phoneNumber!)
              .get()
              .then((value) {
            if (value.docs.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Already a member"),
                duration: Duration(milliseconds: 3000),
              ));
              loginProvider.userAuthorized("LOGIN",loginUser.phoneNumber,tocken, context);
            } else {
              setState(() {
                currentSate = MobileVarificationState.SHOW_MOBILE_FORM_VERIFIED;
              });
            }
          });

          if (kDebugMode) {
            print("Login Success");
          }
        }
      } catch (e) {
        const snackBar = SnackBar(
          content: Text('Otp failed'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (kDebugMode) {
          print(e.toString());
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          e.message ?? "",
        ),
      ));
    }
  }
  Client client = Client();
  @override
  void initState() {
    // TODO: implement initState
    client
        .setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite Endpoint
        .setProject('657962d6410db35e909f') // Your project ID
        .setSelfSigned();
    super.initState();
  }


  Future<void> verify(String phoneNumber) async {
    final account = Account(client);
    try {
      final session = await account.updatePhoneSession(
          userId: verificationId, secret: otpController.text);

      setState(() {
        showLoading = true;
      });

      try {
        print("454545");
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // final loginUser = prefs.getString('appwrite_token');
        // final phonenum = prefs.getString('phone_number');





          LoginProvider loginProvider = LoginProvider();
          var phone = phoneNumber.substring(3, 13);
          db
              .collection("USERS")
              .where("PHONE", isEqualTo: phone)
              .get()
              .then((value) {
            if (value.docs.isNotEmpty) {
              // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //   content: Text("Already a member"),
              //   duration: Duration(milliseconds: 3000),
              // ));
              loginProvider.userAuthorized("LOGIN",phoneNumber, tocken,context);
            } else {
              setState(() {
                currentSate = MobileVarificationState.SHOW_MOBILE_FORM_VERIFIED;
                showLoading = false;
              });
            }
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(
            content: Text("Verification Completed"),
            duration: Duration(milliseconds: 3000),
          ));


          if (kDebugMode) {
            print("Login Success");
          }

      } catch (e) {
        const snackBar = SnackBar(
          content: Text('Otp failed'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text("login successfully"),
      //     backgroundColor: Colors.purple,
      //   ),
      // );
      // Process the successful response if needed
    } catch (e) {
      if (e is AppwriteException) {
        // Handle AppwriteException
        final errorMessage = e.message ?? 'An error occurred.';

        // Display the error message using a Snackbar
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(errorMessage),
        //     backgroundColor: Colors.purple,
        //   ),
        // );
      } else {
        // Handle other types of exceptions or errors
        print('An unexpected error occurred: $e--irsh');
      }
    }

    // print(session.userId.toString()+"irsh");

    // print(session.providerAccessToken+"irshad");
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgrnd,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
     title: const Text(
          "Registration",

          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: cl2F7DC1,
              fontFamily: "PoppinsRegular"),
        ),
        backgroundColor: backgrnd,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: SingleChildScrollView(
          child: Consumer<LoginProvider>(builder: (context6, valu, child) {
            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * .05,
                  ),

                  TextFormField(
                    controller: userProvider.phoneNumberController,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    onChanged: (value) {
                      if (value.trim().length == 10) {
                        userProvider.showTick = true;
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                      } else {
                        userProvider.showTick = false;
                        currentSate =
                            MobileVarificationState.SHOW_MOBILE_FORM_STATE;
                      }
                      setState(() {});
                    },
                    keyboardType: TextInputType.phone,
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Mobile Number",
                      labelStyle: TextStyle(
                          color: cl5F5F5F.withOpacity(.7),
                          fontWeight: FontWeight.w400),
                      // hintText: "Mobile Number",
                      // hintStyle: TextStyle(
                      //     color: cl5F5F5F.withOpacity(.7),
                      //     fontWeight: FontWeight.w400),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 15.0, top: 15.0, right: 14),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: clff731d),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: clff731d),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      suffixIcon: userProvider.showTick
                          ? InkWell(
                              onTap: () async {
                                setState(() {
                                  if (userProvider
                                          .phoneNumberController.text.length ==
                                      10) {
                                    showLoading = true;
                                  }
                                });

                                final account = Account(client);
                                try {
                                  final sessionToken = await account.createPhoneSession(
                                      userId: ID.unique(),
                                      phone: '+91${userProvider.phoneNumberController.text}');

                                  verificationId = sessionToken.userId;
                                  tocken = sessionToken.$id;


                                  setState(() {
                                    showLoading = false;
                                    currentSate =
                                        MobileVarificationState.SHOW_OTP_FORM_STATE;


                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("OTP sent to phone successfully"),
                                      duration: Duration(milliseconds: 3000),
                                    ));
                                  });


                                  // SharedPreferences prefs = await SharedPreferences.getInstance();
                                  // prefs.setString('appwrite_token', sessionToken.$id);
                                  // prefs.setString('phone_number', '+91${userProvider.phoneNumberController.text}');



                                } catch (e) {
                                  if (e is AppwriteException) {
                                    setState(() {
                                      showLoading = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Sorry, Verification Failed fdjkghd"),
                                      duration: Duration(milliseconds: 3000),
                                    ));
                                  } else {
                                    setState(() {
                                      showLoading = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Sorry, Verification Failed plpl"),
                                      duration: Duration(milliseconds: 3000),
                                    ));
                                    // Handle other types of exceptions or errors
                                    print('An unexpected error occurred: $e  --irsh');
                                  }
                                }

                                // await auth.verifyPhoneNumber(
                                //     phoneNumber:
                                //         "+91${userProvider.phoneNumberController.text}",
                                //     verificationCompleted:
                                //         (phoneAuthCredential) async {
                                //       setState(() {
                                //         showLoading = false;
                                //       });
                                //       ScaffoldMessenger.of(context)
                                //           .showSnackBar(const SnackBar(
                                //         content: Text("Verification Completed"),
                                //         duration: Duration(milliseconds: 3000),
                                //       ));
                                //       if (kDebugMode) {}
                                //     },
                                //     verificationFailed:
                                //         (verificationFailed) async {
                                //       setState(() {
                                //         showLoading = false;
                                //       });
                                //       ScaffoldMessenger.of(context)
                                //           .showSnackBar(const SnackBar(
                                //         content:
                                //             Text("Sorry, Verification Failed"),
                                //         duration: Duration(milliseconds: 3000),
                                //       ));
                                //       if (kDebugMode) {
                                //         print(verificationFailed.message
                                //             .toString());
                                //       }
                                //     },
                                //     codeSent:
                                //         (verificationId, resendingToken) async {
                                //       setState(() {
                                //         showLoading = false;
                                //         currentSate = MobileVarificationState
                                //             .SHOW_OTP_FORM_STATE;
                                //         this.verificationId = verificationId;
                                //
                                //         ScaffoldMessenger.of(context)
                                //             .showSnackBar(const SnackBar(
                                //           content: Text(
                                //               "OTP sent to phone successfully"),
                                //           duration: Duration(milliseconds: 3000),
                                //         ));
                                //
                                //         if (kDebugMode) {
                                //           print("");
                                //         }
                                //       });
                                //     },
                                //     codeAutoRetrievalTimeout:
                                //         (verificationId) async {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 15.0, top: 15, bottom: 15),
                                child: showLoading
                                    ? SizedBox(
                                        height: 10,
                                        width: 5,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1,
                                          color: clFF731D,
                                        ),
                                      )
                                    : Text(
                                        currentSate !=
                                                MobileVarificationState
                                                    .SHOW_MOBILE_FORM_VERIFIED
                                            ? "Verify"
                                            : "Verified",
                                        style: TextStyle(
                                          color: userProvider.showTick == false
                                              ? cl16AD00
                                              : currentSate !=
                                                      MobileVarificationState
                                                          .SHOW_MOBILE_FORM_VERIFIED
                                                  ? clFF731D
                                                  : cl16AD00,
                                        ),
                                      ),
                              ))
                          : Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, top: 15, bottom: 15),
                              child: Text("Verify",
                                  style: TextStyle(color: clFF731D)),
                            ),
                    ),

                    //controller: regValue.userMobileNumberController,
                    style: const TextStyle(
                        fontFamily: 'BarlowCondensed',
                        fontWeight: FontWeight.bold),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please Enter The Mobile Number";
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value) ||
                          value.trim().length < 10) {
                        return "Enter Correct Number";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 30,),
                  if (currentSate == MobileVarificationState.SHOW_OTP_FORM_STATE)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "OTP",
                            style: TextStyle(
                                color: cl5F5F5F.withOpacity(.7),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontFamily: "PoppinsRegular"),
                          ),
                          PinFieldAutoFill(
                            codeLength: 6,
                            focusNode: _pinPutFocusNode,
                            keyboardType: TextInputType.number,
                            autoFocus: true,
                            controller: otpController,
                            currentCode: "",
                            decoration: BoxLooseDecoration(
                              bgColorBuilder: const FixedColorBuilder(cWhite),
                              strokeWidth: 2,
                              textStyle: const TextStyle(color: cBlack),
                              radius: const Radius.circular(30),
                              strokeColorBuilder:
                                  const FixedColorBuilder(clff731d),
                            ),
                            onCodeChanged: (pin) {
                              if (pin!.length == 6) {
                                verify('+91${userProvider.phoneNumberController.text}');
                                // PhoneAuthCredential phoneAuthCredential =
                                //     PhoneAuthProvider.credential(
                                //         verificationId: verificationId,
                                //         smsCode: pin);
                                // signInWithPhoneAuthCredential(
                                //     context, phoneAuthCredential);
                                otpController.text = pin;
                                setState(() {
                                  code = pin;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  currentSate != MobileVarificationState.SHOW_MOBILE_FORM_VERIFIED
                      ? const SizedBox()
                      :  Consumer<UserProvider>(builder: (context, val2, child) {
                          return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                          TextForm(
                              labelText: "Name", txtController: val2.userNameCT),
                          const SizedBox(height: 30,),
                      TextForm(
                          labelText: "Email Address", txtController: val2.userEmailCT),

                          const SizedBox(height: 30,),
                          TextForm(labelText: "Referral ID/Mobile Number", txtController:val2.userReferralCT ),
                      ///
                    // Text(widget.referralId),

                          const SizedBox(height: 30,),
                          TextForm(
                            labelText: "UPI ID",
                            txtController: val2.userUPICT,),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 9),
                            child: Text(
                              "How to get UPI ID ?",
                              style: TextStyle(
                                  color: cl5F5F5F.withOpacity(.5),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  fontFamily: "PoppinsRegular"),
                            ),
                          ),
                          Text(
                            "UPI App",
                            style: TextStyle(
                                color: cl5F5F5F.withOpacity(.7),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontFamily: "PoppinsRegular"),
                          ),
                          const SizedBox(height: 6,),
                          Consumer<UserProvider>(
                            builder: (context, val1, child) {
                              return InkWell(
                                onTap: () {
                                  val1.containerDrop();
                                },
                                child: Container(
                                  height: val1.dropImage == "" ? 53 : 63,
                                  width: width / 1.1,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: cWhite,
                                      borderRadius: val2.showContainer
                                          ? const BorderRadius.only(
                                          bottomLeft: Radius.zero,
                                          bottomRight: Radius.zero,
                                          topLeft: Radius.circular(26.5),
                                          topRight: Radius.circular(26.5))
                                          : BorderRadius.circular(26.5)),
                                  child: Row(
                                    children: [
                                      val1.dropImage != ""
                                          ? CircleAvatar(
                                        backgroundColor: clF3F3F3,
                                        child: Center(
                                          child: Image.asset(
                                            val1.dropImage,
                                            scale: 4,
                                          ),
                                        ),
                                      )
                                          : const SizedBox(),
                                      const SizedBox(width: 5),
                                      val1.dropText != ""
                                          ? Text(val1.dropText)
                                          : const Text(
                                        "Select UPI App",
                                        style: TextStyle(color: cl5F5F5F),
                                      ),
                                      const Spacer(),
                                      val2.showContainer
                                          ? CircleAvatar(
                                        radius: 15,
                                        backgroundColor: clF3F3F3,
                                        child: Center(
                                          child: Transform.rotate(
                                              angle: -math.pi / -2,
                                              child: const Icon(
                                                Icons.arrow_back_ios_sharp,
                                                color: cBlack,
                                                size: 15,
                                              )),
                                        ),
                                      )
                                          : CircleAvatar(
                                        radius: 15,
                                        backgroundColor: clF3F3F3,
                                        child: Center(
                                          child: Transform.rotate(
                                              angle: -math.pi / 2,
                                              child: const Icon(
                                                Icons.arrow_back_ios_sharp,
                                                color: cBlack,
                                                size: 15,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          val2.showContainer
                              ? Container(

                            height: 215,
                            width: width / 1.1,
                            decoration: const BoxDecoration(
                                color: cWhite,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(26.5),
                                    bottomLeft: Radius.circular(26.5))),
                            child: Column(
                              children: [
                                Divider(color: backgrnd, thickness: 3),
                                InkWell(
                                    onTap: () {
                                      val2.dropSelect(
                                          "assets/GooglePay.png", 'Google Pay');
                                      val2.showContainer = false;
                                      val2.isUpiSelected = false;
                                    },
                                    child: SizedBox(
                                      height: 53,
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 47,
                                            backgroundColor: clF3F3F3,
                                            child: Center(
                                              child: Image.asset(
                                                "assets/GooglePay.png",
                                                scale: 3.5,
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            'Google Pay',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    )),
                                Divider(color: backgrnd, thickness: 3),
                                InkWell(
                                    onTap: () {
                                      val2.dropSelect("assets/PaytmNew.png", 'Paytm');
                                      val2.showContainer = false;
                                      val2.isUpiSelected = false;
                                    },
                                    child: SizedBox(
                                      height: 53,
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 47,
                                            backgroundColor: clF3F3F3,
                                            child: Center(
                                              child: Image.asset(
                                                "assets/PaytmNew.png",
                                                scale: 2.5,
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            'Paytm',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    )),
                                Divider(color: backgrnd, thickness: 3),
                                InkWell(
                                    onTap: () {
                                      val2.dropSelect(
                                          "assets/BIHMMoney.png", 'BHIM');
                                      val2.showContainer = false;
                                      val2.isUpiSelected = false;
                                    },
                                    child: SizedBox(
                                      height: 53,
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 47,
                                            backgroundColor: clF3F3F3,
                                            child: Center(
                                              child: Image.asset(
                                                "assets/BIHMMoney.png",
                                                scale: 3,
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            'BHIM',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          )
                              : const SizedBox(),
                          // val2.showContainer
                          //     ? SizedBox(
                          //   height: ,
                          // )
                          //     : const SizedBox(),
                      val2.isUpiSelected
                      ? const Padding(
                        padding: EdgeInsets.only(left: 25.0,top: 5),
                        child: Text(
                          "Please select UPI app",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontFamily: "PoppinsRegular"),
                        ),
                      ) :const SizedBox(),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Consumer<UserProvider>(
                            builder: (context3, checkboxModel, child) {
                              return CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 12,
                                child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: const CircleBorder(),
                                  value: checkboxModel.isChecked,
                                  onChanged: (newValue) {
                                    checkboxModel.toggleCheckbox();
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'I have read and accepted all ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              alertTermsAndConditions(context);
                            },
                            child: Text(
                              'Terms & Conditions',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                          keyboardIsVisible(context)
                              ? const SizedBox()
                              : SizedBox(
                            height: height / 9,
                          ),



                    ],
                  );
                        }
                      ),
                  currentSate != MobileVarificationState.SHOW_MOBILE_FORM_VERIFIED
                      ?  SizedBox(height: height/1.5,)
                      : const SizedBox(),
                  Consumer<UserProvider>(
                    builder: (context7,value2,child) {
                      return InkWell(
                        onTap: () {
                          if (currentSate ==
                              MobileVarificationState.SHOW_MOBILE_FORM_VERIFIED) {
                            var form = formKey.currentState;
                            if (form!.validate()) {
                              if(value2.isChecked){
                              if(value2.dropText != "") {

                                userProvider.userRegistration(value2.userReferralCT.text.trim(),tocken,context);
                                value2.isUpiSelected = false;
                              }else{
                                value2.isUpiSelected = true;
                                value2.notifyListeners();
                              }}else{
                                const snackBar = SnackBar(
                                  content: Text("Kindly agree to the terms and conditions."),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);



                              }
                            }
                            if(value2.dropText == "") {
                              value2.isUpiSelected = true;
                              value2.notifyListeners();
                            }
                          }
                        },
                        child: Container(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width * 0.89,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                clFF731D,
                                clFFAC7B,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Next',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontFamily: "PoppinsRegular"),
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                  const SizedBox(height: 10,)
                ],
              ),
            );
          }),
        ),
      ),

    );
  }
}
