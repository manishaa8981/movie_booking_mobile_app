import 'package:dio/dio.dart';
import 'package:movie_ticket_booking/app/constants/api_endpoints.dart';
import 'package:movie_ticket_booking/features/seat/data/data_source/seat_data_source.dart';
import 'package:movie_ticket_booking/features/seat/data/dto/get_all_seats_dto.dart';
import 'package:movie_ticket_booking/features/seat/data/model/seat_api_model.dart';
import 'package:movie_ticket_booking/features/seat/domain/entity/seat_entity.dart';

class SeatRemoteDatasource implements ISeatDataSource {
  final Dio _dio;

  SeatRemoteDatasource({required Dio dio}) : _dio = dio;

  @override
  Future<List<SeatEntity>> getAllSeats(String hallId) async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllSeats);
      if (response.statusCode == 200) {
        GetAllSeatsDto seatDTO = GetAllSeatsDto.fromJson(response.data);
        return SeatApiModel.toEntityList(seatDTO.data);
      } else {
        throw Exception("Failed to fetch seats: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception(
          e.response?.statusMessage ?? e.message ?? "Unknown Dio error");
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }
}

