import 'package:flutter_bloc/flutter_bloc.dart';
import 'hotel_state.dart';
import '../../data/repositories/hotel_repository.dart'; 

class HotelCubit extends Cubit<HotelState> {
  final HotelRepository hotelRepository;

  HotelCubit({required this.hotelRepository}) : super(HotelInitial());

  Future<void> getHotels() async {
    emit(HotelLoading());
    try {
      final hotels = await hotelRepository.fetchHotels();
      if (!isClosed) {
        emit(HotelLoaded(hotels));
      }
    } catch (e) {
      if (!isClosed) { // 🌟 تم إضافة التحقق هنا لحمايتك من الكراش الأحمر
        emit(HotelError(e.toString()));
      }
    }
  }
}