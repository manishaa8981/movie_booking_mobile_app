import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false) {
    _loadTheme(); // Load saved theme on initialization
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode') ?? false;
    emit(isDark);
  }

  Future<void> toggleTheme() async {
    final newTheme = !state;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', newTheme);
    emit(newTheme);
  }
}
