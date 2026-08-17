import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_hotel_to_collection_state.freezed.dart';

@freezed
sealed class AddHotelToCollectionState with _$AddHotelToCollectionState {
  const factory AddHotelToCollectionState.initial() = _Initial;
  const factory AddHotelToCollectionState.loading() = _Loading;
  const factory AddHotelToCollectionState.success() = _Success;
  const factory AddHotelToCollectionState.error(String message) = _Error;
}