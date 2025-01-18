import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EditButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    return IconButton(
      icon:
          Icon(Icons.edit, color: Color(0xFFFFC107), size: widthScreen * 0.064),
      onPressed: onPressed,
    );
  }
}
