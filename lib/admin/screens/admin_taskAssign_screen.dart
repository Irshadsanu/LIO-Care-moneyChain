import 'package:flutter/material.dart';
import 'package:lio_care/Constants/functions.dart';
import 'package:lio_care/constants/my_colors.dart';
import 'package:provider/provider.dart';

import '../../Provider/admin_provider.dart';
import 'admin_homeScreen.dart';
import 'admin_menu_screen.dart';

class AdminTaskAssignScreen extends StatelessWidget {
  String from;
  String taskId;
   AdminTaskAssignScreen({Key? key,required this.from,required this.taskId }) : super(key: key);


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
   String? name='';

    return Scaffold(
    //   endDrawer: Drawer(
    //   width: width,
    //   child: const AdminMenuScreen(),
    // ),
      backgroundColor: bxkclr,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.bottomLeft,
              colors: [
                cl005BBB,
                cl001969,
              ],
            ),
          ),
        ),
        backgroundColor: cWhite,
        leadingWidth: 30,
        leading:InkWell(
          onTap: (){
            callNextReplacement(const AdminHomeScreen(),context);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Icon(Icons.arrow_back_ios,color: myWhite,),
          ),
        ),
        toolbarHeight: 65,


        elevation: 0,
        title:  Image.asset("assets/whitelogo.png",scale: 12,),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Consumer<AdminProvider>(
              builder: (context1,value1,child) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 17,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 205),
                      child: Text(
                        'Assign Task',
                        style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff252525),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Card(
                      elevation: 5,
                      shadowColor: Colors.white.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                      child: SizedBox(
                        // width: 350,
                        child: TextFormField(
                          readOnly: true,
                          controller: value1.taskDurationController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(20, 20, 5, 0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide: const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              hintText: 'Task Duration',
                              hintStyle: const TextStyle(
                                  color: Color(0xff808080),
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
                          onTap: (){
                            value1.adminTaskAssignDateSelect(context);
                          },
                          style: const TextStyle(
                            color: Color(0xff808080),
                            fontFamily: 'PoppinsRegular',
                            fontSize: 14,
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Select Task Duration';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 14,),
                    Card(
                      elevation: 5,
                      shadowColor: Colors.white.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                      child: SizedBox(
                        // width: 350,
                        child: TextFormField(
                          controller: value1.taskHeadingController,

                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(15, 20, 5, 0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide: const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              hintText: 'Task Heading',
                              hintStyle: const TextStyle(
                                  color: Color(0xff808080),
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
                          style: const TextStyle(
                            color: Color(0xff808080),
                            fontFamily: 'PoppinsRegular',
                            fontSize: 14,
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Enter Task Heading';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 14,),
                    Card(
                      elevation: 5,
                      shadowColor: Colors.white38.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                      child: SizedBox(
                        height: 171,
                        // width: 350,
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Enter Message';
                            }
                            return null;
                          },

                          controller: value1.taskController,
                            textAlignVertical: TextAlignVertical.top,
                            maxLines: null,
                            expands: true,

                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(35),
                                ),

                                hintText: 'Enter Message',
                                hintStyle: const TextStyle(
                                  color: Color(0xff808080),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'PoppinsRegular',
                                )
                            ),
                            style: const TextStyle(
                              color: Color(0xff808080),
                              fontFamily: 'PoppinsRegular',
                              fontSize: 14,
                            ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height:20,
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.only(right: 250),
                    //   child: Text(
                    //     'Link',
                    //     style: TextStyle(
                    //       fontFamily: 'PoppinsRegular',
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w400,
                    //       color: Color(0xff808080),
                    //     ),
                    //   ),
                    // ),

                    Card(
                      elevation: 5,
                      shadowColor: Colors.white.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                      child: SizedBox(
                        // width: 350,
                        child: TextFormField(
                          controller: value1.taskLinkController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(15, 20, 5, 0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide: const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              hintText: 'Paste link',
                              hintStyle: const TextStyle(
                                  color: Color(0xff808080),
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
                          style: const TextStyle(
                            color: Color(0xff808080),
                            fontFamily: 'PoppinsRegular',
                            fontSize: 14,
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Paste Link';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                        height: 50,
                        width: 350,
                        child: MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              value1.adminAddTask(value1.adminId,value1.adminName,from,taskId,context);

                            }
                                 },
                          color: const Color(0xff1746A2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35)),
                          child:  Text(
                            from=="ADD"
                            ?'Send':'Save Changes',
                            style: const TextStyle(
                                fontFamily: 'PoppinsRegular',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Snackbar Demo',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Snackbar Demo'),
//         ),
//         body: Center(
//           child: TextButton(
//             onPressed: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//
//                   content: Text('This is a snackbar!',style: TextStyle(color: Colors.amber),),
//                   behavior: SnackBarBehavior.floating,
//                   // This will position the snackbar under the app bar
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(5.0),
//                       topRight: Radius.circular(5.0),
//                     ),
//                   ),
//                 ),
//               );
//             },
//             child: const Text('Show Snackbar'),
//           ),
//         ),
//       ),
//     );
//   }
// }
