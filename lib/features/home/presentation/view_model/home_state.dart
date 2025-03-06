import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/app/di/di.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/profile/profile_bloc.dart';
import 'package:movie_ticket_booking/features/booking/presentation/view/booking_view.dart';
import 'package:movie_ticket_booking/features/booking/presentation/view_model/booking_bloc.dart';
import 'package:movie_ticket_booking/features/dashboard/presentation/view/movie_view.dart';
import 'package:movie_ticket_booking/features/dashboard/presentation/view_model/movie_bloc.dart';
import 'package:movie_ticket_booking/features/home/presentation/view/bottom_view/profile.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        BlocProvider(
          create: (context) => getIt<MovieBloc>(),
          child: MovieView(),
        ),
        BlocProvider(
          create: (context) => getIt<BookingBloc>(),
          child: BookingView(),
        ),
        BlocProvider(
          create: (context) => getIt<ProfileBloc>(),
          child: ProfileView(),
        ),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
