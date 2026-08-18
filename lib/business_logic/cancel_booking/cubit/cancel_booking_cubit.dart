import 'package:byma_app/data/repositories/booking-repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cancel_booking_state.dart';

class CancelBookingCubit extends Cubit<CancelBookingState> {
  final BookingRepo bookingRepo;

  CancelBookingCubit(this.bookingRepo) : super(const CancelBookingState.initial());

  Future<void> cancelBooking(int bookingId) async {
    emit(const CancelBookingState.loading());

    try {
      await bookingRepo.cancelBooking(bookingId);
      emit(const CancelBookingState.success());
    } catch (errorMessage) {
      emit(CancelBookingState.error(errorMessage.toString()));
    }
  }
}