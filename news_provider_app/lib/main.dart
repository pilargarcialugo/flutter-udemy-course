import 'package:flutter/material.dart';
import 'package:news_provider_app/pages/pages.dart';
import 'package:news_provider_app/services/news_service.dart';
import 'package:news_provider_app/theme/custom_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsService(),
        )
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        theme: customTheme,
        home: const TabsPage()
      ),
    );
  }
}