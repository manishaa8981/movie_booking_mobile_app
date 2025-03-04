import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData getApplicationTheme({required bool isDarkMode}) {
    return ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      useMaterial3: true,

      // Color Scheme
      colorScheme: isDarkMode
          ? const ColorScheme.dark(
              primary: Colors.orange,
              secondary: Colors.deepOrangeAccent,
            )
          : const ColorScheme.light(
              primary: Colors.orange,
              secondary: Colors.deepOrangeAccent,
            ),

      // Scaffold Background
      scaffoldBackgroundColor: isDarkMode ? Colors.black : Colors.grey[200],

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkMode ? Colors.black87 : Colors.orange,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      // TextField Theme
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(15),
        filled: true,
        fillColor: isDarkMode ? Colors.grey[900] : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.orange, width: 2.0),
        ),
        labelStyle: TextStyle(
          fontSize: 18,
          color: isDarkMode ? Colors.white : Colors.black87,
        ),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.orange,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDarkMode ? Colors.black : Colors.orangeAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: isDarkMode ? Colors.grey[400] : Colors.black,
        type: BottomNavigationBarType.fixed,
        elevation: 2,
      ),
    );
  }
}
