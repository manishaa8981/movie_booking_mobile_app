import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_ticket_booking/app/constants/hive_table_constant.dart';
import 'package:movie_ticket_booking/features/auth/domain/entity/auth_entity';
import 'package:uuid/uuid.dart';

part'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.authTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? authId;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;


  AuthHiveModel({
    String? authId,
    required this.username,
    required this.email,
    required this.password,
  }) : authId = authId ?? const Uuid().v4();

//Initial Constructor
  const AuthHiveModel.initial()
      : authId = '',
        username = '',
        email = '',
        password = '';

// From Entity
  factory AuthHiveModel.fromEntity(AuthEntity authEntity) {
    return AuthHiveModel(
        authId: authEntity.authId,
        username: authEntity.username,
        email: authEntity.email,
        password: authEntity.password);
  }

// To Entity
  AuthEntity toEntity() {
    return AuthEntity(
        authId: authId,
        fullName: '',
        email: email,
        contactNo: '',
        image: null,
        username: username,
        password: '');
  }

// From Entity List
  static List<AuthHiveModel> fromEntityList(List<AuthEntity> entityList) {
    return entityList
        .map((authEntity) => AuthHiveModel.fromEntity(authEntity))
        .toList();
  }

  @override
  List<Object?> get props => [authId, username];
}
