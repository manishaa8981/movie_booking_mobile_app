import 'dart:io';

import 'package:dio/dio.dart';
import 'package:movie_ticket_booking/app/constants/api_endpoints.dart';
import 'package:movie_ticket_booking/features/auth/data/data_source/auth_data_source.dart';
import 'package:movie_ticket_booking/features/auth/data/model/auth_api_model.dart';
import 'package:movie_ticket_booking/features/auth/domain/entity/auth_entity';

class AuthRemoteDatasource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDatasource(this._dio);

  @override
  Future<String> registerUser(AuthEntity authEntity) async {
    try {
      var authApiModel = AuthApiModel.fromEntity(authEntity);
      var response = await _dio.post(
        ApiEndpoints.register,
        data: authApiModel.toJson(),
      );

      if (response.statusCode == 200) {
        return response.data['message'] ?? 'Registration successful';
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> loginUser(String username, String password) async {
    try {
      Response response = await _dio.post(ApiEndpoints.login, data: {
        "username": username,
        "password": password,
      });

      if (response.statusCode == 200) {
        final str = response.data['token'];
        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture':
              await MultipartFile.fromFile(file.path, filename: fileName),
        },
      );
      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
