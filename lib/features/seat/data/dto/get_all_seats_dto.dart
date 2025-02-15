import 'package:json_annotation/json_annotation.dart';
import 'package:movie_ticket_booking/features/seat/data/model/seat_api_model.dart';

@JsonSerializable()
class GetAllSeatsDto {
  final List<SeatApiModel> data;

  GetAllSeatsDto({
    required this.data,
  });

  factory GetAllSeatsDto.fromJson(List<dynamic> jsonList) {
    return GetAllSeatsDto(
        data: jsonList
            .map((e) => SeatApiModel.fromJson(e as Map<String, dynamic>))
            .toList());
  }
  List<Map<String, dynamic>> toJson() => data.map((e) => e.toJson()).toList();
}
