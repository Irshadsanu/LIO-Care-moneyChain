
import 'package:flutter/material.dart';

import '../../constants/my_colors.dart';

class ContainerRound extends StatefulWidget {
  const ContainerRound({super.key});

  @override
  State<ContainerRound> createState() => _ContainerRoundState();
}

class _ContainerRoundState extends State<ContainerRound>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration:  const Duration(seconds: 5));
    // TODO: implement initState
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return  SizedBox(
      width: width,
      height:height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Spacer(),
          const SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/li-8.png",
                width: 50,
                height: 50,
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 70,
                height: 70,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/v.2 blue-8.png",
                      width: 70,
                      height: 70,
                    ),
                    Positioned(
                      top: 1.2,
                      left: 5,
                      child: Align(
                          alignment: Alignment.center,
                          child: RotationTransition(
                            turns: Tween(begin: 1.0, end: 0.0)
                                .animate(_controller),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/v.2 white-8.png"),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset(
              "assets/CLUB-8.png",
              width: 65,
            ),
          ),
          const Spacer(),
          const Text("Enterplex Digital Solutions LLP",
              style:  TextStyle(color: cl00369F, fontWeight: FontWeight.bold, fontSize: 13),textAlign: TextAlign.center,),
          const SizedBox(height: 30,)
        ],
      ),
    );
  }
}
