import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:movie_ticket_booking/features/auth/domain/entity/auth_entity';
import 'package:movie_ticket_booking/features/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRemoteRepository(this._authRemoteDatasource);

  @override
  Future<Either<Failure, String>> registerUser(AuthEntity authEntity) async {
    try {
      final message = await _authRemoteDatasource.registerUser(authEntity);
      return Right(message);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginUser(
      String username, String password) async {
    try {
      final token = await _authRemoteDatasource.loginUser(username, password);
      return Right(token);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName = await _authRemoteDatasource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, AuthEntity>> getUserById(String id) async {
      try {
      final user = await _authRemoteDatasource.getUserById(id);
      return Right(user); // Successfully fetched user
    } catch (e) {
      return Left(ApiFailure(
          message: e
              .toString())); // Handle error (ServerFailure can be customized to represent different types of failures)
    }
  }
  
  @override
  Future<Either<Failure, void>> updateUser(String id, String token, Map<String, dynamic> userData) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
