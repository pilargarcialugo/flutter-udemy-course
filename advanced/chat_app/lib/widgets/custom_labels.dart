import 'package:flutter/material.dart';

class CustomLabels extends StatelessWidget {
  const CustomLabels({super.key, 
  required this.registerRoute, 
  required this.gestureDetectorText, 
  required this.mainText});

  final String registerRoute;
  final String gestureDetectorText;
  final String mainText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          mainText, 
          style: const TextStyle(color: Color(0xff495057), fontSize: 15, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 10,),
        GestureDetector(
          child: Text(
            gestureDetectorText, 
            style: const TextStyle(color: Color(0xff212529), fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, registerRoute);
          },
        ),
      ],
    );
  }
}