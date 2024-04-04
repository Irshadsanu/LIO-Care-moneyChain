
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:lio_care/Constants/functions.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../../constants/my_colors.dart';

class UploadTaskScreen extends StatelessWidget {
  const UploadTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final ChromeSafariBrowser browser = MyChromeSafariBrowser();


    return Scaffold(
      backgroundColor: bck,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:  bck,
        leading: InkWell(
          onTap: (){
            finish(context);
          },
          child:  Icon(
            Icons.arrow_back_ios_new_outlined,
            color:textColor,
          ),
        ),
        title: Image.asset(
          "assets/bluelogo.png",
          scale: 3,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            const Padding(
            padding: EdgeInsets.only(left: 18),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Upload Task",
                style: TextStyle(
                    fontFamily: "PoppinsMedium",
                    fontSize:20,
                    fontWeight: FontWeight.w600,
                    color: cBlack
                ),
              ),
            ),
          ),
          SizedBox(height: height/9.770114942528736,),
          SizedBox(
              height: 161,
              width: width,
              child: Center(child: Image.asset("assets/documentupload1.png"))),

          SizedBox(height: height/10.625,),


          Container(
            padding: const EdgeInsets.all(8),
            height: 200,
            width: width/1.12,
            decoration: BoxDecoration(
                color: cWhite,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                // Container(
                //   height: 70,
                //     width: 60,
                //     decoration: const BoxDecoration(
                //       color: cWhite,
                //         shape: BoxShape.circle, // BoxShape.circle or BoxShape.retangle
                //         //color: const Color(0xFF66BB6A),
                //         boxShadow: [BoxShadow(
                //           color: Colors.grey,
                //           blurRadius: 1.5,
                //         ),]
                //     ),
                //     child:Icon(Icons.cloud_upload_outlined,size: 38,color: textclr2,)
                // ),
                SizedBox(
                  width: width/1.726872246696035,
                  height: 200/2.5,
                  child: const Text(
                    'Enhance your\nwork',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF2F7DC1),
                      fontSize: 29,
                      fontFamily: 'PoppinsRegular',
                      fontWeight: FontWeight.w700,
                      // height: 36,
                    ),
                  ),
                ),

                const SizedBox(height: 15,),
                const Text(
                  'Upload your assigned task',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 16,
                    fontFamily: 'PoppinsRegular',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 19,),
                Consumer<UserProvider>(
                  builder: (context,val55,child) {
                    return val55.taskSubmitFileImage==null? InkWell(
                      onTap: (){
val55.showBottomSheet(context,"TASK_SUBMIT");
                      },
                      child: Container(
                        width: 184,
                        height: 33,
                        padding: const EdgeInsets.only(top: 8, left: 46, right: 46, bottom: 7),
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(color: Color(0xFFFFFCF8)),
                        child: Row(
                          children: [

                            const Text(
                              "Choose file",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF2F7DC1),
                                fontSize: 12,
                                fontFamily: 'PoppinsRegular',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 5,),
                            SizedBox(
                                width: 18,
                                height: 18,
                                child: Image.asset("assets/uplodcloud.png"))
                          ],
                        ),
                      ),
                    ):Container( width: width/2.130434782608696,
                      height: 33,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(color: Color(0xFFFFFCF8)),
                    child: Row(
                      children: [
                        const SizedBox(width: 6,),
                      const Text(
                        'Demofile.jpeg ',
                        style: TextStyle(
                          color: Color(0xFF2F7DC1),
                          fontSize: 12,
                          fontFamily: 'PoppinsRegular',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),

                      Consumer<UserProvider>(
                        builder: (context,val78,child) {
                          return InkWell(
                           onTap:  (){
                              val78.taskFIleImageNull();
                            },
                            child: Container( width:25 ,
                              height:25 ,
                              clipBehavior: Clip.antiAlias,
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                color:const Color(0xFFF6F3EF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(65.37),
                                ),
                              ),
                              child: const Icon(Icons.close_rounded,color: cBlack,size: 21),
                            ),
                          );
                        }
                      ),
                        const SizedBox(width: 6,),
                      ],),
                    );
                  }
                ),
              ],
            ),
          ),
          SizedBox(height: height/6.910569105691057,),

          Consumer<UserProvider>(
            builder: (context,value99,child) {
              return InkWell(
                onTap: () async {
                  const url =  "https://www.spinecodes.com/";  //url
                  var safariBrowser = browser;
                  await safariBrowser.open(
                      url: Uri.parse(url),
                      options: ChromeSafariBrowserClassOptions(
                        android: AndroidChromeCustomTabsOptions(
                          shareState: CustomTabsShareState.SHARE_STATE_OFF,
                        ),
                        ios: IOSSafariOptions(barCollapsingEnabled: true),
                      ));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: width/1.12,
                  decoration:BoxDecoration(
                    color:value99.taskSubmitFileImage==null? const Color(0xFFD5D5D5): clFF731D,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Text(
                    "Submit",style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.9,
                    color: cWhite
                  ),),
                ),
              );
            }
          )

        ],
      ),
    );
  }
}
class MyChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {
    print("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    print("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    print("ChromeSafari browser closed");
  }
}
