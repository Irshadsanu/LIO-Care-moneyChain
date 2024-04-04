import 'package:flutter/material.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../Constants/functions.dart';
import '../../constants/my_colors.dart';

class MyAmfScreen extends StatelessWidget {
  const MyAmfScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
    List color=[
      clrcntnr1,
      myWhite
    ];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [textColor, clCADEFC])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leadingWidth: 100,
          backgroundColor: textColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: (){
                finish(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios,color: Colors.white,),
                    Image.asset("assets/whitelogo.png",scale: 12,),
                  ],
                ),
              )),
          // leading: InkWell(
          //     onTap: (){
          //       finish(context);
          //     },
          //     child: SizedBox(
          //         width: 50,
          //         child: Center(child: Icon(Icons.arrow_back_ios,color: myWhite,)))),
          // title: Padding(
          //   padding: const EdgeInsets.only(top: 8.0),
          //   child:Image.asset("assets/whitelogo.png",scale: 12,),
          //   // child: Text("Lio Care",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Textcolor,fontFamily: "PoppinsRegular"),),
          // ),

        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Center(
                child: Container(
                  height: height / 8,
                  width: width / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: bxkclr,
                    image: const DecorationImage(
                        image: AssetImage("assets/backgroundimage.png"),
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
                        "My Total PMC",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      Consumer<UserProvider>(
                        builder: (context,val35,child) {
                          return Text(
                            "₹${val35.totalPmc}",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                                color: clFF731D),
                          );
                        }
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: width / 1.1,
                  height: height / 1.3    ,
                  decoration:  const BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                  ),

                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 25, left: 7.5, right: 7.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "My PMC",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                fontFamily: "PoppinsRegular",),
                            ),
                            Consumer<UserProvider>(
                                builder: (context,val44,child) {
                                return InkWell(
                                  onTap: (){

                                    val44.payPmcFromMyPmc(val44.registerID,"PMC",context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 21,
                                    width: width / 5.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: clFF731D,
                                    ),
                                    child:  const InkWell(
                                      child: Text(
                                      "Pay PMC",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: Colors.white),
                                    ),
                                    ),
                                  ),
                                );
                              }
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Consumer<UserProvider>(
                          builder: (context,provider,child) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                itemCount: provider.pmcDetailsList.length,
                                itemBuilder: (BuildContext context, int index) {
                                var item=provider.pmcDetailsList[index];
                                  return Padding(
                                    padding:  const EdgeInsets.only(top: 5),
                                    child: Container(
                                      height: height/8.6,
                                      width: width,
                                      color: color[index%2],
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: InkWell(
                                              onTap: (){},
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 26,
                                                child: Image.asset(
                                                  "assets/bluelogo.png",
                                                  scale: 6,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: SizedBox(
                                              height: 60,
                                              width: 100,
                                              child: Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("₹${item.amount}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 21,color: textColor),),
                                                  Text(item.tree,style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 10,color: Colors.black),),
                                                  Text(item.levelName,maxLines:2,style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 10,color: Colors.grey),),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  // Text(item.status =='SUCCESS'?'Paid':'',style: TextStyle(color:Textcolor2,fontSize: 10,fontWeight: FontWeight.w400),),
                                                  // const SizedBox(
                                                  //   height: 20,
                                                  // ),
                                                  Text("PMC ${item.installment}",style: const TextStyle(color:Colors.black,fontSize: 10,fontWeight: FontWeight.w400),),
                                                  Text(item.date,style: const TextStyle(color:Colors.black,fontSize: 10,fontWeight: FontWeight.w400),),
                                                  Text(item.time,style: const TextStyle(color:Colors.black,fontSize: 10,fontWeight: FontWeight.w400),),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                        ),
                      ),
                    ]
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
