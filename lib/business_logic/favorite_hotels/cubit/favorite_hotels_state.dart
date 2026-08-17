import 'package:byma_app/data/models/favorite_hotel_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_hotels_state.freezed.dart';

@freezed
sealed class FavoriteHotelsState with _$FavoriteHotelsState {
  const factory FavoriteHotelsState.initial() = _Initial;
  const factory FavoriteHotelsState.loading() = _Loading;
  const factory FavoriteHotelsState.success(List<FavoriteHotelModel> favoriteHotels) = _Success;
  const factory FavoriteHotelsState.error(String message) = _Error;
}