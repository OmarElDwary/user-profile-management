import 'package:flutter/material.dart';

class CustomConfirmationDialog extends StatelessWidget {
  CustomConfirmationDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.action1,
      required this.action2,
      required this.onPressed,
      required this.pressed});

  String title;
  String content;
  String action1;
  String action2;
  final void Function() onPressed;
  final void Function() pressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            onPressed();
          },
          child: Text(
            action1,
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            pressed();
          },
          child: Text(
            action2,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
