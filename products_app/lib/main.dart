import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:products_app/screens/screens.dart';
import 'package:products_app/services/services.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService(),),
        ChangeNotifierProvider(create: (_) => ProductService(),),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Forms App',
      initialRoute: 'login',
      routes: {
        'login'   : (_) => const LoginScreen(),
        'register': (_) => const RegisterScreen(),
        'check'   : (_) => const CheckAuthScreen(),

        'home'    : (_) => const HomeScreen(),
        'product' : (_) => const ProductScreen(),
      },
      scaffoldMessengerKey: AlertService.messengerKey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xffF2E9E4),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Color(0xffe76f51)
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 0,
          backgroundColor: Color(0xffe76f51)
        )
      ),
    );
  }
}
