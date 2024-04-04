import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:lio_care/view/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Provider/admin_provider.dart';
import 'Provider/login_provider.dart';
import 'Provider/user_provider.dart';
import 'User/screens/animation.dart';
import 'Web/webHomeScreen.dart';
import 'admin/screens/admin_login_fixed_screen.dart';
import 'admin/screens/admin_login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final DatabaseReference mRootReference =
      FirebaseDatabase.instance.reference();
  String? packageName;
  int initialDataLimit = 1;
  late SharedPreferences prefs;

  Future<void> localDB() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // getReferralLink();
    localDB();
    getPackageName();
    // FirebaseAuth auth = FirebaseAuth.instance;

    super.initState();
    Timer(const Duration(seconds: 3), () async {
      LoginProvider loginProvider =
          Provider.of<LoginProvider>(context, listen: false);
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      AdminProvider adminProvider =
          Provider.of<AdminProvider>(context, listen: false);
      await userProvider.getAppVersion();
      // await userProvider.fetchLastOneTransaction();
      if (kIsWeb) {
        callNextReplacement(const WebHomeScreen(), context);
      } else {
        if (packageName == "com.spine.lio_club") {
          userProvider.lockApp();
          adminProvider.userTreeLock();
          var user = prefs.getString("appwrite_token");
          if (user == null) {
            getDynamicLink();
          } else {
            loginProvider.userAuthorized(
              "LOGIN",
              prefs.getString("phone_number").toString(),
              user,
              context,
            );
          }
        } else if (packageName == "com.spine.lio_admin") {
          adminProvider.adminLockApp();
          adminProvider.fetchTransactionHistory('splash', true);
          // adminProvider.listenToListLength();
          SharedPreferences userPreference =
              await SharedPreferences.getInstance();
          if (userPreference.getString("PHONE_NUMBER") != null &&
              userPreference.getString("PASSWORD") != null) {
            String? phoneNumber = userPreference.getString("PHONE_NUMBER");
            String? password = userPreference.getString("PASSWORD");
            loginProvider.adminAuthorized(phoneNumber, password, context);
          } else {
            userPreference.clear();
            callNextReplacement(const Admin_Login(), context);
          }
        } else {
          userProvider.payckagebool = true;
          callNextReplacement(AdminFixedLogin(), context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: ContainerRound())],
      ),
    );
  }

  Future<void> getDynamicLink() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    Uri? deepLink = data?.link;
    if (deepLink != null) {
      print("exist id$deepLink");
      String? id = deepLink.queryParameters['id'];
      print("deeplink Id $id");
      callNextReplacement(LoginScreen(referralId: id.toString()), context);
    } else {
      print("no id");
      callNextReplacement(LoginScreen(referralId: ''), context);
    }
  }

  Future<void> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      packageName = packageInfo.packageName;
    });
  }
}
