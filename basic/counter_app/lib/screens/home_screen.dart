// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    const fontSize20 = TextStyle(fontSize: 20);
    int counter = 10;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        elevation: 10,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Clicks Counter', style: fontSize20),
              Text('$counter', style: fontSize20),              
            ],
          ),        
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: FloatingActionButton(
            child: const Icon( Icons.add ),
            onPressed: () {
              counter++;
              print('Hi $counter');
            }
          ),
    );
  }

}
