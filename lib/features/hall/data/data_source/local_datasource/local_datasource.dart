import 'package:movie_ticket_booking/core/network/hive_service.dart';
import 'package:movie_ticket_booking/features/hall/data/data_source/hall_data_source.dart';
import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';

class HallLocalDatasource implements IHallDataSource {
  final HiveService _hiveService;

  HallLocalDatasource({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<List<HallEntity>> getAllHalls() async {
    try {
      final hallHiveModelList = await _hiveService.getAllHalls();
      return hallHiveModelList.map((hall) => hall.toEntity()).toList(); 
    } catch (e) {
      throw Exception("Failed to fetch halls from local database: ${e.toString()}");
    }
  }

}
