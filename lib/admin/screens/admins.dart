import 'package:flutter/material.dart';

import '../../constants/my_colors.dart';

class Admins extends StatelessWidget {
  const Admins({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors:[
                    cl001969,
                    cl005BBB
                  ])
          ),
        ),
        title: const Text("Admins"),
      actions: const [CircleAvatar(backgroundColor: cl001969,child: Icon(Icons.menu),),SizedBox(width: 10,)],
      ),
    ));
  }
}
