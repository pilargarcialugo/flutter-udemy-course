import 'package:flutter/material.dart';

class AppTheme {

  static const Color primaryDark =  Color.fromRGBO(2, 48, 71, 1);
  static const Color primaryLight =  Color.fromRGBO(33, 158, 188, 1);
  
  static final ThemeData  darkTheme = ThemeData.dark().copyWith(
        
    appBarTheme: const AppBarTheme(
      color: primaryDark,
      elevation: 0
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryDark
      )
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryDark
    )

  );

  static final ThemeData  lightTheme = ThemeData.light().copyWith(
        
    appBarTheme: const AppBarTheme(
      color: primaryLight,
      elevation: 0
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryLight
      )
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryLight
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryLight,
        shape: const StadiumBorder(),
        elevation: 0
      )
    ),

    dialogTheme: DialogTheme(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(15))
    )

  );

}