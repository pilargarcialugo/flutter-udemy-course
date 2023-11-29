import 'package:flutter/material.dart';

class Listview1Screen extends StatelessWidget {

  final options = const['Jean', 'Tao'];
   
  const Listview1Screen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listview Tipo 1'),
      ),
      body: ListView(
        children: [

          ...options.map(
            (pet) => ListTile(
              title: Text(pet),
              trailing: const Icon( Icons.arrow_right ),
            )
          ).toList(),

        ],
      )
    );
  }
}