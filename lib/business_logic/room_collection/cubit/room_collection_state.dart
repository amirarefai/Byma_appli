import 'package:byma_app/data/models/room_collection_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_collection_state.freezed.dart';

@freezed
sealed class RoomCollectionState with _$RoomCollectionState {
  const factory RoomCollectionState.initial() = _Initial;
  const factory RoomCollectionState.loading() = _Loading;
  const factory RoomCollectionState.success(List<RoomCollectionModel> roomCollection) = _Success;
  const factory RoomCollectionState.error(String message) = _Error;
}