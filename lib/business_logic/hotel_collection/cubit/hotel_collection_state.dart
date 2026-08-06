import 'package:byma_app/data/models/hotel_collection_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hotel_collection_state.freezed.dart';

@freezed
sealed class HotelCollectionState with _$HotelCollectionState {
  const factory HotelCollectionState.initial() = _Initial;
  const factory HotelCollectionState.loading() = _Loading;
  const factory HotelCollectionState.success(List<HotelCollectionModel> hotelCollection) = _Success;
  const factory HotelCollectionState.error(String message) = _Error;
}