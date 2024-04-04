import 'package:flutter/material.dart';

callNext(var className, var context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => className),
  );
}

callNextReplacement(var className, var context){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => className),
  );
}
 finish(context) {
  Navigator.pop(context);
}

bool keyboardIsVisible(BuildContext context) {
  return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
}
