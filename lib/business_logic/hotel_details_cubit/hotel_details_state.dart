import '../../data/models/hotel_model.dart';

abstract class HotelDetailsState {}

class HotelDetailsInitial extends HotelDetailsState {}

class HotelDetailsLoading extends HotelDetailsState {}

class HotelDetailsLoaded extends HotelDetailsState {
  final HotelModel hotel;
  HotelDetailsLoaded(this.hotel);
}

class HotelDetailsError extends HotelDetailsState {
  final String message;
  HotelDetailsError(this.message);
}