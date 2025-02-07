import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/app/usecase/usecase.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/seat/domain/entity/seat_entity.dart';
import 'package:movie_ticket_booking/features/seat/domain/repository/seat_repository.dart';

class GetAllSeatUsecase implements UsecaseWithoutParams<List<SeatEntity>> {
  final ISeatRepository repository;

  GetAllSeatUsecase({required this.repository});

  @override
  Future<Either<Failure, List<SeatEntity>>> call() {
    return repository.getAllSeats();
  }
}