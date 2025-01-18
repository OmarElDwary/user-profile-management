import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  Color? cursorColor;
  IconButton? suffixIcon;
  Icon? prefixIcon;

  CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.cursorColor,
    this.suffixIcon,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        enableInteractiveSelection: true,
        cursorColor: Theme.of(context).primaryColor,
        controller: controller,
        decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.white),
            labelText: labelText,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder()),
        validator: validator,
        keyboardType: keyboardType,
      ),
    );
  }
}
