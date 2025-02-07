import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';

abstract interface class IHallRepository {
  Future<Either<Failure, List<HallEntity>>> getAllHalls();

}
