import 'package:app_excle/core/components/base_button.dart';
import 'package:app_excle/core/themes/light_mode.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

Future<void> showMyDialog({
  required BuildContext context,
  void Function()? onPressedExcel,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: ColorsManager.backGround,
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              BaseButton(
                onPressed: () {
                  onPressedExcel!();
                  Navigator.pop(context);
                },
                text: "Export File Excel",
                colorText: Colors.white,
                backgroundColor: ColorsManager.gray,
              ),
              BaseButton(
                onPressed: () {},
                text: "Export File Pdf",
                colorText: Colors.white,
                backgroundColor: ColorsManager.main,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
