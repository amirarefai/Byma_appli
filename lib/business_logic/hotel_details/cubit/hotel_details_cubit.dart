import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:byma_app/data/models/hotel_details_model.dart';
import 'package:byma_app/data/repositories/hotels_repo.dart'; 

part 'hotel_details_state.dart';
part 'hotel_details_cubit.freezed.dart';

class HotelDetailsCubit extends Cubit<HotelDetailsState> {
  final HotelsRepo hotelsRepo;

  HotelDetailsCubit(this.hotelsRepo) : super(const HotelDetailsState.initial());

  Future<void> getHotelDetails(int hotelId) async {
    emit(const HotelDetailsState.loading());
    
    try {
      final hotelDetails = await hotelsRepo.fetchHotelDetails(hotelId);
      emit(HotelDetailsState.success(hotelDetails));
    } catch (errorMessage) {
      emit(HotelDetailsState.error(errorMessage.toString()));
    }
  }
}