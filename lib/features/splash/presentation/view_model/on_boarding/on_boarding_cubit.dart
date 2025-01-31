import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view/login_view.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/login/login_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit(this._loginBloc)
      : super(0); // Initial state is the first page

  void nextPage(int totalPages) {
    if (state < totalPages - 1) {
      emit(state + 1);
    }
  }

  void skip() {
    emit(-1); // Special state to signal skipping
  }

  final LoginBloc _loginBloc;

  void openLoginView(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _loginBloc,
                  child: const LoginView(),
                )));
  }
}
