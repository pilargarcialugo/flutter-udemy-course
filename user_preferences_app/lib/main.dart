import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:user_preferences_app/preferences/preferences.dart';
import 'package:user_preferences_app/providers/providers.dart';
import 'package:user_preferences_app/screens/screens.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routerName,
      routes: {
        HomeScreen.routerName     : (_) => const HomeScreen(),
        SettingsScreen.routerName : (_) => const SettingsScreen(),
      },
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(isDarkModeEnabled: Preferences.isDarkModeenabled))
      ],
      child: const MyApp(),
    )
  );
} 
