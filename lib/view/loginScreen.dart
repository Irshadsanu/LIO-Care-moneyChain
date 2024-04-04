import 'package:appwrite/appwrite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../Provider/login_provider.dart';
import '../Provider/user_provider.dart';
import '../User/screens/regNumberVerification_Screen.dart';
import '../constants/my_colors.dart';

enum MobileVarificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
  SHOW_MOBILE_FORM_VERIFIED,
}

class LoginScreen extends StatefulWidget {
  String referralId;
  LoginScreen({Key? key, required this.referralId}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVarificationState currentSate =
      MobileVarificationState.SHOW_MOBILE_FORM_STATE;

  bool showTick = false;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  Client client = Client();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    client
        .setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite Endpoint
        .setProject('657962d6410db35e909f') // Your project ID
        .setSelfSigned();
    fixedOtpChecking();
  }

  @override
  late BuildContext context2;
  String code = "";
  late String verificationId;
  late var tocken;
  bool showLoading = false;
  bool otpPage = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  LoginProvider loginProvider = LoginProvider();


  List<String> fixedOtpList = [];

  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  void fixedOtpChecking(){
    fixedOtpList.clear();

    setState(() {

      mRoot.child("FIXED_OTP").onValue.listen((databaseEvent) {
        if(databaseEvent.snapshot.exists){
          fixedOtpList.clear();
          Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;
          map.forEach((key, value) {
            fixedOtpList.add(key.toString());
          });
        }
      });
    });


  }

  // void checkValueForKey(String targetKey,String pin) {
  //
  //   setState(() {
  //     mRoot.child("FIXED_OTP").onValue.listen((databaseEvent) {
  //       if (databaseEvent.snapshot.exists) {
  //         Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;
  //
  //         map.forEach((key, value) {
  //           String keyControllerValue = key.toString();
  //           String valueControllerValue = value.toString();
  //
  //           if (keyControllerValue == targetKey) {
  //             // The targetKey exists in the database
  //             // Do something with the corresponding value
  //             print("Value for key $targetKey is $valueControllerValue");
  //
  //             if(valueControllerValue==pin){
  //               loginProvider.userAuthorized("LOGIN","+91${phoneController.text}", "tocken",context);
  //             }
  //
  //           }
  //         });
  //       }
  //     });
  //   });
  // }

  void checkValueForKey(String targetKey,String pin) {

    setState(() {
      mRoot.child('FIXED_OTP').child(targetKey).onValue.listen((event) {
        if(event.snapshot.exists){
          String valueControllerValue=event.snapshot.value.toString();
          if(valueControllerValue==pin){
            // The targetKey exists in the database
            // Do something with the corresponding value
            print("Value for key $targetKey is $valueControllerValue");
            loginProvider.userAuthorized("LOGIN","+91$targetKey", "tocken",context);

          }
        }
      });
    });
  }

