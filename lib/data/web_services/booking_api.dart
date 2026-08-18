import 'package:dio/dio.dart';

class BookingApi {
  final Dio dio;

  BookingApi(this.dio);

  Future<Response> cancelBooking(int bookingId) async {
    return await dio.patch('bookings/$bookingId/cancel');
  }

  Future<Response> getBookingHistory({
    required String status,
    int page = 1,
    int limit = 10,
  }) async {
    return await dio.get(
      'customers/bookings', 
      queryParameters: {
        'status': status,
        'page': page,
        'limit': limit,
      },
    );
  }

}