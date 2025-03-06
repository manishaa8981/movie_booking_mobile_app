import 'package:dio/dio.dart';
import 'package:movie_ticket_booking/app/constants/api_endpoints.dart';
import 'package:movie_ticket_booking/features/hall/data/data_source/hall_data_source.dart';
import 'package:movie_ticket_booking/features/hall/data/dto/get_all_hall_dto.dart';
import 'package:movie_ticket_booking/features/hall/data/model/hall_api_model.dart';
import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';

class HallRemoteDatasource implements IHallDataSource {
  final Dio _dio;

  HallRemoteDatasource({required Dio dio}) : _dio = dio;

  @override
  Future<List<HallEntity>> getAllHalls() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllHalls);
      if (response.statusCode == 200) {
        GetAllHallsDto hallDTO = GetAllHallsDto.fromJson(response.data);
        return HallApiModel.toEntityList(hallDTO.data);
      } else {
        throw Exception("Failed to fetch halls: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception(
          e.response?.statusMessage ?? e.message ?? "Unknown Dio error");
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }
}
