import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/my_colors.dart';

Widget textField(String text, Color color) {
  return TextField(
    decoration: InputDecoration(
      filled: true,
      enabled: false,
      fillColor: color,
      disabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 0.5),
      ),
      label: Text(
        text,
        style: TextStyle(color: myWhite),
      ),
    ),
  );
}

Widget profileTextField(
  TextEditingController controller,
  Color color,
) {
  return Consumer<UserProvider>(builder: (context, val12, child) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        letterSpacing: 0.32,
      ),
      decoration: InputDecoration(
        filled: true,
        enabled: val12.editCheck2 == true ? true : false,
        fillColor: color,
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  });
}

Widget profileTextFieldPhone(
    TextEditingController controller, String from, Color color, int length) {
  return Consumer<UserProvider>(builder: (context, val12, child) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
        LengthLimitingTextInputFormatter(length)
      ],
      validator: (txt) {
        if (txt!.trim().isEmpty && txt.trim().length == length) {
          return "Enter Your Number";
        } else {
          return null;
        }
        return null;
      },
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        letterSpacing: 0.32,
      ),
      decoration: InputDecoration(
        filled: true,
        // enabled:val12.editCheck2==true?true: false,
        enabled: false,

        fillColor: color,
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  });
}

Widget TextField2(TextInputType type, String hint, String from,
    TextEditingController controllers, int length) {
  return Consumer<UserProvider>(builder: (context, val11, child) {
    return TextFormField(
      enabled: val11.editCheck == true ? true : false,
      keyboardType: type,
      controller: controllers,
      textCapitalization: TextCapitalization.characters,

      inputFormatters: [

        FilteringTextInputFormatter.singleLineFormatter,
        LengthLimitingTextInputFormatter(length)
      ],
      validator: (txt) {
        if (txt!.trim().isEmpty || txt.trim().length != length) {
          if (from == "PIN") {
            return "Enter Pin Code";
          } else if (from == "Nominee Year Of Birth") {
            return "Enter Nominee Year Of Birth";
          } else if (from == "NomineePhoneNo") {
            return 'Enter Nominee Phone Number';
          } else {
            return "Enter PAN Card Number";
          }
        } else {
          return null;
        }
      },
      style: const TextStyle(
          color: myWhite,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: "PoppinsRegular"),
      decoration: InputDecoration(
        filled: true,
        fillColor: textColor,
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 0.5,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
        hintText: hint,
        hintStyle: const TextStyle(
            color: myWhite,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: "PoppinsRegular"),
      ),
    );
  });
}

Widget TextFieldID(
  String hint,
  TextEditingController controllers,
) {
  return Consumer<UserProvider>(builder: (context, val11, child) {
    return TextFormField(
      enabled: val11.editCheck == true ? true : false,
      controller: controllers,
      validator: (txt) {
        if (txt!.trim().isEmpty) {
          return "Enter $hint Number";
        }
      },
      style: const TextStyle(
          color: myWhite,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: "PoppinsRegular"),
      decoration: InputDecoration(
        filled: true,
        fillColor: textColor,
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 0.5,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
        hintText: "${hint} ID Number",
        hintStyle: const TextStyle(
            color: myWhite,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: "PoppinsRegular"),
      ),
    );
  });
}

Widget TextField5(TextInputType type, String hint, String from,
    TextEditingController controllers) {
  return Consumer<UserProvider>(builder: (context, val11, child) {
    return TextFormField(
      enabled: val11.editCheck == true ? true : false,
      keyboardType: type,
      controller: controllers,
      validator: (txt) {
        if (txt!.trim().isEmpty) {
          if (from == "IFSC") {
            return 'Enter IFSC Code';
          } else if (from == 'Account No') {
            return 'Enter Account Number';
          }else if(from=="Nominee"){
            return "Nominee Name";
          }
          else {
            return 'Enter UPI ID';
          }
        } else {
          return null;
        }
      },
      style: const TextStyle(
          color: myWhite,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: "PoppinsRegular"),
      decoration: InputDecoration(
        filled: true,
        fillColor: textColor,
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
        hintText: hint,
        hintStyle: const TextStyle(
            color: myWhite,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: "PoppinsRegular"),
      ),
    );
  });
}

Widget searchBar(String from) {
  return Consumer<AdminProvider>(builder: (context, val40, child) {
    return TextFormField(
      onChanged: (value) {
        if (from == "MEMBERS") {
          val40.filterMembersLists(value);
        } else if (from == "BLOCKED_LIST") {
          val40.filterBlockedMembersLists(value);
        } else if (from == 'AdminPMC') {
          val40.filterAdminPMC(value);
        } else if (from == 'Admin_CMF') {
          val40.filterAdminDonation(value);
        } else if (from == "TOTAL_REGISTRATION") {
          val40.filterPendingRegistrations(value);
        } else if (from == "PARTICIPANTS") {
          val40.filterParticipants(value);
        } else if (from == "referral") {
          val40.filtertotalReferrals(value);
        } else if (from == "ADMIN_UPGRADE") {
          val40.filterGiveHelpReport(value);
        } else {}
      },
      cursorColor: Colors.black54,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          hintText: "Search...",
          suffixIcon:
              const Icon(Icons.search_rounded, color: Colors.black, size: 32),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(200)))),
    );
  });
}

TextStyle menuStyle = TextStyle(
    color: myWhite,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: "PoppinsRegular");
TextStyle profileStyle = TextStyle(
    color: clE0E0E0,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: "PoppinsRegular");

TextStyle appbarStyle = TextStyle(
    color: myWhite,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontFamily: "PoppinsRegular");
