import 'package:app_excle/core/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

Future<void> showBottomSheetFunction({
  required BuildContext context,
  required Widget child,
  double? height,
  Color? backgroundColor,
}) async {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12), topRight: Radius.circular(12)),
    ),
    backgroundColor: ColorsManager.backGround,
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: child.animate().fade(duration: 500.ms),
      );
    },
  );
}
