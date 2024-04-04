import 'package:flutter/material.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:lio_care/User/screens/history_screen.dart';
import 'package:lio_care/User/screens/menu_screen.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:provider/provider.dart';
import '../../constants/my_colors.dart';
import 'help_parent_screen.dart';
import 'home_Screen.dart';
import 'myAccount_screen.dart';
import 'newDistribution_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  String Userid;

  BottomNavigationScreen({Key? key, required this.Userid}) : super(key: key);
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  // ValueNotifier<int> selectedIndex = ValueNotifier(0);


  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    var screens = [
      HomeScreen(
        userID: widget.Userid,
      ),
      // NewDistributionScreen(),
      const HelpParentScreen(),
      const HistoryScreen(),
      MyAccountScreen(),
      // const MenuScreen()
    ];

        return WillPopScope(
          // onWillPop: () async {
          //   return false; *
          // },
          onWillPop: () => userProvider.showExitPopup(context),
          child: Consumer<UserProvider>(
              builder: (context,user,child) {
              return ValueListenableBuilder(
                  valueListenable:user.bottomSelectedIndex ,
                  builder: (context, int dSelectedIndex, child) {
                    return Scaffold(
                      backgroundColor: dSelectedIndex == 3
                          ? const Color(0xFFBFD5E8)
                          : dSelectedIndex == 4
                              ? cl005BBB
                              : bxkclr,
                      body: screens[dSelectedIndex],

                      bottomNavigationBar:
                      SafeArea(

                        child: Container(
                            height: 75,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  topLeft: Radius.circular(24)),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 50,
                                  color: textColor.withOpacity(.2),
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                    onTap: () {
                                      user.bottomSelectedIndex.value = 0;
                                      userProvider.editCheck=false;
                                      userProvider. homeDistributionList= userProvider.distributionList.where((element) => element.status=="PENDING"||element.status=="PROCESSING"||element.status=="REJECTED").take(2).toSet().toList();

                                      
                                    },
                                    child: AnimatedContainer(
                                      alignment: Alignment.center,
                                      width: dSelectedIndex != 0 ? 40 : 90,
                                      duration: const Duration(milliseconds: 600),
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 8),
                                      // width: 79,
                                      height: 40,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color:
                                            dSelectedIndex == 0 ? clFF731D : clF5F5F5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(49),
                                        ),
                                      ),
                                      child: dSelectedIndex == 0
                                          ? ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: const [
                                                Icon(
                                                  Icons.home,
                                                  color: myWhite,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Center(
                                                  child: Text(
                                                    'Home',
                                                    style: TextStyle(
                                                      color: myWhite,
                                                      fontSize: 12,
                                                      fontFamily: 'PoppinsRegular',
                                                      height: 0,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const Icon(
                                              Icons.home,
                                              color: cl252525,
                                            ),
                                    )
                                ),
                                InkWell(
                                  onTap: () {
                                    user.bottomSelectedIndex.value = 1;
                                    userProvider. clearBooleans();

                                  },
                                  child:
                                  AnimatedContainer(
                                    alignment: Alignment.center,
                                    width: dSelectedIndex != 1 ? 40 : 90,
                                    duration: const Duration(milliseconds: 600),
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    height: 40,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: dSelectedIndex == 1 ? clFF731D : clF5F5F5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(49),
                                      ),
                                    ),
                                    child:
                                    dSelectedIndex == 1
                                        ?
                                    ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: const [
                                        Icon(
                                          Icons.device_hub,
                                          color: myWhite,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Center(
                                          child: Text(
                                            'Helps',
                                            style: TextStyle(
                                              color: myWhite,
                                              fontSize: 12,
                                              fontFamily: 'PoppinsRegular',
                                              height: 0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                        : const Icon(
                                      Icons.device_hub,
                                      color: cl252525,
                                    ),
                                  )
                                ),
                                InkWell(
                                  onTap: () {
                                    user.bottomSelectedIndex.value = 2;
                                    userProvider.getTransactions(widget.Userid);
                                    userProvider.editCheck=false;
                                  },
                                  child:
                                  AnimatedContainer(
                                    alignment: Alignment.center,
                                    width: dSelectedIndex != 2 ? 40 : 130,
                                    duration: const Duration(milliseconds: 600),
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    height: 40,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: dSelectedIndex == 2 ? clFF731D : clF5F5F5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(49),
                                      ),
                                    ),
                                    child:
                                    dSelectedIndex == 2
                                        ?
                                    ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: const [
                                        Icon(
                                          Icons.history,
                                          color: myWhite,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Center(
                                          child: Text(
                                            'Transactions',
                                            style: TextStyle(
                                              color: myWhite,
                                              fontSize: 12,
                                              fontFamily: 'PoppinsRegular',
                                              height: 0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                        : const Icon(
                                      Icons.history,
                                      color: cl252525,
                                    ),
                                  )
                                ),
                                InkWell(
                                  onTap: () {
                                    // user.fetchMyInvitationCount(widget.Userid);
                                    user.bottomSelectedIndex.value = 3;
                                  },
                                  child:
                                  // dSelectedIndex == 3
                                  //     ?
                                  AnimatedContainer(
                                    alignment: Alignment.center,
                                    width: dSelectedIndex != 3 ? 40 : 100,
                                    duration: const Duration(milliseconds: 600),
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    height: 40,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: dSelectedIndex == 3 ? clFF731D : clF5F5F5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(49),
                                      ),
                                    ),
                                    child:
                                    dSelectedIndex == 3
                                        ?
                                    ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: const [
                                        Icon(
                                          Icons.person_outline,
                                          color: myWhite,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Center(
                                          child: Text(
                                            'Account',
                                            style: TextStyle(
                                              color: myWhite,
                                              fontSize: 12,
                                              fontFamily: 'PoppinsRegular',
                                              height: 0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                        : const Icon(
                                      Icons.person_outline,
                                      color: cl252525,
                                    ),
                                  )
                                  // Container(
                                  //         // width:selectedIndex.value!=0?0:80,
                                  //         //       duration: Duration(seconds: 1),
                                  //         padding:
                                  //             const EdgeInsets.symmetric(horizontal: 8),
                                  //         // width: 79,
                                  //         height: 40,
                                  //         clipBehavior: Clip.antiAlias,
                                  //         decoration: ShapeDecoration(
                                  //           color: clFF731D,
                                  //           shape: RoundedRectangleBorder(
                                  //             borderRadius: BorderRadius.circular(49),
                                  //           ),
                                  //         ),
                                  //         child: const Row(
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.spaceEvenly,
                                  //           children: [
                                  //             Icon(
                                  //               Icons.person_outline,
                                  //               color: myWhite,
                                  //             ),
                                  //             SizedBox(
                                  //               width: 5,
                                  //             ),
                                  //             Text(
                                  //               'Account',
                                  //               textAlign: TextAlign.right,
                                  //               style: TextStyle(
                                  //                 color: myWhite,
                                  //                 fontSize: 12,
                                  //                 fontFamily: 'PoppinsRegular',
                                  //                 fontWeight: FontWeight.w400,
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       )
                                  //     : const CircleAvatar(
                                  //         backgroundColor: clF5F5F5,
                                  //         radius: 20,
                                  //         child: Icon(
                                  //           Icons.person_outline,
                                  //           color: cl252525,
                                  //         ),
                                  //       ),
                                ),
                                InkWell(
                                  onTap: () {
                                    callNext(const MenuScreen(), context);
                                    // userProvider.fetchNotification(widget.Userid, true);
                                    userProvider.editCheck=false;
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Color(0xFF2F7DC1),
                                    radius: 20,
                                    child: Icon(
                                      Icons.menu,
                                      color: myWhite,
                                    ),
                                  ),
                                ),
                              ],
                            )
                            // SafeArea(
                            //   child: Padding(
                            //     padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18),
                            //     child: ClipRRect(
                            //       borderRadius: const BorderRadius.only(topRight: Radius.circular(24),topLeft: Radius.circular(24)),
                            //       child:
                            //
                            //       GNav(
                            //         gap: 6,
                            //         activeColor: Colors.white,
                            //         iconSize: 20,curve: Curves.easeOutExpo,
                            //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            //         duration: const Duration(milliseconds: 400),
                            //         tabBackgroundColor: clFF731D,
                            //         color: Colors.black,
                            //         hoverColor: Colors.transparent,
                            //         rippleColor: Colors.transparent,
                            //         tabs: const [
                            //           GButton(
                            //             icon: Icons.home,
                            //             iconSize: 25,
                            //             text: 'Home',
                            //             iconActiveColor: myWhite,
                            //           ),
                            //           GButton(
                            //             icon: Icons.device_hub,
                            //             iconSize: 25,
                            //             text: 'Distributions',
                            //             iconActiveColor: myWhite,
                            //           ),
                            //           GButton(
                            //             icon: Icons.history,
                            //             text: 'Transactions',
                            //             iconSize: 25,
                            //             iconActiveColor: myWhite,
                            //           ),
                            //           GButton(
                            //             icon: Icons.person_outline,
                            //             iconSize: 25,
                            //             text: 'Account',
                            //             iconActiveColor: myWhite,
                            //           ),
                            //           GButton(
                            //             icon: Icons.menu,
                            //             text: 'Menu',
                            //             iconSize: 25,
                            //             iconActiveColor: myWhite,
                            //           ),
                            //         ],
                            //         selectedIndex: _selectedIndex,
                            //         onTabChange: (index) {
                            //           setState(() {
                            //             _selectedIndex = index;
                            //             if( _selectedIndex!=3 || _selectedIndex==1 ){
                            //               userProvider.editCheck=false;
                            //               if(_selectedIndex == 1){
                            //                 userProvider.fetchParentList(widget.Userid,userProvider.selectedUserTree!);
                            //               }
                            //               if(_selectedIndex == 2){
                            //                 userProvider.getTransactions(widget.Userid);
                            //               }
                            //               // if(_selectedIndex == 4){
                            //               //   userProvider.fetchNotification(widget.Userid, true);
                            //               // }
                            //           }
                            //
                            //             });
                            //           },
                            //         ),
                            //
                            //       ),
                            //     ),
                            //   ),
                            ),
                      ),
                    );
                  });
            }
          ),
        );

  }
}
