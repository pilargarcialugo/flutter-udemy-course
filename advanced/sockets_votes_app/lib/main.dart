import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sockets_votes_app/pages/pages.dart';
import 'package:sockets_votes_app/services/socket_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SocketService(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePage(),
          'status': (_) => const StatusPage()
        },
      ),
    );
  }
}