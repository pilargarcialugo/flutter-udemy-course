import 'package:flutter/material.dart';

class Listview2Screen extends StatelessWidget {

  final options = const['Jean', 'Tao'];
   
  const Listview2Screen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listview Tipo 2'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => ListTile(
              title: Text(options[index]),
              trailing: const Icon( Icons.arrow_right ),
            ), 
        separatorBuilder: (_, __) => const Divider(), 
        itemCount: options.length)
    );
  }
}