import 'package:flutter/material.dart';

ThemeData getThemeData() {
  return ThemeData(
    primarySwatch: Colors.orange,
    fontFamily: 'Roboto Regular',
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFD98639),
      textStyle: const TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto Bold',
      ),
    )),
    appBarTheme: const AppBarTheme(
      color: Color.fromARGB(255, 58, 57, 58),
      elevation: 2,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
