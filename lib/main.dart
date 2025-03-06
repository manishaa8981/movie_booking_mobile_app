import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/app/app.dart';
import 'package:movie_ticket_booking/app/di/di.dart';
import 'package:movie_ticket_booking/core/network/hive_service.dart';
import 'package:movie_ticket_booking/core/theme/app_theme.dart';
import 'package:movie_ticket_booking/core/theme/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();
  await initDependencies();
  
  final prefs = await SharedPreferences.getInstance();
  final authId = prefs.getString('authId');
  final token = prefs.getString('token');

  if (authId != null && token != null) {
    print("✅ User is already logged in with Auth ID: $authId");
  } else {
    print("🚀 No user logged in, redirecting to Login Screen...");
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()), // Theme Management
      ],
      child: const MyApp(), // ✅ Use MyApp to pass ThemeCubit to MaterialApp
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getApplicationTheme(isDarkMode: isDarkMode),
          home: const App(), // ✅ Ensure App widget listens to theme changes
        );
      },
    );
  }
}
