// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:movie_ticket_booking/app/usecase/usecase.dart';
// import 'package:movie_ticket_booking/core/error/failure.dart';
// import 'package:movie_ticket_booking/features/auth/domain/entity/auth_entity';
// import 'package:movie_ticket_booking/features/auth/domain/repository/auth_repository.dart';

// class GetUserByIdParams extends Equatable {
//   final String authId;

//   const GetUserByIdParams({required this.authId});

//   const GetUserByIdParams.empty() : authId = "_empty.string";

//   @override
//   List<Object?> get props => [authId];
// }

// class GetUserByIdUsecase implements UsecaseWithParams<void, GetUserByIdParams> {
//   final IAuthRepository repository;

//   const GetUserByIdUsecase({required this.repository});

//   @override
//   Future<Either<Failure, AuthEntity>> call(GetUserByIdParams params) async {
//     return await repository.getUserById(params.authId);
//   }
// }
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/auth/domain/entity/auth_entity';
import 'package:movie_ticket_booking/features/auth/domain/repository/auth_repository.dart';

import '../../../../app/shared_prefs/token_shared_prefs.dart';
import '../../../../app/usecase/usecase.dart';

class GetUserByIdParams extends Equatable {
  final String authId;

  const GetUserByIdParams({required this.authId});

  const GetUserByIdParams.empty() : authId = "_empty.string";

  @override
  List<Object?> get props => [authId];
}

class GetUserByIdUsecase implements UsecaseWithParams<void, GetUserByIdParams> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  GetUserByIdUsecase({
    required this.repository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, AuthEntity>> call(GetUserByIdParams params) async {
    final authIdResult = await tokenSharedPrefs.getAuthId();
    final tokenResult = await tokenSharedPrefs.getToken();

    return authIdResult.fold(
      (failure) => Left(failure), // Return failure if `authId` is missing
      (authId) => tokenResult.fold(
        (failure) => Left(failure), // Return failure if `token` is missing
        (token) {
          // ✅ Call the API with customerId & token
          return repository.getUserById(authId);
        },
      ),
    );
  }
}
