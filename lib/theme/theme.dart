import 'package:calculator/consts/colors.dart';
import 'package:flutter/material.dart';

class MyAppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.grey,
    colorScheme: const ColorScheme.light(
      primary: ColorClass.blue,
      onPrimary: ColorClass.white,
      secondary: ColorClass.orginalWhite,
      onSecondary: ColorClass.orginalGrey,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        color: ColorClass.black,
        
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        color: Colors.grey,
      ),
    ),

    
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.amber,
    colorScheme:  ColorScheme.dark(
      primary: ColorClass.orange,
      onPrimary: Colors.black,
      secondary: ColorClass.grey,
      onSecondary: ColorClass.orginalGrey,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        color: ColorClass.white,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        color: Colors.grey,
      ),
    ),
  );
}
