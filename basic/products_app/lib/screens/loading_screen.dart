import 'package:flutter/material.dart';

class LoadingScrenn extends StatelessWidget {
  const LoadingScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: const Center(
        child: CircularProgressIndicator(
          color: Color(0xffe76f51),
        ),
      ),
    );
  }
}