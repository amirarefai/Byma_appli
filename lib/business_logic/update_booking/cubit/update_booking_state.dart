part of 'update_booking_cubit.dart';

@freezed
class UpdateBookingState with _$UpdateBookingState {
  const factory UpdateBookingState.initial() = _Initial;
  const factory UpdateBookingState.loading() = _Loading;
  const factory UpdateBookingState.success() = _Success;
  const factory UpdateBookingState.error(String message) = _Error;
}
