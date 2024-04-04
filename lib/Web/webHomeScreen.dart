import 'package:flutter/material.dart';
import 'package:lio_care/Constants/functions.dart';
import 'package:lio_care/Web/prc_Issue_clearence.dart';

import '../constants/my_colors.dart';

class WebHomeScreen extends StatelessWidget {
  const WebHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: clFFAC7B, // Change the background color here
              ),
              onPressed: () {
                callNext(const PrcIssueClearance(), context);
              },
              child: const Text('PRC Issue Clearance'),
            ),
          ],
        ),
      ),
    );
  }
}
