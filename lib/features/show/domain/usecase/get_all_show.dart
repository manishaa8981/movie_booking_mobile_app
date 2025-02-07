import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/app/usecase/usecase.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';
import 'package:movie_ticket_booking/features/show/domain/repository/show_repository.dart';

class GetAllShowUseCase implements UsecaseWithoutParams<List<ShowEntity>> {
  final IShowRepository repository;

  GetAllShowUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ShowEntity>>> call() {
    return repository.getAllShows();
  }
}