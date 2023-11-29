// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {

  int counter = 10;

  void increase() {
    counter++;
    setState(() {});
  }

  void decrease() {
    counter--;
    setState(() {});
  }

  void reset() {
    counter = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    const fontSize20 = TextStyle(fontSize: 20);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter"),
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
          
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
      floatingActionButton: CustomFloatingActions(
        increaseFn: increase, 
        decreaseFn: decrease, 
        resetFn: reset, 
      ),
    );
  }
}

class CustomFloatingActions extends StatelessWidget {

  final Function increaseFn;
  final Function decreaseFn;
  final Function resetFn;

  const CustomFloatingActions({
    Key? key, 
    required this.increaseFn, 
    required this.decreaseFn, 
    required this.resetFn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          onPressed: () => decreaseFn(),
          child: const Icon( Icons.exposure_minus_1 )
        ),
        
        FloatingActionButton(
          onPressed: () => resetFn(),
          child: const Icon( Icons.restore )
        ),

        FloatingActionButton(
          onPressed: () => increaseFn(),
          child: const Icon( Icons.exposure_plus_1 )
        ),
      ],
    );
  }
}
