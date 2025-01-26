import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view/onboarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    //Timer to navigate to the next screen after 3 seconds.
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => OnboardingView()),
      );
    });
  }

// Timer(const Duration(seconds: 3), () {
//   Navigator.pushReplacementNamed(context, '/login');
// });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF111827),
          // color: Color.fromARGB(255, 19, 33, 87),// gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [
          //     Color(0xFF2E1371), // Top left color
          //     Color(0xFF130B2B), // Bottom right color
          //   ],
          // ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo/logo2.png',
                height: 120.0,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
