import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:byma_app/data/models/update_booking_model.dart';
import 'package:byma_app/data/repositories/booking-repo.dart';

part 'update_booking_state.dart';
part 'update_booking_cubit.freezed.dart';

class UpdateBookingCubit extends Cubit<UpdateBookingState> {
  final BookingRepo bookingRepo;

  UpdateBookingCubit(this.bookingRepo)
      : super(const UpdateBookingState.initial());

  Future<void> updateBooking(
    int bookingId,
    UpdateBookingModel updateBookingModel,
  ) async {
    emit(const UpdateBookingState.loading());

    try {
      await bookingRepo.updateBooking(bookingId, updateBookingModel);
      emit(const UpdateBookingState.success());
    } catch (errorMessage) {
      emit(UpdateBookingState.error(errorMessage.toString()));
    }
  }
}
