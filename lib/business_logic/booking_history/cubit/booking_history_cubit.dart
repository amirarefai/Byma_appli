import 'package:byma_app/data/repositories/booking-repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'booking_history_state.dart';

class BookingHistoryCubit extends Cubit<BookingHistoryState> {
  final BookingRepo bookingRepo;

  // Pagination Trackers
  int _currentPage = 1;
  final int _limit = 10;
  String _currentStatus = '';
  bool _isFetchingMore = false; // Guard to prevent duplicate concurrent calls

  BookingHistoryCubit(this.bookingRepo) : super(const BookingHistoryState.initial());

  /// 1. Initial Fetch (Call this when opening the screen or switching tabs)
  Future<void> fetchBookingHistory(String status) async {
    _currentStatus = status;
    _currentPage = 1;
    emit(const BookingHistoryState.loading());

    try {
      final bookings = await bookingRepo.getBookingHistory(
        status: _currentStatus,
        page: _currentPage,
        limit: _limit,
      );

      emit(BookingHistoryState.success(
        bookings: bookings,
        // If the API returns fewer items than the limit, we've reached the end
        hasReachedMax: bookings.length < _limit, 
      ));
    } catch (errorMessage) {
      emit(BookingHistoryState.error(errorMessage.toString()));
    }
  }

  /// 2. Fetch More (Call this when the user scrolls to the bottom of the list)
  Future<void> fetchMoreBookings() async {
    // Prevent duplicate calls if we are already fetching
    if (_isFetchingMore) return; 

    // We only execute pagination logic if the current state is `success`
    state.mapOrNull(
      success: (currentState) async {
        if (currentState.hasReachedMax) return;

        _isFetchingMore = true;
        
        // Emit updated state to show bottom loading indicator, clear any previous pagination errors
        emit(currentState.copyWith(
          isFetchingMore: true, 
          paginationError: null,
        ));

        try {
          _currentPage++;
          final newBookings = await bookingRepo.getBookingHistory(
            status: _currentStatus,
            page: _currentPage,
            limit: _limit,
          );

          // Append new items to the existing list
          emit(currentState.copyWith(
            bookings: [...currentState.bookings, ...newBookings],
            hasReachedMax: newBookings.length < _limit,
            isFetchingMore: false,
          ));
        } catch (errorMessage) {
          // If it fails, revert the page count and emit the error INSIDE the success state.
          // This prevents wiping out the existing data on the screen.
          _currentPage--; 
          emit(currentState.copyWith(
            isFetchingMore: false,
            paginationError: errorMessage.toString(),
          ));
        } finally {
          _isFetchingMore = false;
        }
      },
    );
  }
}