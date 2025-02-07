import 'package:json_annotation/json_annotation.dart';
import 'package:movie_ticket_booking/features/dashboard/data/model/movie_api_model.dart';

part 'get_all_movie_dto.g.dart';

@JsonSerializable()
class GetAllMovieDTO {
  final List<MovieApiModel> data;

  GetAllMovieDTO({
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllMovieDTOToJson(this);

  factory GetAllMovieDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllMovieDTOFromJson(json);
}
