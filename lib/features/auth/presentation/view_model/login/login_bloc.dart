import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/core/common/snackbar/my_snackbar.dart';
import 'package:movie_ticket_booking/features/auth/domain/use_case/login_usecase.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:movie_ticket_booking/features/home/presentation/view/home_view.dart';
import 'package:movie_ticket_booking/features/home/presentation/view_model/home_cubit.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterBloc _registerBloc;
  final HomeCubit _homeCubit;
  final LoginUseCase _loginUseCase;

  LoginBloc({
    required RegisterBloc registerBloc,
    required HomeCubit homeCubit,
    required LoginUseCase loginUseCase,
  })  : _registerBloc = registerBloc,
        _homeCubit = homeCubit,
        _loginUseCase = loginUseCase,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _registerBloc,
            child: event.destination,
          ),
        ),
      );
    });

    on<NavigateHomeScreenEvent>((event, emit) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _homeCubit,
            child: event.destination,
          ),
        ),
      );
    });

    on<LoginUserEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));
        final result = await _loginUseCase.call(
          LoginParams(
            username: event.username,
            password: event.password,
          ),
        );
        result.fold(
          (l) {
            emit(state.copyWith(isLoading: false, isSuccess: false));
            mySnackBar(
              context: event.context,
              message: "Invalid Credentials",
              color: Colors.red,
            );
          },
          (token) {
            emit(state.copyWith(isLoading: false, isSuccess: true));
            mySnackBar(
              context: event.context,
              message: "Login Successful!",
              color: Colors.green,
            );

            add(
              NavigateHomeScreenEvent(
                context: event.context,
                destination: const HomeView(),
              ),
            );

            // Optionally, store the token in HomeCubit
            //_homeCubit.setToken(token);
          },
        );
      },
    );
  }
}




// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final LoginUseCase _loginUseCase;
//   final GetCurrentUserUseCase _getCurrentUserUseCase;qx
//   final ForgotPasswordUseCase _forgotPasswordUseCase;
//   final ResetPasswordUseCase _resetPasswordUseCase;
//   final TokenSharedPrefs _tokenSharedPrefs;

//   LoginBloc({
//     required LoginUseCase loginUseCase,
//     required GetCurrentUserUseCase getCurrentUserUseCase,
//     required ForgotPasswordUseCase forgotPasswordUseCase,
//     required ResetPasswordUseCase resetPasswordUseCase,
//     required TokenSharedPrefs tokenSharedPrefs,
//   })  : _loginUseCase = loginUseCase,
//         _getCurrentUserUseCase = getCurrentUserUseCase,
//         _forgotPasswordUseCase = forgotPasswordUseCase,
//         _resetPasswordUseCase = resetPasswordUseCase,
//         _tokenSharedPrefs = tokenSharedPrefs,
//         super(LoginState.initial()) {
//     on<LoginUserEvent>(_onLoginUser);
//     on<GetUserInfoEvent>(_onGetUserInfo);
//     on<ForgotPasswordRequested>(_onForgotPasswordRequested);
//     on<ResetPasswordRequested>(_onResetPasswordRequested);
//   }

//   /// 🔹 Handle Login
//   Future<void> _onLoginUser(
//       LoginUserEvent event, Emitter<LoginState> emit) async {
//     emit(state.copyWith(isLoading: true));

//     final result = await _loginUseCase(
//       LoginParams(email: event.email, password: event.password),
//     );

//     result.fold(
//       (failure) {
//         emit(state.copyWith(isLoading: false, errorMessage: "Invalid Credentials"));
//         showMySnackBar(
//           context: event.context,
//           message: "Invalid Credentials",
//           color: Colors.red,
//         );
//       },
//       (token) async {
//         await _tokenSharedPrefs.saveToken(token);
//         emit(state.copyWith(isLoading: false, isSuccess: true));

//         showMySnackBar(
//           context: event.context,
//           message: "Login Successful",
//           color: Colors.green,
//         );

//         // ✅ Redirect to Home Screen
//         Navigator.pushReplacement(
//           event.context,
//           MaterialPageRoute(builder: (context) => const HomeView()),
//         );
//       },
//     );
//   }

//   /// 🔹 Fetch User Info
//   Future<void> _onGetUserInfo(
//     GetUserInfoEvent event,
//     Emitter<LoginState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true));

//     final result = await _getCurrentUserUseCase(event.authId);

//     result.fold(
//       (failure) {
//         emit(state.copyWith(isLoading: false, errorMessage: failure.message));
//       },
//       (user) {
//         emit(state.copyWith(isLoading: false, user: user));
//       },
//     );
//   }

//   /// 🔹 Handle Forgot Password Request
//   Future<void> _onForgotPasswordRequested(
//       ForgotPasswordRequested event, Emitter<LoginState> emit) async {
//     emit(state.copyWith(isLoading: true));

//     final result = await _forgotPasswordUseCase(
//       ForgotPasswordParams(email: event.email, phone: event.phone),
//     );

//     result.fold(
//       (failure) {
//         emit(state.copyWith(isLoading: false, errorMessage: failure.message));
//         showMySnackBar(
//           context: event.context,
//           message: "Failed to send OTP: ${failure.message}",
//           color: Colors.red,
//         );
//       },
//       (_) {
//         emit(state.copyWith(isLoading: false, isOtpSent: true));
//         showMySnackBar(
//           context: event.context,
//           message: "OTP sent successfully. Check your email/phone.",
//           color: Colors.green,
//         );

//         // ✅ Navigate to Reset Password View
//         Navigator.push(
//           event.context,
//           MaterialPageRoute(
//             builder: (context) => ResetPasswordView(
//               emailOrPhone: event.email ?? event.phone!,
//             ),
//           ),
//         );
//       },
//     );
//   }

//   /// 🔹 Handle Reset Password Request
//   Future<void> _onResetPasswordRequested(
//       ResetPasswordRequested event, Emitter<LoginState> emit) async {
//     emit(state.copyWith(isLoading: true));

//     final result = await _resetPasswordUseCase(
//       ResetPasswordParams(
//         email: event.emailOrPhone.contains("@") ? event.emailOrPhone : null,
//         phone: event.emailOrPhone.contains("@") ? null : event.emailOrPhone,
//         otp: event.otp,
//         newPassword: event.newPassword,
//       ),
//     );

//     result.fold(
//       (failure) {
//         emit(state.copyWith(isLoading: false, errorMessage: failure.message));
//         showMySnackBar(
//           context: event.context,
//           message: "Failed to reset password: ${failure.message}",
//           color: Colors.red,
//         );
//       },
//       (_) {
//         emit(state.copyWith(isLoading: false, isPasswordReset: true));
//         showMySnackBar(
//           context: event.context,
//           message: "Password reset successfully. Please log in.",
//           color: Colors.green,
//         );

//         // ✅ Redirect to login screen
//         Navigator.pop(event.context);
//       },
//     );
//   }
// }
