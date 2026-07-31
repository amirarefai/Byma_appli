import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:byma_app/data/models/hotel_model.dart';

part 'hotels_state.freezed.dart';

@freezed
sealed class HotelsState with _$HotelsState {
  const factory HotelsState.initial() = _Initial;
  const factory HotelsState.loading() = _Loading;
  const factory HotelsState.success(List<HotelModel> hotels) = _Success;
  const factory HotelsState.error(String message) = _Error;
}