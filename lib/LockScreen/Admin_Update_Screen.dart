import 'package:flutter/material.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/my_colors.dart';

class AdminUpdateScreen extends StatelessWidget {
  String text;
  String button;
  String address;
  AdminUpdateScreen(
      {Key? key,
        required this.text,
        required this.button,
        required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    AdminProvider adminProvider =
    Provider.of<AdminProvider>(context, listen: false);
    adminProvider.confirmAdminLocking(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body:
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                    textColor,
                    grdintclr1,
                  ])),



          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 200,
              ),
              // const ContainerRound(),

              Image.asset(
                "assets/whitelogo.png",
                scale: 4.8,
              ),


              const SizedBox(
                height: 110,
              ),
              SizedBox(
                  width: 280,
                  child: Text(
                    text,
                    style: const TextStyle(color:cWhite,fontFamily: 'PoppinsRegular',fontWeight: FontWeight.bold,fontSize: 18),
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(
                height: 60,
              ),
              InkWell(
                splashColor: Colors.white,
                onTap: () {
                  _launchURL(address);
                },
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      gradient:  LinearGradient(colors: [
                        clFFFCF8,
                        cl5F9DF7.withOpacity(0.9),
                      ]),
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Text(
                            button,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              color: cBlack,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height - 700,
              ),
              // Image.asset("assets/SpineLogo.png", scale: 4),
            ],
          ),
        ),

      ),
    );
  }

  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
