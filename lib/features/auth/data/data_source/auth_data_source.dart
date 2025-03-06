
import 'dart:io';

import 'package:movie_ticket_booking/features/auth/domain/entity/auth_entity';

abstract interface class IAuthDataSource {
  Future<String> loginUser(String username, String password);

  Future<void> registerUser(AuthEntity user);

  Future<AuthEntity> getCurrentUser();

  Future<String> uploadProfilePicture(File file);

  Future<AuthEntity> getUserById(String id);

  Future<void> updateUser(
      String id, String token, Map<String, dynamic> userData);

}