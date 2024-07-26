import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key, 
    required this.buttonText, 
    this.onPressed,
  });

  final String buttonText;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        elevation: MaterialStatePropertyAll(2),
        shape: MaterialStatePropertyAll(StadiumBorder())
      ),
      onPressed: onPressed, 
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(buttonText, style: const TextStyle(fontSize: 15),)
        )
      )
    );
  }
}