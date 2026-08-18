import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:byma_app/data/models/booking_history_model.dart';

part 'booking_history_state.freezed.dart';

@freezed
sealed class BookingHistoryState with _$BookingHistoryState {
  const factory BookingHistoryState.initial() = _Initial;
  const factory BookingHistoryState.loading() = _Loading;
  
  const factory BookingHistoryState.success({
    required List<BookingHistoryModel> bookings,
    @Default(false) bool hasReachedMax,     // True if the API returns fewer items than the limit
    @Default(false) bool isFetchingMore,    // True when loading the next page
    String? paginationError,                // Holds error message if fetching page 2+ fails
  }) = _Success;

  const factory BookingHistoryState.error(String message) = _Error;
}