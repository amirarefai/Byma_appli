import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_recently_viewed_hotel_state.freezed.dart';

@freezed
sealed class AddRecentlyViewedHotelState with _$AddRecentlyViewedHotelState {
  const factory AddRecentlyViewedHotelState.initial() = _Initial;
  const factory AddRecentlyViewedHotelState.loading() = _Loading;
  const factory AddRecentlyViewedHotelState.success() = _Success;
  const factory AddRecentlyViewedHotelState.error(String message) = _Error;
}