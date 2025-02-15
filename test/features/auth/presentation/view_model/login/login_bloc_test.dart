// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:movie_ticket_booking/core/error/failure.dart';
// import 'package:movie_ticket_booking/features/auth/domain/use_case/login_usecase.dart';
// import 'package:movie_ticket_booking/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:movie_ticket_booking/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:movie_ticket_booking/features/home/presentation/view_model/home_cubit.dart';

// class MockRegisterBloc extends Mock implements RegisterBloc {}

// class MockHomeCubit extends Mock implements HomeCubit {}

// class MockLoginUseCase extends Mock implements LoginUseCase {}

// class MockBuildContext extends Mock implements BuildContext {}

// class Failure {
//   final String message;
//   const Failure({required this.message});
// }

// void main() {
//   late MockRegisterBloc mockRegisterBloc;
//   late MockHomeCubit mockHomeCubit;
//   late MockLoginUseCase mockLoginUseCase;
//   late LoginBloc loginBloc;
//   final mockContext = MockBuildContext();

//   setUp(() {
//     mockRegisterBloc = MockRegisterBloc();
//     mockHomeCubit = MockHomeCubit();
//     mockLoginUseCase = MockLoginUseCase();
//     loginBloc = LoginBloc(
//       registerBloc: mockRegisterBloc,
//       homeCubit: mockHomeCubit,
//       loginUseCase: mockLoginUseCase,
//     );
//     registerFallbackValue(LoginParams(username: 'test', password: 'test'));
//   });

//   tearDown(() {
//     loginBloc.close();
//   });

//   test('initial state should be LoginState.initial()', () {
//     expect(loginBloc.state, LoginState.initial());
//   });

//   blocTest<LoginBloc, LoginState>(
//     'emits [loading, failure] when login fails',
//     build: () {
//       when(() => mockLoginUseCase.call(any())).thenAnswer(
//           (_) async => Left(ApiFailure(message: 'Invalid Credentials')));
//       return loginBloc;
//     },
//     act: (bloc) => bloc.add(LoginUserEvent(
//       context: mockContext, // Mock context if needed
//       username: 'wronguser',
//       password: 'wrongpass',
//     )),
//     expect: () => [
//       LoginState.initial().copyWith(isLoading: true),
//       LoginState.initial().copyWith(isLoading: false, isSuccess: false),
//     ],
//   );

//   blocTest<LoginBloc, LoginState>(
//     'emits [loading, failure] when login fails',
//     build: () {
//       when(() => mockLoginUseCase.call(any())).thenAnswer(
//           (_) async => Left(ApiFailure(message: 'Invalid Credentials')));
//       return loginBloc;
//     },
//     act: (bloc) => bloc.add(LoginUserEvent(
//       context: mockContext, // Fixed context
//       username: 'wronguser',
//       password: 'wrongpass',
//     )),
//     expect: () => [
//       LoginState.initial().copyWith(isLoading: true),
//       LoginState.initial().copyWith(isLoading: false, isSuccess: false),
//     ],
//   );
// }
