import 'package:dio/dio.dart';
import 'package:movie_ticket_booking/app/constants/api_endpoints.dart';
import 'package:movie_ticket_booking/features/show/data/data_source/show_datasource.dart';
import 'package:movie_ticket_booking/features/show/data/dto/get_all_shows_dto.dart';
import 'package:movie_ticket_booking/features/show/data/model/show_api_model.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';

class ShowRemoteDatasource implements IShowDataSource {
  final Dio _dio;

  ShowRemoteDatasource({required Dio dio}) : _dio = dio;
  @override
  Future<List<ShowEntity>> getAllShows() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllShows);
      if (response.statusCode == 200) {
        GetAllShowsDto showDTO = GetAllShowsDto.fromJson(response.data);
        return ShowApiModel.toEntityList(showDTO.data);
      } else {
        throw Exception("Failed to fetch movies: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception(
          e.response?.statusMessage ?? e.message ?? "Unknown Dio error");
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }
}
// @override
// Future<List<ShowEntity>> getAllShows() async {
//   try {
//     var response = await _dio.get(ApiEndpoints.getAllShows);

//     if (response.statusCode == 200) {
//       // print("✅ API Response Type: ${response.data.runtimeType}");
//       // print("✅ API Response: ${response.data}");

//       if (response.data is List<dynamic>) {
//         final GetAllShowsDto showDto =
//             GetAllShowsDto.fromJson(response.data as List<dynamic>);

//         return ShowApiModel.toEntityList(showDto.data);
//       } else {
//         throw Exception(
//             "Invalid API response format: Expected List but got ${response.data.runtimeType}");
//       }
//     } else {
//       throw Exception("Failed to fetch shows: ${response.statusMessage}");
//     }
//   } on DioException catch (e) {
//     throw Exception(e.response?.statusMessage ?? e.message ?? "Unknown Dio error");
//   } catch (e) {
//     throw Exception("Unexpected error: ${e.toString()}");
//   }
// }
