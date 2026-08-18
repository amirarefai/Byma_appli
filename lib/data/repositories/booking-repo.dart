import 'package:byma_app/data/models/booking_history_model.dart';
import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/booking_api.dart';

class BookingRepo {
  final BookingApi bookingApi;

  BookingRepo(this.bookingApi);

   Future<void> cancelBooking(int bookingId) async {
    try {
      await bookingApi.cancelBooking(bookingId);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

  Future<List<BookingHistoryModel>> getBookingHistory({
    required String status,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await bookingApi.getBookingHistory(
        status: status,
        page: page, // Passing page to API
        limit: limit, // Passing limit to API
      );
      
      final List<dynamic> itemsData = response.data['items'] ?? [];
      
      return itemsData
          .map((json) => BookingHistoryModel.fromJson(json as Map<String, dynamic>))
          .toList();
          
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
}
