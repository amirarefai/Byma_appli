part of 'room_details_cubit.dart';

@freezed
class RoomDetailsState with _$RoomDetailsState {
  const factory RoomDetailsState.initial() = _Initial;
  const factory RoomDetailsState.loading() = _Loading;
  const factory RoomDetailsState.success(RoomDetailsModel roomDetails) = _Success;
  const factory RoomDetailsState.error(String message) = _Error;
}