import 'package:bloc/bloc.dart';
import 'package:byma_app/data/repositories/booking-repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:byma_app/data/models/bookings_transactions_model.dart';

part 'bookings_transactions_state.dart';
part 'bookings_transactions_cubit.freezed.dart';

class BookingsTransactionsCubit extends Cubit<BookingsTransactionsState> {
  final BookingRepo _bookingRepo;

  BookingsTransactionsCubit(this._bookingRepo) : super(const BookingsTransactionsState.initial());

  Future<void> fetchBookingsTransactions() async {
    emit(const BookingsTransactionsState.loading());
    try {
      final bookingsTransactions = await _bookingRepo.fetchBookingTransactions();
      emit(BookingsTransactionsState.success(bookingsTransactions));
    } catch (errorMessage) {
      emit(BookingsTransactionsState.error(errorMessage.toString()));
    }
  }
}