  Future<void> signInWithPhoneAuthCredential(
      BuildContext context, PhoneAuthCredential phoneAuthCredential) async {
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
          LoginProvider loginProvider = LoginProvider();
          var phone = loginUser.phoneNumber!.substring(3, 13);
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
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.black54,
        content: Text(
          "Enter Correct OTP!!!",
          style: TextStyle(color: Colors.white),
        ),
      ));
    }
  }

  Future<void> otpsend() async {
    final account = Account(client);
    final sessionToken = await account.createPhoneSession(
        userId: ID.unique(), phone: '+91${phoneController.text}');

    verificationId = sessionToken.userId;
    tocken = sessionToken.$id;
    print(verificationId.toString() + "123456");
  }

  Future<void> verify() async {
    final account = Account(client);
    try {

      final session = await account.updatePhoneSession(
          userId: verificationId, secret: otpController.text);


      setState(() {
        showLoading = true;
      });

      try {

        print("object ddddddd");

        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // final loginUser = prefs.getString('appwrite_token');
        // final phonenum = prefs.getString('phone_number');


          print("sfsfsfsfsfsf");

          // var phone = phonenum!.substring(3, 13);
          var phone = phoneController.text.trim();
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
              loginProvider.userAuthorized("LOGIN","+91$phone", tocken,context);
            } else {
              setState(() {
                currentSate = MobileVarificationState.SHOW_MOBILE_FORM_VERIFIED;
              });
            }
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Login Success"),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.purple,
          ),
        );
      } else {
        // Handle other types of exceptions or errors
        print('An unexpected error occurred: $e');
      }
    }

    // print(session.userId.toString()+"dsc");

    // print(session.providerAccessToken+"789456");
  }

  final FocusNode _pinPutFocusNode = FocusNode();

  Widget getMobileFormWidget(context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print(width);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgrnd,
        elevation: 0,
        leadingWidth: 70,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Image.asset(
          "assets/bluelogo.png",
          scale: 14,
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            'Verification',
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
      backgroundColor: backgrnd,
      body: Column(
        children: [
          Center(
            child: SizedBox(
                height: height / 4,
                width: width / 1.429090909090909,
                child: const Image(
                  image: AssetImage("assets/veriImage.png"),
                  fit: BoxFit.fill,
                )),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 19, right: 19,),
            child: TextField(
              controller: phoneController,
              autofocus: false,
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: "PoppinsRegular"),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Enter Your Mobile Number",
                hintStyle: TextStyle(color: cl5F5F5F.withOpacity(.7)),
                contentPadding:
                    const EdgeInsets.only(left: 20.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: clff731d),
                  borderRadius: BorderRadius.circular(25.7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: clff731d),
                  borderRadius: BorderRadius.circular(25.7),
                ),
              ),
              onChanged: (value) {
                if (value.trim().length == 10) {
                  showTick = true;
                  // SystemChannels.textInput.invokeMethod('TextInput.hide');
                } else {
                  showTick = false;
                }

                setState(() {});
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10)
              ],
            ),
          ),
          Spacer(),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 53.0,
        width: MediaQuery.of(context).size.width / 1.1,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [clFF731D, clFFAC7B]),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ElevatedButton(
          onPressed: () async {
            setState(() {
              if (phoneController.text.length == 10) {
                showLoading = true;
              }
            });



            if (showTick) {
              if(fixedOtpList.contains(phoneController.text.toString())){
                setState(() {
                  currentSate = MobileVarificationState
                      .SHOW_OTP_FORM_STATE;
                });

              }else{
              db
                  .collection("USERS")
                  .where("PHONE", isEqualTo: phoneController.text)
                  .get()
                  .then((value) async {
                if (value.docs.isNotEmpty) {
                  // otpsend();
                  final account = Account(client);
                  try {
                    final sessionToken = await account.createPhoneSession(
                        userId: ID.unique(),
                        phone: '+91${phoneController.text}');

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

                  } catch (e) {
                    if (e is AppwriteException) {
                            setState(() {
                              showLoading = false;
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Sorry, Verification Failed"),
                              duration: Duration(milliseconds: 3000),
                            ));
                    } else {
                      setState(() {
                        showLoading = false;
                      });
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                        content: Text("Sorry, Verification Failed"),
                        duration: Duration(milliseconds: 3000),
                      ));
                      // Handle other types of exceptions or errors
                      print('An unexpected error occurred: $e');
                    }
                  }
                  // await auth.verifyPhoneNumber(
                  //     phoneNumber: "+91${phoneController.text}",
                  //     verificationCompleted: (phoneAuthCredential) async {
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
                  //     verificationFailed: (verificationFailed) async {
                  //
                  //       setState(() {
                  //         showLoading = false;
                  //       });
                  //       ScaffoldMessenger.of(context)
                  //           .showSnackBar(const SnackBar(
                  //         content: Text("Sorry, Verification Failed"),
                  //         duration: Duration(milliseconds: 3000),
                  //       ));
                  //       if (kDebugMode) {
                  //         print(verificationFailed.message.toString());
                  //       }
                  //     },
                  //     codeSent: (verificationId, resendingToken) async {
                  //       setState(() {
                  //         showLoading = false;
                  //         currentSate =
                  //             MobileVarificationState.SHOW_OTP_FORM_STATE;
                  //         this.verificationId = verificationId;
                  //
                  //         ScaffoldMessenger.of(context)
                  //             .showSnackBar(const SnackBar(
                  //           content: Text("OTP sent to phone successfully"),
                  //           duration: Duration(milliseconds: 3000),
                  //         ));
                  //
                  //         if (kDebugMode) {
                  //           print("");
                  //         }
                  //       });
                  //     },
                  //     codeAutoRetrievalTimeout: (verificationId) async {});
                }
                else {
                  setState(() {
                    showLoading = false;
                  });
                  const snackBar = SnackBar(
                    content: Text('Not a member register first'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // registrationProvider.userMobileNumberController.text = phoneController.text.trim();
                  // registrationProvider.showTick=true;
                  // registrationProvider.clearRegisterCandidate();
                  userProvider.clearRegistrationField();
                  userProvider.showTick = true;
                  userProvider.phoneNumberController.text =
                      phoneController.text;
                  userProvider.userReferralCT.text = widget.referralId;
                  callNext(
                      RegistrationScreen(
                        referralId: widget.referralId,
                      ),
                      context);
                }
              });
            }}
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent, shadowColor: Colors.transparent),
          child: showLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Text(
                  "Request OTP",
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ),
    );
  }

  Widget getOtpFormWidget(context) {
    const preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
        )
      ],
    );
    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgrnd,
        elevation: 0,
        leadingWidth: 100,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              // finish(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  // Icon(Icons.arrow_back_ios,color: textColor,),
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
            'Verification',
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

      // appBar: AppBar(
      //   backgroundColor: backgrnd,
      //   elevation: 0,
      //   title: Center(
      //       child: Text(
      //     "Verification",
      //     style: TextStyle(
      //         fontWeight: FontWeight.w700,
      //         fontSize: 20,
      //         color: textColor,
      //         fontFamily: "PoppinsRegular"),
      //   )),
      // ),
      backgroundColor: backgrnd,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(),
              child: SizedBox(
                  height: height / 4,
                  width: width / 1.332203389830508,
                  child: const Image(
                    image: AssetImage("assets/otpImage.png"),
                    fit: BoxFit.fill,
                  )),
            ),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  "Enter Your OTP",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: textclr2,
                      fontFamily: "PoppinsRegular"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: SizedBox(
                    height: 70,
                    width: width / 1.2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PinFieldAutoFill(
                        codeLength: 6,
                        focusNode: _pinPutFocusNode,
                        keyboardType: TextInputType.number,
                        autoFocus: true,
                        controller: otpController,
                        currentCode: "",
                        decoration: BoxLooseDecoration(
                          strokeWidth: 3,
                          textStyle: const TextStyle(color: Colors.black),
                          radius: const Radius.circular(15),
                          strokeColorBuilder:
                          const FixedColorBuilder(Color(0xffccc8bc)),
                        ),
                        onCodeChanged: (pin) {
                          if (pin!.length == 6) {
                            // PhoneAuthCredential phoneAuthCredential =
                            //     PhoneAuthProvider.credential(
                            //         verificationId: verificationId, smsCode: pin);
                            // signInWithPhoneAuthCredential(
                            //     context, phoneAuthCredential);

                            if(fixedOtpList.contains(phoneController.text)){
                              checkValueForKey(phoneController.text.toString(),otpController.text.toString());
                            }else{
                              verify();
                            }
                            otpController.text = pin;
                            setState(() {
                              code = pin;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),


          Spacer(),
          const SizedBox(
            height: 50,
          )
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          // callNextReplacement(BottomNavigationScreen(), context);
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
              'Submit',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: myWhite,
          key: scaffoldKey,
          body: Container(
            child: currentSate == MobileVarificationState.SHOW_MOBILE_FORM_STATE
                ? getMobileFormWidget(context)
                : getOtpFormWidget(context),
            // padding: const EdgeInsets.all(16),
          )),
    );
  }
}
