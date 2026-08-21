import 'package:dio/dio.dart';
import 'package:byma_app/data/models/update_booking_model.dart';

class BookingApi {
  final Dio dio;

  BookingApi(this.dio);

  Future<Response> cancelBooking(int bookingId) async {
    return await dio.patch('bookings/$bookingId/cancel', data: {'customerId': 6});
  }

  Future<Response> updateBooking(
    int bookingId,
    UpdateBookingModel updateBookingModel,
  ) async {
    return await dio.patch(
      'bookings/$bookingId/update',
      data: updateBookingModel.toJson(),
    );
  }

  Future<Response> getBookingHistory({
    required String status,
    int page = 1,
    int limit = 10,
  }) async {
    return await dio.get(
      'customers/bookings',
      queryParameters: {'status': status, 'page': page, 'limit': limit, 'customerId': 6},
    );
  }

  Future<Response> getBookingTransactions() async {
    return await dio.get('customers/6/bookings-transactions');
  }
}
