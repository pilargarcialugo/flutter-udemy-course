import 'package:flutter/material.dart';

final customTheme = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme(
    background: Color(0xff264653),
    onBackground: Color(0xff264653),  
    brightness: Brightness.dark, 
    primary: Color(0xfff4a261), 
    onPrimary: Color(0xfff4a261), 
    secondary: Color(0xffe9c46a), 
    onSecondary: Color(0xffe9c46a), 
    error: Color(0xff2a9d8f), 
    onError: Color(0xff2a9d8f), 
    surface: Color(0xfff4a261), 
    onSurface: Color(0xfff4a261), 
  )
);