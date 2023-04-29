import 'package:app_excle/core/themes/light_mode.dart';
import 'package:flutter/material.dart';

class BaseTable extends StatelessWidget {
  BaseTable({
    super.key,
    this.firstChildren,
    this.secondChildren,
    this.child,
    this.child2,
  });
  List<Widget>? firstChildren;
  List<Widget>? secondChildren;
  Widget? child;
  Widget? child2;
  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      border: TableBorder.all(
        width: 2.0,
        borderRadius: BorderRadius.circular(8),
        color: ColorsManager.gray,
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorsManager.white,
          ),
          children: firstChildren,
          // children: [
          //   child!,
          // ]),
        ),
        TableRow(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey,
          ),
          // children: [
          //   child2!,
          // ],
          children: secondChildren,
        ),
      ],
    );
  }
}

class _myInput extends StatelessWidget {
  const _myInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TextField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintStyle: TextStyle(),
        fillColor: Colors.transparent,
        hintText: "0.0",
        border: InputBorder.none,
      ),
    );
  }
}

class _myText extends StatelessWidget {
  const _myText({
    super.key,
    required this.degree,
  });
  final String degree;
  @override
  Widget build(BuildContext context) {
    return Text(
      degree,
      textScaleFactor: 1.5,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.black),
    );
  }
}
