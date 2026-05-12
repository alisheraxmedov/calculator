import 'package:calculator/consts/colors.dart';
import 'package:flutter/material.dart';

class MyAppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    scaffoldBackgroundColor: ColorClass.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorClass.white,
      foregroundColor: ColorClass.black,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
    ),
    colorScheme: const ColorScheme.light(
      primary: ColorClass.blue,
      secondary: ColorClass.orginalWhite,
      onSecondary: ColorClass.orginalGrey,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: ColorClass.black),
      bodyMedium: TextStyle(color: Colors.black),
      headlineMedium: TextStyle(color: Colors.grey),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.amber,
    scaffoldBackgroundColor: ColorClass.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorClass.black,
      foregroundColor: ColorClass.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
    ),
    colorScheme: ColorScheme.dark(
      primary: ColorClass.orange,
      secondary: ColorClass.grey,
      onSecondary: ColorClass.orginalGrey,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: ColorClass.white),
      bodyMedium: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.grey),
    ),
  );
}
