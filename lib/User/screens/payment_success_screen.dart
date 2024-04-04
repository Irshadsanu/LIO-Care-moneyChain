import 'package:flutter/material.dart';
import 'package:lio_care/Provider/login_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Provider/user_provider.dart';
import '../../constants/functions.dart';
import '../../constants/my_colors.dart';
import 'bottomNavigation.dart';


class PaymentSuccessScreen extends StatefulWidget {

  final String status;
  final String memberId;
  final String grade;
  final String tree;
  final String memberPhone;
  final bool isNewGrade;

  const PaymentSuccessScreen({Key? key, required this.status, required this.memberId,
    required this.grade, required this.tree, required this.memberPhone, required this.isNewGrade}) : super(key: key);

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> with TickerProviderStateMixin {

  late final AnimationController _controller;

  @override

  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
    Future.delayed(Duration.zero,(){
      userProvider.gatewayShowFun();
    });

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.11, -0.99),
              end: Alignment(-0.11, 0.99),
              colors: [Color(0xFF2F7DC1), Color(0xFF2FC1BC)],
            ),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              const SizedBox(height: 100,),

              SizedBox(
                width: 133.12,
                height: 81,
                child: Image.asset("assets/whitelogo.png",),

              ),
              SizedBox(
                height: height*.15,
              ),
              Center(
                child:widget.status=="SUCCESS"
                    ? Lottie.asset(
                  'assets/96673-success.zip',
                  height: 100,width:width/1.2,
                  fit: BoxFit.contain,
                  controller: _controller,
                  onLoaded: (composition) {
                    // Configure the AnimationController with the duration of the
                    // Lottie file and start the animation.
                    _controller
                      ..duration = composition.duration
                      ..forward();

                  },
                ) :Container(
                  child: Lottie.asset(
                    'assets/animation_lkgrqz47.json',height: 100,width:width/1.2,

                    fit: BoxFit.contain,
                    controller: _controller,
                    onLoaded: (composition) {
                      // Configure the AnimationController with the duration of the
                      // Lottie file and start the animation.
                      _controller
                        ..duration = composition.duration
                        ..forward();

                    },
                  ),
                ),
              ),
              SizedBox(
                height: height*.29,
              ),
          Column(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Your Payment Has Been\n',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: widget.status ,
                      style:  TextStyle(
                        color:widget.status =="SUCCESS"? const Color(0xFF37F81C):Colors.red,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
            ],
          ),
        ),
          floatingActionButton: Consumer<UserProvider>(
            builder: (context2,value2,child) {
              return FloatingActionButton.extended(
                onPressed: (){

                  if(widget.isNewGrade){
                    LoginProvider loginProvider = Provider.of<LoginProvider>(context,listen: false);
                    loginProvider.userAuthorized("OTHER","+91${widget.memberPhone}","", context);
                  }else{
                    // if(widget.status =="SUCCESS"&&widget.grade=="STARTER"){
                    //   value2.fetchDistributionsNEW(widget.memberId, widget.grade, widget.tree);
                    //   // value2.fetchUserAllGrades(widget.memberId);
                    //   value2.fetchParentList(widget.memberId);
                    //   // value2.fetchBasicParents();
                    // }
                    // //yakoob/asif contact us

                    callNextReplacement(BottomNavigationScreen(Userid:widget.memberId), context);
                  }
              },
                extendedPadding: const EdgeInsets.all(30), label: Center(child: Text("Home",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: textColor),)),
              backgroundColor: Colors.white,);
            }
          ),
      ),
    );
  }
}
