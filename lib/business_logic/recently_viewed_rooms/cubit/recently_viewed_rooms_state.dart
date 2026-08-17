import 'package:byma_app/data/models/recently_viewed_room_model.dart'; 
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recently_viewed_rooms_state.freezed.dart';

@freezed
sealed class RecentlyViewedRoomsState with _$RecentlyViewedRoomsState {
  const factory RecentlyViewedRoomsState.initial() = _Initial;
  const factory RecentlyViewedRoomsState.loading() = _Loading;
  const factory RecentlyViewedRoomsState.success(List<RecentlyViewedRoomModel> recentlyViewedRooms) = _Success;
  const factory RecentlyViewedRoomsState.error(String message) = _Error;
}