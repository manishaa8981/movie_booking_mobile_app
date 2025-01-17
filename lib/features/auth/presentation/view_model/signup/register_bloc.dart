// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_ticket_booking/core/common/snackbar/my_snackbar.dart';
// import 'package:movie_ticket_booking/features/auth/domain/use_case/register_user_usecase.dart';
// import 'package:movie_ticket_booking/features/auth/presentation/view_model/login/login_bloc.dart';

// part 'register_event.dart';
// part 'register_state.dart';

// class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
//   // final LoginBloc _loginBloc;
//   final RegisterUseCase _registerUseCase;

//   RegisterBloc({
//     required LoginBloc loginBloc,
//     required RegisterUseCase registerUsecase, required Object registerUseCase,
//   })  :
//         // _loginBloc = loginBloc,
//         _registerUseCase = registerUsecase,
//         super(RegisterState.initial()) {
//     // on<NavigateLoginScreenEvent>((event, emit) {
//     //   Navigator.push(
//     //       event.context,
//     //       MaterialPageRoute(
//     //           builder: (context) => BlocProvider.value(
//     //                 value: _loginBloc,
//     //                 child: event.destination,
//     //               )));
//     // });

//     on<RegisterUserEvent>((event, emit) async {
//       emit(state.copyWith(isLoading: true));
//       final result = await _registerUseCase(
//         RegisterUserParams(
//           fullName: event.full_name,
//           email: event.email,
//           contactNo: event.contact_no,
//           username: event.username,
//           password: event.password,
//         ),
//       );

//       result.fold(
//         (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
//         (r) {
//           emit(state.copyWith(isLoading: false, isSuccess: true));
//           mySnackBar(
//               context: event.context, message: "Registration Successful");
//         },
//       );
//     });
//   }
// }
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/core/common/snackbar/my_snackbar.dart';
import 'package:movie_ticket_booking/features/auth/domain/use_case/register_user_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterBloc({required RegisterUseCase registerUseCase})
      : _registerUseCase = registerUseCase,
        super(RegisterState.initial()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await _registerUseCase(
        RegisterUserParams(
          fullName: event.fullName,
          email: event.email,
          contactNo: event.contactNo,
          username: event.username,
          password: event.password,
        ),
      );

      result.fold(
        (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (r) {
          emit(state.copyWith(isLoading: false, isSuccess: true));
          mySnackBar(
              context: event.context, message: "Registration Successful");
        },
      );
    });
  }
}
