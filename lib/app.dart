import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/view/home_view.dart';
import 'package:movie_ticket_booking/view/login_view.dart';
import 'package:movie_ticket_booking/view/sign_up_view.dart';
import 'package:movie_ticket_booking/view/splash_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashView(),
        '/login': (context) => const LoginView(),
        '/signup': (context) => const SignUpView(),
        '/home': (context) => HomeView(),
      },
    );
  }
}
