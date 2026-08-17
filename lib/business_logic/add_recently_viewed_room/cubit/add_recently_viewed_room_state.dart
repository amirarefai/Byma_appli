import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_recently_viewed_room_state.freezed.dart';

@freezed
sealed class AddRecentlyViewedRoomState with _$AddRecentlyViewedRoomState {
  const factory AddRecentlyViewedRoomState.initial() = _Initial;
  const factory AddRecentlyViewedRoomState.loading() = _Loading;
  const factory AddRecentlyViewedRoomState.success() = _Success;
  const factory AddRecentlyViewedRoomState.error(String message) = _Error;
}