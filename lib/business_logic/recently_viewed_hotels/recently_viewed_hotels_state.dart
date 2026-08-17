import 'package:byma_app/data/models/recently_viewed_hotel_model.dart'; 
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recently_viewed_hotels_state.freezed.dart';

@freezed
sealed class RecentlyViewedHotelsState with _$RecentlyViewedHotelsState {
  const factory RecentlyViewedHotelsState.initial() = _Initial;
  const factory RecentlyViewedHotelsState.loading() = _Loading;
  const factory RecentlyViewedHotelsState.success(List<RecentlyViewedHotelModel> recentlyViewedHotels) = _Success;
  const factory RecentlyViewedHotelsState.error(String message) = _Error;
}