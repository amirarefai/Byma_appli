import 'package:freezed_annotation/freezed_annotation.dart';

part 'toggle_favorite_rooms_state.freezed.dart';

@freezed
sealed class ToggleFavoriteRoomsState with _$ToggleFavoriteRoomsState {
  const factory ToggleFavoriteRoomsState.initial() = _Initial;
  const factory ToggleFavoriteRoomsState.loading() = _Loading;
  const factory ToggleFavoriteRoomsState.success() = _Success;
  const factory ToggleFavoriteRoomsState.error(String message) = _Error;
}