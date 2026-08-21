part of 'hotel_rooms_filter_cubit.dart';

@freezed
class HotelRoomsFilterState with _$HotelRoomsFilterState {
  const factory HotelRoomsFilterState.initial() = _Initial;
  const factory HotelRoomsFilterState.loading() = _Loading;
  const factory HotelRoomsFilterState.success(List<RoomModel> rooms) = _Success;
  const factory HotelRoomsFilterState.error(String message) = _Error;
}