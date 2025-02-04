import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/auth/domain/entity/auth_entity';
import 'package:movie_ticket_booking/features/auth/domain/use_case/register_user_usecase.dart';

import 'auth_repo.mock.dart';

void main() {
  late RegisterUseCase useCase;
  late MockAuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    useCase = RegisterUseCase(repository);
  });

  const registerParams = RegisterUserParams(
    email: 'test@example.com',
    image: 'profile.jpg',
    contactNo: '1234567890',
    username: 'testuser',
    password: 'password123',
  );

  final authEntity = AuthEntity(
    email: registerParams.email,
    image: registerParams.image,
    contactNo: registerParams.contactNo,
    username: registerParams.username,
    password: registerParams.password,
  );

  test('should call registerUser in the repository with correct params',
      () async {
    // Arrange
    when(() => repository.registerUser(authEntity))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await useCase(registerParams);

    // Assert
    expect(result, const Right(null));
    verify(() => repository.registerUser(authEntity)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return Left(Failure) when registration fails', () async {
    // Arrange
    final failure = ApiFailure(message: 'Registration failed');
    when(() => repository.registerUser(authEntity))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase(registerParams);

    // Assert
    expect(result, Left(failure));
    verify(() => repository.registerUser(authEntity)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
