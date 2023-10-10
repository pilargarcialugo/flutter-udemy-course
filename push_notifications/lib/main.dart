import 'package:flutter/material.dart';

import 'package:push_notifications/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      initialRoute: 'home',
      routes: {
        'home'    : (_) => const HomeScreen(),
        'message' : (_) => const MessageScreen()
      },
    );
  }
}