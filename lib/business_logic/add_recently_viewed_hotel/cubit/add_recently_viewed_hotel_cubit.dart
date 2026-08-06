import 'package:byma_app/data/repositories/recently_viewed_hotel_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_recently_viewed_hotel_state.dart';

class AddRecentlyViewedHotelsCubit extends Cubit<AddRecentlyViewedHotelState> {
  final RecentlyViewedHotelRepo recentlyViewedHotelRepo;

  AddRecentlyViewedHotelsCubit(this.recentlyViewedHotelRepo) : super(const AddRecentlyViewedHotelState.initial());

  Future<void> addRecentlyViewed(int hotelId) async {
    emit(const AddRecentlyViewedHotelState.loading());

    try {
      await recentlyViewedHotelRepo.addRecentlyViewedHotel(hotelId);
      emit(const AddRecentlyViewedHotelState.success());
    } catch (errorMessage) {
      emit(AddRecentlyViewedHotelState.error(errorMessage.toString()));
    }
  }
}