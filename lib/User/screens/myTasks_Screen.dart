import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:lio_care/User/screens/uploadtask_screen.dart';
import 'package:provider/provider.dart';

import '../../Constants/functions.dart';
import '../../constants/my_colors.dart';

class MyTasksScreen extends StatelessWidget {
  final ChromeSafariBrowser browser = MyChromeSafariBrowser();

  String userID;
   MyTasksScreen({Key? key,required this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bxkclr,
      appBar: AppBar(

        leadingWidth: 24,
        backgroundColor: bxkclr,
        elevation: 0,
        automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  finish(context);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.arrow_back_ios,color: textColor,size: 25,),
                    ),
                    Image.asset('assets/bluelogo.png',scale: 18,)
                  ],
                ),
              ),
              const Text("My Tasks",style: TextStyle(fontSize: 20,fontFamily: "Poppins",fontWeight: FontWeight.w600),),
              const SizedBox(), const SizedBox(),
            ],
          ),
        centerTitle: true,


      ),
      body: SingleChildScrollView(
        child: Column(
          children: [


            Consumer<UserProvider>(
                builder: (context,val,child) {
                  return  val.myPendingTaskList.isNotEmpty
                      ? const Padding(
                    padding: EdgeInsets.only(left: 13,top: 8,bottom: 8),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Pending Tasks",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500,fontSize: 13),)),
                  ):const SizedBox();
                }
            ),

            Consumer<UserProvider>(
                builder: (context,value1,child) {

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value1.myPendingTaskList.length,
                    itemBuilder: (context, index) {

                      var item2=value1.myPendingTaskList[index];
                      return  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                            isThreeLine: true,
                            tileColor: Colors.blue.shade50,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            title: Text(item2.heading,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "Poppins"),),
                            subtitle: Text(item2.task,style: const TextStyle(fontSize: 11,fontWeight: FontWeight.w400,fontFamily: "Poppins")),
                            trailing: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // SizedBox(height: 2,),

                                Text(item2.addedTime,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: "Poppins")),
                                const SizedBox(height: 7,),
                                item2.status=="PENDING"
                                    ? InkWell(
                                  onTap: () async {
                                    Uri url2=Uri.parse(item2.link);
                                    if  (url2.host.isNotEmpty){
                                      await browser.open(
                                          url: Uri.parse(item2.link),
                                          options: ChromeSafariBrowserClassOptions(
                                              android: AndroidChromeCustomTabsOptions(
                                                  shareState: CustomTabsShareState.SHARE_STATE_OFF),

                                              ios: IOSSafariOptions(barCollapsingEnabled: true)));
                                      value1.addMyTaskInToTaskCollection(item2.id,userID);
                                    }else{
                                      const snackBar = SnackBar(
                                        content: Text("Link not ready!!!"),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 90,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: const Text("Attend",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: "Poppins",color: Colors.white),),
                                  ),
                                )
                                    :const SizedBox(),


                              ],
                            ),

                          ),
                        ),
                      );
                    },);
                }
            ),

            Consumer<UserProvider>(
              builder: (context,val,child) {
                return  val.myAttendTaskList.isNotEmpty
                    ? const Padding(
                  padding: EdgeInsets.only(left: 13,top: 8,bottom: 8),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Previous Tasks",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500,fontSize: 13),)),
                ):const SizedBox();
              }
            ),
            Consumer<UserProvider>(
                builder: (context,value1,child) {
                  return value1.myAttendTaskList.isNotEmpty
                      ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value1.myAttendTaskList.length,
                    itemBuilder: (context, index) {
                      var item=value1.myAttendTaskList[index];
                      return  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: InkWell(
                          onTap: () async {
                            Uri url=Uri.parse(item.link);

                            if  (url.host.isNotEmpty){
                              await browser.open(
                                  url: Uri.parse(item.link),
                                  options: ChromeSafariBrowserClassOptions(
                                      android: AndroidChromeCustomTabsOptions(
                                          shareState: CustomTabsShareState.SHARE_STATE_OFF),
                                      ios: IOSSafariOptions(barCollapsingEnabled: true)));

                            }else{
                              const snackBar = SnackBar(
                                content: Text("Link not ready!!!"),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }

                          },
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: ListTile(
                              isThreeLine: true,
                              tileColor: Colors.blue.shade50,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              title: Text(item.heading,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "Poppins"),),
                              subtitle: Text(item.task,style: const TextStyle(fontSize: 11,fontWeight: FontWeight.w400,fontFamily: "Poppins")),
                              trailing: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // SizedBox(height: 2,),

                                  Text(item.addedTime,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: "Poppins")),
                                  const SizedBox(height: 7,),
                                  item.status=="ATTEND"
                                      ?const Text("Done",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: "Poppins",color: Colors.black),)
                                      :const SizedBox(),

                                  const SizedBox(height: 3,),

                                ],
                              ),

                            ),
                          ),
                        ),
                      );

                    },):const SizedBox(

                  );
                }
            ),

            Consumer<UserProvider>(
                builder: (context,value1,child) {
                return value1.myAttendTaskList.isEmpty&&value1.myPendingTaskList.isEmpty
                    ?SizedBox(
                  height: height*.7,
                  child: const Center(child: Text("No Tasks Yet.")),
                )
                    :const SizedBox();
              }
            )

          ],
        ),
      ),
    );
  }
}
