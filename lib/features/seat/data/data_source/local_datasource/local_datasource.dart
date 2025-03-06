import 'package:movie_ticket_booking/core/network/hive_service.dart';
import 'package:movie_ticket_booking/features/seat/data/data_source/seat_data_source.dart';
import 'package:movie_ticket_booking/features/seat/domain/entity/seat_entity.dart';

class SeatLocalDatasource implements ISeatDataSource {
  final HiveService _hiveService;

  SeatLocalDatasource({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<List<SeatEntity>> getAllSeats(String hallId) async {
    try {
      final seatHiveModelList = await _hiveService.getAllSeats();
      return seatHiveModelList.map((seat) => seat.toEntity()).toList(); 
    } catch (e) {
      throw Exception("Failed to fetch halls from local database: ${e.toString()}");
    }
  }

}
