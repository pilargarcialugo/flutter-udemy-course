import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {

  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;

  final String formProperty;
  final Map<String, dynamic> formValues;

  const CustomInputField({
    Key? key, 
    this.hintText, 
    this.labelText, 
    this.helperText, 
    this.suffixIcon, 
    this.keyboardType, 
    this.obscureText= false, 
    required this.formProperty, 
    required this.formValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: (value) => formValues[formProperty] = value,
      validator: (value) {
        if (value == null) return 'Field required';
        if (value.length < 3) return 'Minimum of 3 letters required';
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
        suffixIcon: suffixIcon == null ? null : Icon(suffixIcon)
      ),
    );
  }
}
