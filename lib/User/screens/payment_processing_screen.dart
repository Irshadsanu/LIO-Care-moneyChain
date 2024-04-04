import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentProcessing extends StatelessWidget {
  const PaymentProcessing({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return  WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 90,
                    height: 90,
                    child: Lottie.asset('assets/yyhWaRPrJd.json',
                        repeat: true, fit: BoxFit.fill)),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Please Wait',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
