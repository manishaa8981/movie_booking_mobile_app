import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/login/login_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final LoginBloc _loginBloc;

  RegisterBloc({
    required LoginBloc loginBloc,
  })  : _loginBloc = loginBloc,
        super(RegisterState.initial()) {
    on<NavigateLoginScreenEvent>((event, emit) {
      Navigator.push(
          event.context,
          MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: _loginBloc,
                    child: event.destination,
                  )));
    });
  }
}
