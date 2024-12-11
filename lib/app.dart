import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/view/home_view.dart';
import 'package:movie_ticket_booking/view/login_view.dart';
import 'package:movie_ticket_booking/view/sign_up_view.dart';
import 'package:movie_ticket_booking/view/splash_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashView(),
        '/login': (context) => LoginView(),
        '/signup': (context) => SignUpView(),
        '/home': (context) => HomeView(),
      },
    );
  }
}
