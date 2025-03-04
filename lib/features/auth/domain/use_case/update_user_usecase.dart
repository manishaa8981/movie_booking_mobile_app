// import 'package:dartz/dartz.dart';
// import 'package:movie_ticket_booking/features/auth/domain/repository/auth_repository.dart';
// import '../../../../app/shared_prefs/token_shared_prefs.dart';
// import '../../../../app/usecase/usecase.dart';
// import '../../../../core/error/failure.dart';

// class UpdateUserParams {
//   final String authId; // ✅ Already contains authId
//   final String username;
//   final String contactNo;
//   final String email;
//   final String password;
//   final String? image;

//   const UpdateUserParams({
//     required this.authId,
//     required this.username,
//     required this.contactNo,
//     required this.email,
//     required this.password,
//     this.image,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'authId': authId,
//       'email': email,
//       'contactNo': contactNo,
//       'username': username,
//       'password': password,
//       'image': image,
//     };
//   }
// }

// class UpdateUserUsecase implements UsecaseWithParams<void, UpdateUserParams> {
//   final IAuthRepository authRepository;
//   final TokenSharedPrefs tokenSharedPrefs;

//   const UpdateUserUsecase({
//     required this.authRepository,
//     required this.tokenSharedPrefs,
//   });

//   @override
//   Future<Either<Failure, void>> call(UpdateUserParams params) async {
//     // ✅ Fetch Token Correctly
//     final tokenResult = await tokenSharedPrefs.getToken();

//     return tokenResult.fold(
//       (failure) => Left(failure), // Handle failure if token retrieval fails
//       (token) async {
//         // ✅ Use `params.authId` since it’s already passed in UpdateUserParams
//         return await authRepository.(
//           params.authId, // ✅ No need to get authId from TokenSharedPrefs
//           token,
//           params.toJson(),
//         );
//       },
//     );
//   }
// }
