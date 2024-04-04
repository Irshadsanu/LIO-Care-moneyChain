
import 'package:flutter/material.dart';
import 'package:lio_care/User/screens/history_screen.dart';
import 'package:lio_care/User/screens/home_Screen.dart';
import 'package:lio_care/User/screens/menu_screen.dart';
import 'package:lio_care/User/screens/notification_Screen.dart';
import 'package:lio_care/User/screens/profile_screen.dart';
import 'package:lio_care/providers/mainProvider.dart';
import 'package:provider/provider.dart';
class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);

  @override
  List screens=[
    HomeScreen(userID: '',),
    const NotificationScreen(),
    const HistoryScreen(),
     ProfileScreen(),
    const MenuScreen(),
  ];
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context,value1,child) {
        return Scaffold(
          body:screens[value1.homePageIndex],
        );
      }
    );
  }
}
