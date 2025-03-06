import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/failure.dart';

class UserSharedPrefs {
  late SharedPreferences _sharedPreferences;

  // Set User Details
  Future<Either<Failure, bool>> setUserData(List<String> data) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      await _sharedPreferences.setString('success', data[0]);
      await _sharedPreferences.setString('token', data[1]);
      await _sharedPreferences.setString('customerId', data[2]);
      await _sharedPreferences.setString('image', data[3]);
      await _sharedPreferences.setString('email', data[4]);
      await _sharedPreferences.setString('contact_no', data[5]);

      return Right(true);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Get User Data
  Future<Either<Failure, List<String?>>> getUserData() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final success = _sharedPreferences.getString('success');
      final token = _sharedPreferences.getString('token');
      final customerId = _sharedPreferences.getString('customerId');
      final image = _sharedPreferences.getString('image');
      final email = _sharedPreferences.getString('email');
      final contactNo = _sharedPreferences.getString('contact_no');
      return Right([success, token, customerId, image, email, contactNo]);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Clear User Data
  Future<Either<Failure, bool>> clear() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.clear();
      return Right(true);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
