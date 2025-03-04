import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/core/theme/app_theme.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/profile/profile_bloc.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:movie_ticket_booking/features/dashboard/presentation/view_model/movie_bloc.dart';
import 'package:movie_ticket_booking/features/hall/presentation/view-model/hall_bloc.dart';
import 'package:movie_ticket_booking/features/seat/presentation/view-model/seat_bloc.dart';
import 'package:movie_ticket_booking/features/show/presentation/view-model/show_bloc.dart';
import 'package:movie_ticket_booking/features/splash/presentation/view/splash_view.dart';
import 'package:movie_ticket_booking/features/splash/presentation/view_model/on_boarding/on_boarding_cubit.dart';
import 'package:movie_ticket_booking/features/splash/presentation/view_model/splash_cubit.dart';

import 'di/di.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (_) => getIt<SplashCubit>(),
        ),
        BlocProvider<OnboardingCubit>(
          create: (_) => getIt<OnboardingCubit>(),
        ),
        BlocProvider<LoginBloc>(
          create: (_) => getIt<LoginBloc>(),
        ),
        BlocProvider<RegisterBloc>(
          create: (_) => getIt<RegisterBloc>(),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => getIt<ProfileBloc>(),
        ),
        BlocProvider<MovieBloc>(
          create: (_) => getIt<MovieBloc>(),
        ),
        BlocProvider<ShowBloc>(
          create: (_) => getIt<ShowBloc>(),
        ),
        BlocProvider<HallBloc>(
          create: (_) => getIt<HallBloc>(),
        ),
        BlocProvider<SeatBloc>(
          create: (_) => getIt<SeatBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie Ticket Booking',
        theme: AppTheme.getApplicationTheme(isDarkMode: false),
        home: const SplashView(),
      ),
    );
  }
}
