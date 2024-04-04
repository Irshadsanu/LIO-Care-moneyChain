import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants/functions.dart';
import '../../Provider/user_provider.dart';
import '../../constants/my_colors.dart';
import 'make_dynamic_Link_Screen.dart';

class MyInvitationScreen extends StatelessWidget {
  const MyInvitationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [textColor, clCADEFC, clFFFCF8])
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar:AppBar(
            leadingWidth: 100,
            backgroundColor: cl2E7DC0,
            elevation: 0,
            automaticallyImplyLeading: false,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                )
            ),
            leading: InkWell(
                onTap: (){
                  finish(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                       const Icon(Icons.arrow_back_ios,color: Colors.white,),
                      Image.asset("assets/whitelogo.png",scale: 12,),
                    ],
                  ),
                )),
          ),


          body: Column(
            children: [

              const SizedBox(height: 10,),

              Center(
                child: Container(
                  height: height / 8,
                  width: width / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffFFFCF8),
                    image: const DecorationImage(
                        image: AssetImage("assets/invitationsBg.png"),
                        fit: BoxFit.fill),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: height * .01,
                      ),
                      const Text(
                        "Collection by Invitation",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: cBlack,
                          fontSize: 14,
                          fontFamily: 'PoppinsMedium',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Consumer<UserProvider>(
                          builder: (context,va,cild) {
                            return
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "₹ ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 28,
                                            color: clFF731D)),
                                    TextSpan(
                                        text:va.totaluserReferralTransaction.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 28,
                                            fontFamily: "PoppinsMedium",
                                            color: clFF731D)),
                                  ]));
                          }
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),


              Container(
                width: width / 1.1,
                height: 100,
                padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
                decoration: const BoxDecoration(
                    color: clFFFCF8,//clFFFCF8
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(22),
                        topLeft: Radius.circular(22))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'My Invitations',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            height: 1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        Text(
                          'Came From My Invitation link',
                          style: TextStyle(
                            color: Color(0xFF5E5E5E),
                            fontSize: 10,
                            fontFamily: 'PoppinsMedium',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Consumer<UserProvider>(
                      builder: (context5,value4,child) {
                        return InkWell(
                          onTap: () async {
                            String generatedDeepLink =
                            await FirebaseDynamicLinkService.createDynamicLink(
                                true, value4.userPhone);

                            Share.share(
                                '${"Lio club"}:\n\nDownload Lio club to read more and be updated $generatedDeepLink \nID: ${value4.registerID}',
                                subject: 'Look what I made!');
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 77,
                            height: 23,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFFF731D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26),
                              ),
                            ),
                            child: const Text(
                              'Invite',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFFFFCF8),
                                fontSize: 12,
                                height: 0,
                                fontFamily: 'PoppinsMedium',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      }
                    )

                  ],
                ) ,
              ),

              Flexible(
                fit:FlexFit.tight,
                child: Container(
                  width: width / 1.1,
                  // height: height-320,
                  padding: const EdgeInsets.only(top: 15, left: 8, right: 8),
                  decoration: const BoxDecoration(
                    // color: Colors.green
                    color: clFFFCF8,
                  ),
                  child:Consumer<UserProvider>(builder: (context,val40,child) {
                    return val40.userClearedReferralTransactionList.isNotEmpty?
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: val40.userClearedReferralTransactionList.length,
                      itemBuilder: (context, index) {
                        var item =val40.userClearedReferralTransactionList[index];
                        return InkWell(
                          child: Container(
                            color: clFFFCF8,
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            height: 75,
                            child: Row(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 9.0),
                                    child: item.image!=""?  CircleAvatar(
                                      radius: 20,
                                      backgroundColor: myWhite,
                                      backgroundImage: NetworkImage(item.image),
                                    ): const CircleAvatar(
                                        radius: 20,
                                        backgroundColor: myWhite,
                                        child: Icon(Icons.person_rounded)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 11,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(item.memberId,
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w300,
                                            color: cl5F5F5F)),
                                    Text(item.number,
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w300,
                                            color: cl5F5F5F)),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Text(item.status,
                                        style:  TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color:    item.status=="PENDING"
                                                ?clFA721F
                                                :item.status=="PAID"
                                                ?cl16B200
                                                :clAD0000)),
                                    RichText(
                                        text:  TextSpan(children: [
                                          const TextSpan(
                                            text: "Referral  Amount: ",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300,
                                                color: cl5F5F5F),

                                          ),
                                          const TextSpan(text: " ₹ ",  style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: cl252525
                                          )),
                                          TextSpan(text: item.amount,  style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: cBlack
                                          )),
                                        ]))
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ):const SizedBox(
                      height: 80,
                      child: Center(child: Text("No Transactions Yet.")),
                    );
                  }) ,
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}