///Not used

// import 'package:flutter/material.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
// import '../../User/screens/myAccount_screen.dart';
// import '../../constants/my_colors.dart';
//
// class BottomNavebar extends StatefulWidget {
//   const BottomNavebar({Key? key}) : super(key: key);
//
//   @override
//   State<BottomNavebar> createState() => _BottomNavebarState();
// }
//
// class _BottomNavebarState extends State<BottomNavebar> {
//   var _currentIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return SalomonBottomBar(
//       backgroundColor: Colors.white,
//       currentIndex: _currentIndex,
//       onTap: (i) => setState(() => _currentIndex = i),
//       items: [
//         /// Home
//         SalomonBottomBarItem(
//           icon: const Icon(Icons.home),
//           title:
//               Text("Home", style: TextStyle(fontSize: 11, color: Textcolor1)),
//           selectedColor: Textcolor1,
//         ),
//
//         /// Likes
//         SalomonBottomBarItem(
//           // icon: IconButton(onPressed: (){
//           //   callNext(const NotificationScreen(), context);
//           // }, icon:  const Icon(Icons.notifications)),
//           icon: const Icon(Icons.notifications),
//           title: const Text(
//             "Notification",
//             style: TextStyle(fontSize: 11),
//           ),
//           selectedColor: Textcolor1,
//         ),
//
//         /// Search
//         SalomonBottomBarItem(
//           icon: const Icon(
//             Icons.refresh,
//           ),
//           title: const Text("Refresh"),
//           selectedColor: Textcolor1,
//         ),
//
//         /// Profile
//         SalomonBottomBarItem(
//           icon: IconButton(
//             onPressed: () {
//               // showMenuPage(context);
//             },
//             icon: Icon(Icons.person),
//           ),
//           title: const Text("Profile"),
//           selectedColor: Textcolor1,
//         ),
//         SalomonBottomBarItem(
//           icon: const Icon(Icons.menu),
//           title: const Text("Menu"),
//           selectedColor: Textcolor1,
//         ),
//       ],
//     );
//   }
// }
