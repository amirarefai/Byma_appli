import 'package:bloc/bloc.dart';
import 'package:byma_app/data/models/create_booking_model.dart';
import 'package:byma_app/data/repositories/booking-repo.dart';
import 'create_booking_state.dart';

class CreateBookingCubit extends Cubit<CreateBookingState> {
  final BookingRepo bookingRepo;

  CreateBookingCubit(this.bookingRepo) : super(const CreateBookingState.initial());

  Future<void> createBooking(CreateBookingModel model) async {
    emit(const CreateBookingState.loading());

    try {
      await bookingRepo.createBooking(model);
      emit(const CreateBookingState.success());
    } catch (errorMessage) {
      emit(CreateBookingState.error(errorMessage.toString()));
    }
  }
}
