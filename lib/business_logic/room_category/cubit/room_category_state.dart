import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:byma_app/data/models/room_category_model.dart';

part 'room_category_state.freezed.dart';

@freezed
sealed class RoomCategoryState with _$RoomCategoryState {
  const factory RoomCategoryState.initial() = _Initial;
  const factory RoomCategoryState.loading() = _Loading;
  const factory RoomCategoryState.success(List<RoomCategoryModel> roomCategories) = _Success;
  const factory RoomCategoryState.error(String message) = _Error;
}