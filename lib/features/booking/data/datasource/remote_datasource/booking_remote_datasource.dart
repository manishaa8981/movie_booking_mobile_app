import 'package:dio/dio.dart';
import 'package:movie_ticket_booking/app/constants/api_endpoints.dart';
import 'package:movie_ticket_booking/features/booking/data/datasource/booking_datasource.dart';
import 'package:movie_ticket_booking/features/booking/data/dto/get_bookings_dto.dart';
import 'package:movie_ticket_booking/features/booking/data/model/booking_api_model.dart';
import 'package:movie_ticket_booking/features/booking/domain/entity/booking_entity.dart';

class BookingRemoteDatasource implements IBookingDataSource {
  final Dio _dio;

  BookingRemoteDatasource(this._dio);

  @override
  Future<void> createBooking(BookingEntity booking) async {
    try {
      // Convert entity to model
      var bookingApiModel = BookingApiModel.fromEntity(booking);
      var response = await _dio.post(
        ApiEndpoints.createBooking,
        data: bookingApiModel.toJson(),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<BookingEntity>> getBookings() async {
    try {
      var response = await _dio.get(ApiEndpoints.getBookings);
      print('Raw Response Data: ${response.data}'); // Debugging step

      if (response.statusCode == 200) {
        // Parse response
        GetBookingsDto bookingDTO = GetBookingsDto.fromJson(response.data);

        print('Parsed DTO Bookings: ${bookingDTO.bookings}'); // Debugging

        return BookingApiModel.toEntityList(bookingDTO.bookings);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception('Error in getBookings: $e');
    }
  }
}
