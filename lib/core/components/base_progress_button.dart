import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class BaseProgressButton extends StatelessWidget {
  const BaseProgressButton({
    super.key,
    required this.onPressed,
    this.buttonState = ButtonState.idle,
    this.text = "create",
  });
  final String text;
  final Function onPressed;
  final ButtonState buttonState;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ProgressButton(
        padding: EdgeInsets.all(8),
        radius: 20.0,
        stateWidgets: {
          ButtonState.idle: Text(
            text.toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
          ButtonState.loading: Text(
            "Loading".toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
          ButtonState.fail: Text(
            "Fail".toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
          ButtonState.success: Text(
            "Success".toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
          )
        },
        stateColors: {
          ButtonState.idle: Colors.deepPurple.shade500,
          ButtonState.loading: Colors.deepPurple.shade700,
          ButtonState.fail: Colors.red.shade300,
          ButtonState.success: Colors.green.shade400,
        },
        // iconedButtons: {
        //   //
        //   ButtonState.idle: IconedButton(
        //     text: text,
        //     icon: const Icon(Icons.send, color: Colors.white),
        //     color: Colors.deepPurple.shade500,
        //   ),
        //   //
        //   ButtonState.loading: IconedButton(
        //     text: "Loading",
        //     color: Colors.deepPurple.shade700,
        //   ),
        //   //
        //   ButtonState.fail: IconedButton(
        //     text: "Failed",
        //     icon: const Icon(Icons.cancel, color: Colors.white),
        //     color: Colors.red.shade300,
        //   ),
        //   //
        //   ButtonState.success: IconedButton(
        //     text: "Success",
        //     icon: const Icon(
        //       Icons.check_circle,
        //       color: Colors.white,
        //     ),
        //     color: Colors.green.shade400,
        //   )
        // },
        onPressed: onPressed,
        state: buttonState,
      ),
    );
  }
}
