import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastServes {
  // ToastServes.fToast = FToast();
  // ToastServes.fToast!.init(context);
  static FToast? fToast;

  static showToastCancel() {
    Widget toastWithButton = Container(
      // height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color.fromARGB(120, 255, 255, 255),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisSize: MainAxisSize.min,
        children: [
          const Expanded(
            child: Text(
              "هل تريد حفظ مكان قرائتك",
              softWrap: true,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              fToast!.removeCustomToast();
            },
            child:
                SvgPicture.asset('assets/icon/back.svg', color: Colors.black),
          ),
        ],
      ),
    );
    fToast!.showToast(
      child: toastWithButton,
      gravity: ToastGravity.CENTER,
      toastDuration: const Duration(seconds: 50),
    );
  }

  //!
  static showToast({String? message}) {
    Fluttertoast.showToast(
      msg: message ?? 'This is a Top Long Toast',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
