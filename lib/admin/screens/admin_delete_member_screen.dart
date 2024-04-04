import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../Constants/functions.dart';
import '../../Provider/admin_provider.dart';
import '../../constants/my_colors.dart';
import 'admin_homeScreen.dart';

class DeleteMember extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DeleteMember({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: bxkclr,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 65,
        leadingWidth: 30,
        leading:InkWell(
          onTap: (){
            callNextReplacement(const AdminHomeScreen(),context);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Icon(Icons.arrow_back_ios,color: myWhite,),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/whitelogo.png",scale: 12,),
            const Text(
              'User Deletion',
              style: TextStyle(
                fontFamily: 'PoppinsRegular',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: myWhite,
              ),
            ),
            // const Spacer()
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.bottomLeft,
              colors: [
                cl005BBB,
                cl001969,
              ],
            ),
          ),
        ),
      ),
      body: SizedBox(
        width: width,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15,),
              Consumer<AdminProvider>(
                  builder: (context3,value11,child) {
                    return value11.isEligibleForDelete?SizedBox() :SizedBox(
                      width: width/1.25,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                        shadowColor: Colors.white.withOpacity(0.5),
                        child: TextFormField(
                          inputFormatters:[
                            LengthLimitingTextInputFormatter(15)
                          ],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize:13),
                          controller:value11.deleteUserController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 5),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              fillColor: Colors.grey,
                              filled: false,
                              hintText: 'Enter Registration ID',
                              hintStyle: const TextStyle(
                                color: Color(0xff5F5F5F),
                                fontSize: 10,
                                fontFamily: 'PoppinsRegular',
                              )),
                          validator: (txt) {
                            if (txt!.trim().isEmpty) {
                              return "Enter ID" ;
                            }else if (txt.trim().length!=15) {
                              return "Enter Correct ID" ;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    );
                  }
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer<AdminProvider>(
                  builder: (context4,value132,child) {
                    return value132.isEligibleForDelete? SizedBox():Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        shadowColor: Colors.white.withOpacity(0.5),
                        child: InkWell(
                          onTap: () async {
                            final FormState? form =
                                _formKey.currentState;
                            if (form!.validate()) {
                              value132. checkUserDeletionEligibility(value132.deleteUserController.text,context);
                            }},
                          child: Container(
                              alignment: Alignment.center,
                              width: width,
                              height: 55,
                              decoration: BoxDecoration(
                                border: Border.all(color: clF4F6F8,width: 2),
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  begin: Alignment.bottomRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    cl005BBB,
                                    cl001969,
                                  ],
                                ),
                              ),
                              child:const Text("Check Eligibility",
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: myWhite),)),
                        ),
                      ),
                    );
                  }
              ),


              Consumer<AdminProvider>(
                  builder: (context4,value102,child) {
                    return value102.isEligibleForDelete? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                      child: Material(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        shadowColor: Colors.white.withOpacity(0.5),
                        child: Container(
                          width: width,
                          padding: const EdgeInsets.only(top: 10, left: 11,bottom: 10,right: 11),
                          // height: 89,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                          value102.deleteUserImage!=""? value102.deleteUserImage :
                                          "https://img.freepik.com/premium-vector/user-interface-icon-cartoon-style-illustration_161751-2838.jpg?w=740" ))),
                              Text(
                                value102.deleteUserName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    fontFamily: 'PoppinsRegular'),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                value102.deleteUserNumber,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    fontFamily: 'PoppinsRegular'),
                              ),
                              Text(
                                value102. deleteUserId,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    fontFamily: 'PoppinsRegular'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ):const SizedBox();
                  }
              ),

              Consumer<AdminProvider>(
                  builder: (context4,value102,child) {
                    return value102.isEligibleForDelete?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        shadowColor: Colors.white.withOpacity(0.5),
                        child: InkWell(
                          onTap: ()  {

                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                      contentPadding: EdgeInsets.zero,
                                      content: Container(
                                        height: 222,
                                        width: 335,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          gradient: const LinearGradient(
                                              begin: Alignment.bottomRight,
                                              end: Alignment.bottomLeft,
                                              colors: [cl005BBB,
                                                cl001969,]),
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 50,
                                            ),
                                            const Text(
                                              '       Are you sure\nwant to Delete ?',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),

                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  height: 39,
                                                  width: 120,
                                                  child: ElevatedButton(
                                                      style: ButtonStyle(elevation: MaterialStateProperty.all(0),
                                                          textStyle: MaterialStateProperty.all(const TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w900)),
                                                          backgroundColor:
                                                          MaterialStateProperty.all( grdintclr1),
                                                          shape: MaterialStateProperty.all(
                                                              RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(60)))),
                                                      onPressed: () {finish(context);},
                                                      child: const Text('Cancel',
                                                          style: TextStyle(
                                                              color: Color(0xffFFFCF8),
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w900))),
                                                ),
                                                SizedBox(
                                                  height: 39,
                                                  width: 120,
                                                  child: ElevatedButton(
                                                      style: ButtonStyle(elevation: MaterialStateProperty.all(0),
                                                          textStyle: MaterialStateProperty.all(const TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w900)),
                                                          backgroundColor:
                                                          MaterialStateProperty.all(                                              const Color(0xffFFFCF8),),
                                                          shape: MaterialStateProperty.all(
                                                              RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(60)))),
                                                      onPressed: () {
                                                        value102.deleteUser(value102. deleteUserId,context);
                                                      },
                                                      child:value102.loaderDelete? CircularProgressIndicator(color:Colors.red.shade900,) : const Text('Delete',
                                                          style: TextStyle(
                                                              color:  Color(0xff1746A2),
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w900))),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ));
                                }
                            );



                          },
                          child: Container(
                              alignment: Alignment.center,
                              width: width,
                              height: 55,
                              decoration: BoxDecoration(
                                border: Border.all(color: clF4F6F8,width: 2),
                                borderRadius: BorderRadius.circular(20),
                                gradient:  LinearGradient(
                                  begin: Alignment.bottomRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.redAccent,
                                    Colors.red.shade900,
                                  ],
                                ),
                              ),
                              child:const Text("Delete User",
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: myWhite),)),
                        ),
                      ),
                    )
                        :const SizedBox();
                  }
              )

            ],
          ),
        ),
      ),
    );
  }
}