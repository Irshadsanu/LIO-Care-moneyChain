import 'package:flutter/material.dart';
import 'package:lio_care/Constants/functions.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:provider/provider.dart';
import '../../constants/my_colors.dart';

class AdminBlockParticipantScreen extends StatelessWidget {
  final String name;
  final String regId;
  final String number;
  final String proImage;
  final String from;

   AdminBlockParticipantScreen(
      {Key? key,
      required this.name,
      required this.regId,
      required this.number,
      required this.proImage,
      required this.from,

      })
      : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: bxkclr,
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            finish(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: myWhite,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment(0.92, -0.40),
                  end: Alignment(-0.92, 0.4),
                  colors: [cl001969, cl005BBB])),
        ),
        elevation: 0,

      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children:
            [
              const SizedBox(
                height: 15,
              ),

              proImage == ""
                  ? const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person_rounded),
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(proImage),
                    ),
              const SizedBox(
                height: 14,
              ),
              Text(
                name,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: "PoppinsRegular"),
              ),
              Text(
                "Reg. No:$regId",
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                    fontFamily: "PoppinsRegular"),
              ),
              Text(
                "+91$number",
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontFamily: "PoppinsRegular"),
              ),

              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 18.5, top: 40),
                  child: Text(
                    "Why You Blocking ?",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: "PoppinsRegular"),
                  ),
                ),
              ),
              Consumer<AdminProvider>(
                builder: (context,val22,child) {

                  return SizedBox(
                    height:250,
                    width: width/1.1,
                    child: ListView.builder(
                      itemCount: 5,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 45,
                          padding: const EdgeInsets.only(
                            top: 11,
                            left: 11,
                            right: 91,
                            bottom: 12,
                          ),
                          margin: const EdgeInsets.only(bottom: 4),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [Color(0xFFFFFCF8), Colors.white],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x11000000),
                                blurRadius: 8,
                                offset: Offset(2, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child:
                              Row(children: [

                               Radio(value:val22.blockingReasons[index],
                                   groupValue:val22.selectedReason,
                                   onChanged: (value){
                                 val22.radioFun(value);
                               }),
                                Text(
                           val22.blockingReasons[index],
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontFamily: "PoppinsRegular"),
                          ),],)
                        );
                      },
                    ),
                  );
                }
              ),
              // Consumer<AdminProvider>(
              //   builder: (context,val30,child) {
              //     return InkWell(
              //       onTap: (){val30.reportOtherCheckFun();},
              //       child: Container(
              //         width: width/1.1,
              //           height: 43,
              //           padding: const EdgeInsets.only(
              //             top: 11,
              //             left: 11,
              //             right: 91,
              //             bottom: 12,
              //           ),
              //           margin: const EdgeInsets.only(bottom: 4),
              //           decoration: const BoxDecoration(
              //             gradient: LinearGradient(
              //               begin: Alignment(0.00, -1.00),
              //               end: Alignment(0, 1),
              //               colors: [Color(0xFFFFFCF8), Colors.white],
              //             ),
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Color(0x11000000),
              //                 blurRadius: 8,
              //                 offset: Offset(2, 4),
              //                 spreadRadius: 0,
              //               )
              //             ],
              //           ),
              //           child:const Text("Others...")
              //
              //
              //       ),
              //     );
              //   }
              // ),
              Consumer<AdminProvider>(
                builder: (context,val23,child) {
                  return val23.reportOtherCheck==true? Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: myWhite, boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 2),
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ]),
                    width: width/1.1,
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 2,
                      maxLines: null,
                      controller: val23.blockingReasonController,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "PoppinsRegular"),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: myWhite,
                        disabledBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white, width: 0.5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white, width: 0.5),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white, width: 0.5),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white, width: 0.5),
                        ),
                        hintText: "Reason.....",
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: "PoppinsRegular"),
                      ),
                      validator: (txt) {
                        if (txt!.trim().isEmpty) {
                         return "Enter Reason" ;
                        } else {
                          return null;
                        }
                      },
                    ),
                  ):const SizedBox();
                }
              ),

              const SizedBox(
                height: 20,
              ),

              Consumer<AdminProvider>(
                builder: (context,val45,child) {
                  return InkWell(
                    onTap: (){
                      final FormState? form = _formKey.currentState;
                      if (form!.validate()){
                        // if(from=="Participants"){
                        //   val45.participantsBlockAlert(context,regId,name);
                        // }
                        // else{
                          val45. blockAlert(context,"BLOCK",regId,name);

                        // }


                      }
                    },
                    child: Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                        color: textColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Center(
                        child: Text(
                          "Block",
                          style: TextStyle(
                              color: myWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "PoppinsRegular"),
                        ),
                      ),
                    ),
                  );
                }
              ) ,
            ],
          ),
        ),
      ),
    );
  }


}




