import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_booking_state.freezed.dart';

@freezed
class CreateBookingState with _$CreateBookingState {
  const factory CreateBookingState.initial() = _Initial;
  const factory CreateBookingState.loading() = _Loading;
  const factory CreateBookingState.success() = _Success;
  const factory CreateBookingState.error(String message) = _Error;
}
