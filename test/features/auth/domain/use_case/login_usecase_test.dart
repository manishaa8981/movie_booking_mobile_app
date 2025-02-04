import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/auth/domain/use_case/login_usecase.dart';
import 'auth_repo.mock.dart';
import 'token.mock.dart';

void main() {
  late MockAuthRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late LoginUseCase useCase;

  setUp(() {
    repository = MockAuthRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    useCase = LoginUseCase(tokenSharedPrefs, repository);

    // Register fallback values for mocked objects
    registerFallbackValue(LoginParams(username: 'test', password: 'test123'));
  });

  test('should return a token when login is successful', () async {
    const username = 'testUser';
    const password = 'testPass';
    const token = 'mock_token';
    final loginParams = LoginParams(username: username, password: password);

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((_) async => Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => Right(null));

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => Future.value(Right(token)));

    final result = await useCase(loginParams);

    expect(result, Right(token));

    verify(() => repository.loginUser(username, password)).called(1);
    verify(() => tokenSharedPrefs.saveToken(token)).called(1);
    verify(() => tokenSharedPrefs.getToken()).called(1);
  });

  test('should return a failure when login fails', () async {
    const username = 'wrongUser';
    const password = 'wrongPass';
    final loginParams = LoginParams(username: username, password: password);

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((_) async => Left(ApiFailure(message: "Invalid login")));

    final result = await useCase(loginParams);

    expect(result, Left(ApiFailure(message: "Invalid login")));

    verify(() => repository.loginUser(username, password)).called(1);
    verifyNever(() => tokenSharedPrefs.saveToken(any()));
  });

  tearDown(() {
    reset(repository);
    reset(tokenSharedPrefs);
  });
}
