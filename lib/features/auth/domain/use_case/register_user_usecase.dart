import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_ticket_booking/app/usecase/usecase.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/auth/domain/entity/auth_entity';
import 'package:movie_ticket_booking/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String? authId;
  final String fullName;
  final String email;
  final String? image;
  final String contactNo;
  final String username;
  final String password;

  const RegisterUserParams({
  this.authId,
  required this.fullName,
  required this.email,
  this.image,
  required this.contactNo,
  required this.username,
  required this.password,
  });

  //intial constructor
  const RegisterUserParams.initial({
  this.authId,
  required this.fullName,
  required this.email,
  this.image,
  required this.contactNo,
  required this.username,
  required this.password,
  });

  @override
  List<Object?> get props =>
      [fullName, email, image, contactNo, username, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      fullName: params.fullName,
      email: params.email,
      image: params.image,
      contactNo: params.contactNo,
      username: params.username,
      password: params.password,
    );
    return repository.registerUser(authEntity);
  }
}
