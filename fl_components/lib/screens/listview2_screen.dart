import 'package:flutter/material.dart';

class Listview2Screen extends StatelessWidget {

  final options = const['Jean', 'Tao'];
  final greenColor = const Color.fromARGB(255, 66, 110, 52);
   
  const Listview2Screen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listview Tipo 2'),
        backgroundColor: greenColor,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => ListTile(
              title: Text(options[index]),
              trailing: const Icon( Icons.arrow_right, color: Color.fromARGB(255, 66, 110, 52), ),
              onTap: () => print(options[index]),
            ), 
        separatorBuilder: (_, __) => const Divider(), 
        itemCount: options.length)
    );
  }
}