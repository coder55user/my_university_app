import 'package:flutter/material.dart';

class NavigatorManager {

    //navigate To  

  static void navigateTo({
    required BuildContext context,
    required Widget page,
  }) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  //navigate To With Animation

  static void navigateToWithAnimation({
    required BuildContext context,
    required Widget page,
  }) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
