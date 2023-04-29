import 'package:flutter/material.dart';

class BaseMyText extends StatelessWidget {
  const BaseMyText({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaleFactor: 1.5,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.black),
    );
  }
}
