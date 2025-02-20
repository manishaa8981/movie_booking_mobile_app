import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';

abstract interface class IHallDataSource {
  Future<List<HallEntity>> getAllHalls();
}
