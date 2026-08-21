part of 'bookings_transactions_cubit.dart';

@freezed
class BookingsTransactionsState with _$BookingsTransactionsState {
  const factory BookingsTransactionsState.initial() = _Initial;
  const factory BookingsTransactionsState.loading() = _Loading;
  const factory BookingsTransactionsState.success(List<BookingsTransactionsModel> bookingsTransactions) = _Success;
  const factory BookingsTransactionsState.error(String message) = _Error;
}