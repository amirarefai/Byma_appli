import 'package:freezed_annotation/freezed_annotation.dart';

part 'toggle_favorite_hotels_state.freezed.dart';

@freezed
sealed class ToggleFavoriteHotelsState with _$ToggleFavoriteHotelsState {
  const factory ToggleFavoriteHotelsState.initial() = _Initial;
  const factory ToggleFavoriteHotelsState.loading() = _Loading;
  const factory ToggleFavoriteHotelsState.success() = _Success;
  const factory ToggleFavoriteHotelsState.error(String message) = _Error;
}