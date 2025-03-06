import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _sharedPreferences.setString('token', token);
      return Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> saveAuthData(
      String authId, String token) async {
    try {
      await _sharedPreferences.setString('authId', authId);
      await _sharedPreferences.setString('token', token);
      print("🔐 Stored Auth ID: $authId");
      print("🔐 Stored Token: $token");
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> getAuthId() async {
    try {
      final authId = _sharedPreferences.getString('authId');
      return authId != null
          ? Right(authId)
          : Left(SharedPrefsFailure(message: "User ID not found"));
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      return Right(token ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
