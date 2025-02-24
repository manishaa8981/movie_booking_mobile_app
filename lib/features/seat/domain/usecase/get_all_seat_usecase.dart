import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/app/usecase/usecase.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/seat/domain/entity/seat_entity.dart';
import 'package:movie_ticket_booking/features/seat/domain/repository/seat_repository.dart';

class GetAllSeatUsecase implements UsecaseWithParams<List<SeatEntity>, String> {
  final ISeatRepository repository;
  String hallId;

  GetAllSeatUsecase({required this.repository, required this.hallId});

  @override
  Future<Either<Failure, List<SeatEntity>>> call(String hallId) {
    return repository.getAllSeats(hallId);
  }
}
