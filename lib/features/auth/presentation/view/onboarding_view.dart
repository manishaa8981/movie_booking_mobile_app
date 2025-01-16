import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/app/di/di.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view/login_view.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/on_boarding/on_boarding_cubit.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});

  final PageController _pageController = PageController();

  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/images/four.jpeg",
      "title": "Welcome to TheaterX",
      "description": "Discover and book tickets for the latest movies near you!"
    },
    {
      "image": "assets/images/three.webp",
      "title": "Book Instantly, No Need to Queue",
      "description": "Enjoy a seamless booking experience with just a few taps."
    },
    {
      "image": "assets/images/two.jpeg",
      "title": "Online Payment",
      "description": "Make secured payment within no time with online payment."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OnboardingCubit>(),
      child: BlocBuilder<OnboardingCubit, int>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                // Background gradient and image
                Positioned.fill(
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: _onboardingData.length,
                        onPageChanged: (index) {
                          context.read<OnboardingCubit>().emit(index);
                        },
                        itemBuilder: (context, index) {
                          return Image.asset(
                            _onboardingData[index]["image"]!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        },
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Color.fromARGB(200, 19, 19, 19),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 20.0),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(170, 19, 19, 19),
                          Color.fromARGB(200, 35, 4, 74),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _onboardingData[state]["title"]!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _onboardingData[state]["description"]!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            fontFamily: 'Poppins',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        _buildBottomControls(context, state),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomControls(BuildContext context, int currentPage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
            );
          },
          child: const Text(
            "Skip",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        Row(
          children: List.generate(
            _onboardingData.length,
            (index) => _buildDot(index, currentPage),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (currentPage == _onboardingData.length - 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
            } else {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: Text(
            currentPage == _onboardingData.length - 1 ? "Get Started" : "Next",
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDot(int index, int currentPage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 10,
      width: currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
