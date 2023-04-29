import 'package:app_excle/core/resources/size_config.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  BaseButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.colorText,
  });
  final String text;
  final void Function() onPressed;
  Color? backgroundColor;
  Color? colorText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: SizeConfig.blockSizeVertical! * 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor ?? Colors.grey,
            animationDuration: const Duration(seconds: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              color: colorText ?? Color.fromARGB(255, 222, 79, 69),
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
