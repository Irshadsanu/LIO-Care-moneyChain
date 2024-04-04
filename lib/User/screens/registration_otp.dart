// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// enum MobileVarificationState {
//   SHOW_MOBILE_FORM_STATE,
//   SHOW_OTP_FORM_STATE,
//   SHOW_MOBILE_FORM_VERIFIED,
// }
// class RegistrationOTP extends StatefulWidget {
//   const RegistrationOTP({Key? key}) : super(key: key);
//
//   @override
//   State<RegistrationOTP> createState() => _RegistrationOTPState();
// }
//
// class _RegistrationOTPState extends State<RegistrationOTP> {
//   MobileVarificationState currentSate =
//       MobileVarificationState.SHOW_MOBILE_FORM_STATE;
//   final otpController = TextEditingController();
//   final FocusNode _pinPutFocusNode=FocusNode();
//   late String verificationId;
//   bool showLoading = false;
//   // bool showTick = false;
//   String code = "";
//   FirebaseAuth auth = FirebaseAuth.instance;
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   Future<void> signInWithPhoneAuthCredential(
//       BuildContext context, PhoneAuthCredential phoneAuthCredential) async {
//     if (kDebugMode) {
//       print('done 1  $phoneAuthCredential');
//     }
//     setState(() {
//       showLoading = true;
//     });
//     try {
//       final authCredential =
//       await auth.signInWithCredential(phoneAuthCredential);
//       if (kDebugMode) {
//         print(' 1  $phoneAuthCredential');
//       }
//       setState(() {
//         showLoading = false;
//       });
//       try {
//         var loginUser = authCredential.user;
//         if (loginUser != null) {
//
//           LoginProvider loginProvider = LoginProvider();
//           var phone = loginUser.phoneNumber!.substring(3,13);
//           db.collection("USERS").where("MOBILE",isEqualTo:phone ).get().then((value) {
//             if (value.docs.isNotEmpty) {
//               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                 content: Text("Already a member"),
//                 duration: Duration(milliseconds: 3000),
//               ));
//               loginProvider.userAuthorized(loginUser.phoneNumber, context);
//             }else{
//               setState(() {
//                 currentSate = MobileVarificationState.SHOW_MOBILE_FORM_VERIFIED;
//               });
//             }
//           });
//
//
//           if (kDebugMode) {
//             print("Login Success");
//           }
//         }
//       } catch (e) {
//         const snackBar = SnackBar(
//           content: Text('Otp failed'),
//         );
//
//         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//         if (kDebugMode) {
//           print(e.toString());
//         }
//       }
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         showLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         backgroundColor: Colors.white,
//         content: Text(
//           e.message ?? "",
//         ),
//       ));
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Container();
//   }
// }
