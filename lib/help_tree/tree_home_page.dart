// import 'package:flutter/material.dart';
// import 'package:lio_care/Provider/user_provider.dart';
// import 'package:lio_care/constants/my_colors.dart';
// import 'package:lio_care/help_tree/tree_provider.dart';
// import 'package:provider/provider.dart';
//
// class TreeHomeSection extends StatelessWidget {
//   const TreeHomeSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     UserProvider userProvider = Provider.of<UserProvider>(context,listen: false);
//     return  Scaffold(
//       body: Consumer<TreeProvider>(
//           builder: (context5,value123,child) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               InkWell(
//                 onTap: () async {
//                   await value123.fetchHelpTree(userProvider.registerID,userProvider.registerDocID,"MASTER_CLUB",
//                       userProvider.userProfileImage,context);
//                 },
//                 child: Container(
//                   margin: EdgeInsets.all(15),
//                   height: 80,
//                   width: 200,
//                   color: cl004CA8,
//                   alignment: Alignment.center,
//                   child: Text("BASIC TREE"),
//                 ),
//               ),
//               InkWell(
//                 onTap: () async {
//                   await value123.fetchHelpTree(userProvider.registerID,userProvider.registerDocID,"STAR_CLUB",
//                       userProvider.userProfileImage,context);
//                 },
//                 child: Container(
//                   margin: EdgeInsets.all(15),
//                   height: 80,
//                   width: 200,
//                   color: cl004CA8,
//                   alignment: Alignment.center,
//                   child: Text("AUTO POLL ONE"),
//                 ),
//               ),
//               InkWell(
//                 onTap: () async {
//                   await value123.fetchHelpTree(userProvider.registerID,userProvider.registerDocID,"CROWN_CLUB",
//                       userProvider.userProfileImage,context);
//                 },
//                 child: Container(
//                   margin: EdgeInsets.all(15),
//                   height: 80,
//                   width: 200,
//                   color: cl004CA8,
//                   alignment: Alignment.center,
//                   child: Text("AUTO POLL TWO"),
//                 ),
//               ),
//             ],
//           );
//         }
//       ),
//     );
//   }
// }
