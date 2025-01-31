import 'package:json_annotation/json_annotation.dart';


part 'get_auth_dto.g.dart';

@JsonSerializable()
class GetAllAuthDTO{
  final bool succes;
  final String token;

  GetAllAuthDTO({
    required this.succes,
    required this.token,

  });

  Map<String, dynamic> toJson() => _$GetAllAuthDTOToJson(this); // suru ma error aauxa aauna dena .g banaye [pxi janxa

  factory GetAllAuthDTO.fromJson(Map<String , dynamic> json) => _$GetAllAuthDTOFromJson(json);

}