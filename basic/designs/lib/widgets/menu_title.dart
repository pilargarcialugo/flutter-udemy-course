import 'package:flutter/material.dart';

class MenuTitle extends StatelessWidget {
  const MenuTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Applicaciones', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
            SizedBox(height: 5,),
            Text('Desarrollos en Java, Dart, Python, y otros :)', style: TextStyle(fontSize: 16, color: Colors.white),),
          ],
        ),
      ),
    );
  }
}