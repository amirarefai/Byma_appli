part of 'hotel_details_cubit.dart';

@freezed
class HotelDetailsState with _$HotelDetailsState {
  const factory HotelDetailsState.initial() = _Initial;
  const factory HotelDetailsState.loading() = _Loading;
  const factory HotelDetailsState.success(HotelDetailsModel hotelDetails) = _Success;
  const factory HotelDetailsState.error(String message) = _Error;
}