import 'package:app_excle/core/resources/assets_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatefulWidget {
  MyTextFormField({
    super.key,
    required this.hintText,
    this.labelText,
    this.textAlign = TextAlign.start,
    this.keyboardType,
    this.suffixIcon,
    this.height,
    this.onChanged,
    this.controller,
    this.messageValidate,
    this.validator,
  });
  String? hintText;
  String? Function(String?)? validator;
  String? labelText;
  String? messageValidate;
  double? height;
  TextEditingController? controller;
  TextAlign? textAlign;
  Widget? suffixIcon;
  TextInputType? keyboardType;

  /// مراقبة إدخال النص
  final Function(String text)? onChanged;

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // color: Colors.white,
        color: const Color(0xffEDECEA),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(186, 141, 141, 141),
            blurRadius: 1,
            offset: Offset(0, 1),
            spreadRadius: 2,
          ),
        ],

        border: Border.all(color: Color(0xffEDECEA), width: 0.8),
      ),
      child: TextFormField(
        inputFormatters: [
          // FilteringTextInputFormatter.allow(RegExp(r"^\+?0[0-9]{10}$")
          //     // RegExp(r"[a-zA-Z]+|\s"),
          //     ),
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return widget.messageValidate ?? "The Field Cant Be Empty";
          }
          return null;
        },
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textDirection: TextDirection.rtl,
        textAlign: widget.textAlign!,
        decoration: InputDecoration(
          labelText: widget.labelText,
          filled: false,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontFamily: AssetsFonts.medium,
            fontSize: 18,
            color: Colors.grey,
          ),
          helperStyle: Theme.of(context).textTheme.headlineSmall,
          suffixIcon: widget.suffixIcon,
          border: InputBorder.none,
          labelStyle: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.grey),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}

extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}
