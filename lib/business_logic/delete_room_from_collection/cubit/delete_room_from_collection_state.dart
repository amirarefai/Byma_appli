import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_room_from_collection_state.freezed.dart';

@freezed
sealed class DeleteRoomFromCollectionState with _$DeleteRoomFromCollectionState {
  const factory DeleteRoomFromCollectionState.initial() = _Initial;
  const factory DeleteRoomFromCollectionState.loading() = _Loading;
  const factory DeleteRoomFromCollectionState.success() = _Success;
  const factory DeleteRoomFromCollectionState.error(String message) = _Error;
}