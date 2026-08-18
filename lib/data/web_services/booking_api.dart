import 'package:dio/dio.dart';

class BookingApi {
  final Dio dio;

  BookingApi(this.dio);

  Future<Response> cancelBooking(int bookingId) async {
    return await dio.patch('bookings/$bookingId/cancel');
  }

}