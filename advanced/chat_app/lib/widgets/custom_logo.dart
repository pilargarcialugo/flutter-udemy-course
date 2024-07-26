import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key, required this.label,});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Container(
          width: 170,
          margin: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              const Image(image: AssetImage('assets/chat-logo-256.png')),
              const SizedBox(height: 10,),
              Text(
                label, 
                style: const TextStyle(color: Color(0xff343a40), fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}