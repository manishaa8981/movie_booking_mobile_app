import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/app/usecase/usecase.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';
import 'package:movie_ticket_booking/features/hall/domain/repository/hall_repository.dart';

class GetAllHallUsecase implements UsecaseWithoutParams<List<HallEntity>> {
  final IHallRepository repository;

  GetAllHallUsecase({required this.repository});

  @override
  Future<Either<Failure, List<HallEntity>>> call() {
    return repository.getAllHalls();
  }
}
