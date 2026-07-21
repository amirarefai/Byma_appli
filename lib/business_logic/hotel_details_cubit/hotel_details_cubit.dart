import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/hotel_repository.dart';
import 'hotel_details_state.dart';

class HotelDetailsCubit extends Cubit<HotelDetailsState> {
  final HotelRepository hotelRepository;

  HotelDetailsCubit(this.hotelRepository) : super(HotelDetailsInitial());

  // دالة طلب تفاصيل الفندق
  Future<void> getHotelDetails(String id) async {
    emit(HotelDetailsLoading());
    try {
      final hotel = await hotelRepository.fetchHotelDetails(id);
      emit(HotelDetailsLoaded(hotel));
    } catch (e) {
      emit(HotelDetailsError(e.toString()));
    }
  }
}