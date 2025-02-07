import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';

abstract interface class IShowRepository {
  Future<Either<Failure, List<ShowEntity>>> getAllShows();

}
