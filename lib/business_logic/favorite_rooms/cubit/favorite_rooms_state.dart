part of 'favorite_rooms_cubit.dart';

@freezed
class FavoriteRoomsState with _$FavoriteRoomsState {
  const factory FavoriteRoomsState.initial() = _Initial;
  const factory FavoriteRoomsState.loading() = _Loading;
  const factory FavoriteRoomsState.success(List<FavoriteRoomModel> favoriteRooms) = _Success;
  const factory FavoriteRoomsState.error(String message) = _Error;
}