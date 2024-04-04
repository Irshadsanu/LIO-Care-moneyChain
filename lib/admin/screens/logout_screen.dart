import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:provider/provider.dart';

import '../../Provider/login_provider.dart';
import '../../view/loginScreen.dart';
import 'admin_login_screen.dart';

class Logout extends StatelessWidget {

   const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFFFCF8),
        body: Center(
            child: Container(
          height: 222,
          width: 335,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xff005BBB), Color(0xff001969)]),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                '       Are you sure\nyou want to log out ?',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    gradient: const LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.bottomLeft,
                        colors: [Color(0xff005BBB), Color(0xff001969)]),
                    image: const DecorationImage(
                      image: AssetImage('assets/logout.png'),
                      scale: 1.2,
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 39,
                    width: 120,
                    child: ElevatedButton(
                        style: ButtonStyle(elevation: MaterialStateProperty.all(0),
                            textStyle: MaterialStateProperty.all(const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w900)),
                            backgroundColor:
                                MaterialStateProperty.all(const Color(0xffFFFCF8)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60)))),
                        onPressed: () {finish(context);},
                        child: const Text('Cancel',
                            style: TextStyle(
                                color: Color(0xff1746A2),
                                fontSize: 16,
                                fontWeight: FontWeight.w900))),
                  ),
                  SizedBox(
                    height: 39,
                    width: 120,
                    child: ElevatedButton(
                        style: ButtonStyle(elevation: MaterialStateProperty.all(0),
                            textStyle: MaterialStateProperty.all(const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w900)),
                            backgroundColor:
                                MaterialStateProperty.all(const Color(0xff1746A2)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60)))),
                        onPressed: () {
                          LoginProvider loginProvider =
                          Provider.of<LoginProvider>(context, listen: false);
                          FirebaseAuth auth = FirebaseAuth.instance;
                          loginProvider.userLoginPhoneCT.clear();
                          loginProvider.userLoginPasswordCT.clear();
                          auth.signOut();
                          finish(context);
                          callNextReplacement( const Admin_Login(), context);

                        },
                        child: const Text('Logout',
                            style: TextStyle(
                                color: Color(0xffFFFCF8),
                                fontSize: 16,
                                fontWeight: FontWeight.w900))),
                  ),
                ],
              )
            ],
          ),
        )));
  }
}
