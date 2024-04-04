import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../Provider/user_provider.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_texts.dart';

class TextForm extends StatelessWidget {
  final String labelText;
  final TextEditingController txtController;

  const TextForm(
      {Key? key,required this.labelText, required this.txtController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 53,
      child: labelText == "Referral ID/Mobile Number"
          ?TextFormField(
        controller: txtController,
        autofocus: false,
        style: const TextStyle(fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontFamily: "PoppinsRegular"),
        keyboardType: TextInputType.phone,
        inputFormatters:[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: labelText,
          labelStyle: TextStyle(color: cl5F5F5F.withOpacity(.7)),
          contentPadding:
          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          focusedBorder: customEnabledBorder,
          enabledBorder: customEnabledBorder2,
          errorBorder: customEnabledBorder,
            focusedErrorBorder: customEnabledBorder
        ),
        validator: (txt) {
            if (txt!.trim().isEmpty) {
                return 'Enter Referral ID';
            } else {
              return null;
            }
        },
      )
          :TextFormField(
        textCapitalization: labelText == "Name"
            ?TextCapitalization.characters
            :TextCapitalization.none,
        controller: txtController,
        autofocus: false,
        style: const TextStyle(fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontFamily: "PoppinsRegular"),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: labelText,
            labelStyle: TextStyle(color: cl5F5F5F.withOpacity(.7)),
            contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            focusedBorder: customEnabledBorder,
            enabledBorder: customEnabledBorder2,
            errorBorder: customEnabledBorder,
            focusedErrorBorder: customEnabledBorder
        ),
        validator: (txt) {
          if(labelText == "Email Address"){
            String pattern =r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
            RegExp regex = RegExp(pattern);
            if (txt == null || txt.isEmpty || !regex.hasMatch(txt)) {
              return 'Enter a valid email address';
            } else {
              return null;
            }
          }else if(labelText == "Name"){
            if (txt!.trim().isEmpty) {
              return 'Enter Your Name';
            }else if (!RegExp(
                r'^[A-Z. ]+$')
                .hasMatch(txt)) {
              return "Please use uppercase English letters only.";
            } else {
              return null;
            }
          }
          else{
            if (txt!.trim().isEmpty) {
              return 'Enter your Upi ID';
            } else {
              return null;
            }
          }
        },
      ),
    );
  }
}


