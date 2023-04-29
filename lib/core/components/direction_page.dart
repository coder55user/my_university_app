import 'package:flutter/material.dart';

class DirectionPage extends StatelessWidget {
  const DirectionPage({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(body: SafeArea(child: child)),
    );
  }
}
