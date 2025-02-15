import 'package:json_annotation/json_annotation.dart';
import 'package:movie_ticket_booking/features/show/data/model/show_api_model.dart';

@JsonSerializable()
class GetAllShowsDto {
  final List<ShowApiModel> data;

  GetAllShowsDto({
    required this.data,
  });

  factory GetAllShowsDto.fromJson(List<dynamic> jsonList) {
    return GetAllShowsDto(
        data: jsonList
            .map((e) => ShowApiModel.fromJson(e as Map<String, dynamic>))
            .toList());
  }
  List<Map<String, dynamic>> toJson() => data.map((e) => e.toJson()).toList();
}
