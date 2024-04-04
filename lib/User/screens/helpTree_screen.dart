import 'package:flutter/material.dart';
import '../../Constants/functions.dart';
import '../../constants/my_colors.dart';

class HelpTreeScreen extends StatelessWidget {
  const HelpTreeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myWhite,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              finish(context);
            },child: Icon(Icons.arrow_back_ios,color: textColor,)),
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Image.asset('assets/bluelogo.png',scale: 15,)
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: Text("Help Tree",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontFamily: "PoppinsRegular"),),
          ),
        ],
      ),
    );
  }
}
