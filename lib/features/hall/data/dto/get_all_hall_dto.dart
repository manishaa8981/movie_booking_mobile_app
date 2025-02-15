import 'package:json_annotation/json_annotation.dart';
import 'package:movie_ticket_booking/features/hall/data/model/hall_api_model.dart';


@JsonSerializable()
class GetAllHallsDto {
  final List<HallApiModel> data;

  GetAllHallsDto({
    required this.data,
  });

  factory GetAllHallsDto.fromJson(List<dynamic> jsonList) {
    return GetAllHallsDto(
        data: jsonList
            .map((e) => HallApiModel.fromJson(e as Map<String, dynamic>))
            .toList());
  }
  List<Map<String, dynamic>> toJson() => data.map((e) => e.toJson()).toList();
}
