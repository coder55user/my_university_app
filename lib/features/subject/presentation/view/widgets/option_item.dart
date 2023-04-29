import 'package:app_excle/core/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ItemOption extends StatelessWidget {
  ItemOption({
    super.key,
    required this.text,
    required this.onTap,
    this.textAvatar,
    this.color,
  });
  final String text;
  String? textAvatar;
  Color? color;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorsManager.secondaryGray,
          border: Border.all(color: ColorsManager.backGround),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            CircleAvatar(
              radius: 16,
              backgroundColor: const Color.fromARGB(255, 186, 186, 186),
              child: Text(
                textAvatar ?? "1",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
