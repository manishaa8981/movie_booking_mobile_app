import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';

abstract interface class IShowDataSource{
    Future< List<ShowEntity>> getAllShows();

}