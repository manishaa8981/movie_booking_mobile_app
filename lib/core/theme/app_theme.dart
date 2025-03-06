import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Color palette
  static const Color _lightPrimary =
      Color.fromARGB(237, 243, 121, 28); // Vibrant orange
  static const Color _lightSecondary =
      Color.fromARGB(237, 243, 121, 28); // Light orange
  static const Color _darkPrimary =
      Color.fromARGB(237, 243, 121, 28); // Deeper orange
  static const Color _darkSecondary =
      Color.fromARGB(237, 243, 121, 28); // Deep orange accent

  static ThemeData getApplicationTheme({required bool isDarkMode}) {
    return ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      useMaterial3: true,

      // Color Scheme with improved contrast and harmony
      colorScheme: isDarkMode
          ? ColorScheme.dark(
              primary: _darkPrimary,
              secondary: _darkSecondary,
              surface: const Color(0xFF1E1E1E),
              onPrimary: Colors.white,
              onSecondary: Colors.white,
            )
          : ColorScheme.light(
              primary: _lightPrimary,
              secondary: _lightSecondary,
              surface: Colors.white,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
            ),

      // Scaffold Background
      scaffoldBackgroundColor:
          isDarkMode ? const Color(0xFF121212) : const Color(0xFFF5F5F5),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : _lightPrimary,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isDarkMode ? _darkPrimary : _lightPrimary,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          elevation: 3,
        ),
      ),

      // TextField Theme
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(15),
        filled: true,
        fillColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? const Color(0xFF333333) : Colors.grey[300]!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? const Color(0xFF333333) : Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? _darkPrimary : _lightPrimary,
            width: 2.0,
          ),
        ),
        labelStyle: TextStyle(
          fontSize: 16,
          color: isDarkMode ? Colors.white70 : Colors.black87,
          letterSpacing: 0.5,
        ),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: isDarkMode ? _darkPrimary : _lightPrimary,
        linearTrackColor: isDarkMode ? Colors.white24 : Colors.grey[300],
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        selectedItemColor: isDarkMode ? _darkPrimary : _lightPrimary,
        unselectedItemColor: isDarkMode ? Colors.white54 : Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showUnselectedLabels: true,
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black87,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: isDarkMode ? Colors.white70 : Colors.black87,
        ),
      ),
    );
  }
}
