import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/auth/domain/entity/auth_entity';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerUser(AuthEntity user);

  Future<Either<Failure, String>> loginUser(String username, String password);

  Future<Either<Failure, String>> uploadProfilePicture(File file);
  
  Future<Either<Failure, AuthEntity>> getCurrentUser();

  Future<Either<Failure, AuthEntity>> getUserById(String id);

}
