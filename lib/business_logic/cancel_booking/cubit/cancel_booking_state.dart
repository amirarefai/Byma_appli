import 'package:freezed_annotation/freezed_annotation.dart';

part 'cancel_booking_state.freezed.dart';

@freezed
sealed class CancelBookingState with _$CancelBookingState {
  const factory CancelBookingState.initial() = _Initial;
  const factory CancelBookingState.loading() = _Loading;
  const factory CancelBookingState.success() = _Success;
  const factory CancelBookingState.error(String message) = _Error;
}