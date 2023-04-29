import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class SnackBarMessage {
  static void showAwesomeSnackBar(
      {required String message,
      required BuildContext context,
      required ContentType contentType}) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'insert',
        message: message,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showQuickAlert({
    required String message,
    required BuildContext context,
    required QuickAlertType contentType,
  }) {
    QuickAlert.show(
      context: context,
      type: contentType,
      text: message,
      showCancelBtn: true,
      animType: QuickAlertAnimType.slideInUp,
    );
  }
}
