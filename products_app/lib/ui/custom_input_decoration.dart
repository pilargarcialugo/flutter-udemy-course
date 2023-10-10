import 'package:flutter/material.dart';

class CustomInputDecoration {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? icon
  }) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffe76f51),
        )
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffe76f51),
          width: 2
        )
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.grey
      ),
      prefixIcon: Icon(icon, color: const Color(0xffe76f51),)
    );
  }
}
