import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_hotel_from_collection_state.freezed.dart';

@freezed
sealed class DeleteHotelFromCollectionState with _$DeleteHotelFromCollectionState {
  const factory DeleteHotelFromCollectionState.initial() = _Initial;
  const factory DeleteHotelFromCollectionState.loading() = _Loading;
  const factory DeleteHotelFromCollectionState.success() = _Success;
  const factory DeleteHotelFromCollectionState.error(String message) = _Error;
}