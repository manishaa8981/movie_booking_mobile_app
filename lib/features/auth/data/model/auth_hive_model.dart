import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_ticket_booking/app/constants/hive_table_constant.dart';
import 'package:movie_ticket_booking/features/auth/domain/entity/auth_entity';
import 'package:uuid/uuid.dart';

@HiveType(typeId: HiveTableConstant.authTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? authId;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String email;

  AuthHiveModel({
    String? authId,
    required this.username,
    required this.email,
  }) : authId = authId ?? const Uuid().v4();

//Initial Constructor
  const AuthHiveModel.initial()
      : authId = '',
        username = '',
        email = '';

// From Entity
  factory AuthHiveModel.fromEntity(AuthEntity authEntity) {
    return AuthHiveModel(
        authId: authEntity.authId,
        username: authEntity.username,
        email: authEntity.email);
  }

// To Entity
  AuthEntity toEntity() {
    return AuthEntity(
        authId: authId,
        full_name: '',
        email: email,
        contact_no: '',
        image: null,
        username: username,
        password: '');
  }

// From Entity List
  static List<AuthHiveModel> fromEntityList(List<AuthEntity> entityList) {
    return entityList.map((authEntity) => AuthHiveModel.fromEntity(authEntity)).toList();
  }

  @override
  List<Object?> get props => [authId, username];
}
