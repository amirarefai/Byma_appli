import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/repositories/hotels_repo.dart';
import 'hotels_state.dart';

class HotelCubit extends Cubit<HotelsState> {
  final HotelsRepo hotelsRepo;

  HotelCubit(this.hotelsRepo) : super(const HotelsState.initial());

  Future<void> fetchAllHotels() async {
    emit(const HotelsState.loading());

    try {
      final hotels = await hotelsRepo.fetchAllHotels();
      emit(HotelsState.success(hotels));
    } catch (errorMessage) {
      emit(HotelsState.error(errorMessage.toString()));
    }
  }
}