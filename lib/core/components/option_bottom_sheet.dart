import 'package:app_excle/core/utils/navigator_manager.dart';
import 'package:app_excle/features/students/presentation/view/pages/home_students_screen.dart';
import 'package:flutter/material.dart';

class OptionBottomSheet extends StatelessWidget {
  const OptionBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "option",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}

class _itemOption extends StatelessWidget {
  const _itemOption({super.key, required this.text, required this.onTap});
  final String text;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CircleAvatar(
                // child: Icon(Icons.add),
                ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
