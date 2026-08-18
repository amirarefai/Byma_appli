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
}
