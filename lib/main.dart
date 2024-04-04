import 'dart:ui';


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lio_care/Provider/login_provider.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:lio_care/registration_test_page.dart';
import 'package:lio_care/splash_screen.dart';
import 'package:provider/provider.dart';
import 'User/screens/PMCAndPTCF_Screen.dart';
import 'User/screens/invitesScreen.dart';
import 'User/screens/payment_processing_screen.dart';
import 'User/screens/prc_screen.dart';
import 'Web/webHomeScreen.dart';
import 'admin/screens/admin_login_fixed_screen.dart';
import 'help_tree/tree_provider.dart';
import 'Provider/admin_provider.dart';
import 'Provider/donation_provider.dart';
// ... other imports

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(!kIsWeb){
    await Firebase.initializeApp();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    bool weWantFatalErrorRecording = true;
    FlutterError.onError = (errorDetails) {
      if (weWantFatalErrorRecording) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      } else {
        FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      }
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    // Set up database persistence
    FirebaseDatabase database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);

  }else{
    await Firebase.initializeApp(
        options:const FirebaseOptions(
            apiKey: "AIzaSyBv31q8fR28zmMVh9JwcXhZK0UiyS7eaM4",
            authDomain: "lio-club.firebaseapp.com",
            databaseURL: "https://lio-club-default-rtdb.firebaseio.com",
            projectId: "lio-club",
            storageBucket: "lio-club.appspot.com",
            messagingSenderId: "110399055384",
            appId: "1:110399055384:web:3f037b68b6405fd75e456d",
            measurementId: "G-V50VS9PVVL"
        )
    );
  }



  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value)=> runApp(const MyApp()));
}
// ◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DonationProvider(),),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => AdminProvider()),
        ChangeNotifierProvider(create: (context) => TreeProvider()),
      ],
      child: MaterialApp(
        title: 'Lio Club',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
       home:const SplashScreen(),
        // home: RegistrationTest(),
       //home:const PaymentProcessing(),
      // home: AdminFixedLogin(),
      ),
    );
  }
}
