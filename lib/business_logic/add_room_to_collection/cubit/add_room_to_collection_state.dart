import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_room_to_collection_state.freezed.dart';

@freezed
sealed class AddRoomToCollectionState with _$AddRoomToCollectionState {
  const factory AddRoomToCollectionState.initial() = _Initial;
  const factory AddRoomToCollectionState.loading() = _Loading;
  const factory AddRoomToCollectionState.success() = _Success;
  const factory AddRoomToCollectionState.error(String message) = _Error;
}