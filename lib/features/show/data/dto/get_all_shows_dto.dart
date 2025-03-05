import 'package:json_annotation/json_annotation.dart';
import 'package:movie_ticket_booking/features/show/data/model/show_api_model.dart';

part 'get_all_shows_dto.g.dart';

@JsonSerializable()
class GetAllShowsDto {
  final List<ShowApiModel> data;

  GetAllShowsDto({required this.data});

  factory GetAllShowsDto.fromJson(dynamic json) {
    if (json == null) {
      throw Exception("API returned null instead of a valid response");
    }
    if (json is List) {
      print("✅ INSIDE FROM JSON:::: $json");

      try {
        // Remove nulls & filter invalid entries
        List<ShowApiModel> parsedData = json
            .where((e) => e != null && e is Map<String, dynamic>)
            .map((e) {
              try {
                return ShowApiModel.fromJson(e as Map<String, dynamic>);
              } catch (error) {
                print(" Skipping invalid entry: $e - Error: $error");
                return null; // Skip invalid items instead of crashing
              }
            })
            .whereType<ShowApiModel>()
            .toList();

        return GetAllShowsDto(data: parsedData);
      } catch (e, stackTrace) {
        print(" Error parsing GetAllShowsDto: $e\nStack Trace: $stackTrace");
        throw Exception("Error parsing GetAllShowsDto: ${e.toString()}");
      }
    } else {
      throw Exception(
          "Invalid response format: Expected List but got ${json.runtimeType}");
    }
  }

  List<Map<String, dynamic>> toJson() => data.map((e) => e.toJson()).toList();
}
