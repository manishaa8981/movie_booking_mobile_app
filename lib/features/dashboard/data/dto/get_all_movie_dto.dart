import 'package:json_annotation/json_annotation.dart';
import 'package:movie_ticket_booking/features/dashboard/data/model/movie_api_model.dart';

part 'get_all_movie_dto.g.dart';

@JsonSerializable()
class GetAllMovieDTO {
  final List<MovieApiModel> data;

  GetAllMovieDTO({
    required this.data,
  });

  factory GetAllMovieDTO.fromJson(List<dynamic> jsonList) {
    return GetAllMovieDTO(
      data: jsonList
          .map((e) => MovieApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  List<Map<String, dynamic>> toJson() => data.map((e) => e.toJson()).toList();
}
