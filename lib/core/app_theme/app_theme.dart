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
          centerTitle: true,
          color: Colors.amber,
          elevation: 4,
          shadowColor: Colors.black,
          titleTextStyle: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)));
}
