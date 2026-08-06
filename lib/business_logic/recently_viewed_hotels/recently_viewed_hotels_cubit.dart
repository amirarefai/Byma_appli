import 'package:flutter_bloc/flutter_bloc.dart';
import 'recently_viewed_hotels_state.dart';
import 'package:byma_app/data/repositories/recently_viewed_hotel_repo.dart';

class RecentlyViewedHotelsCubit extends Cubit<RecentlyViewedHotelsState> {
  final RecentlyViewedHotelRepo recentlyViewedHotelsRepo;

  RecentlyViewedHotelsCubit(this.recentlyViewedHotelsRepo) : super(const RecentlyViewedHotelsState.initial());

  Future<void> getRecentlyViewedHotels() async {
    emit(const RecentlyViewedHotelsState.loading());

    try {
      final RecentlyViewedHotels = await recentlyViewedHotelsRepo.fetchRecentlyViewedHotels();
      
      emit(RecentlyViewedHotelsState.success(RecentlyViewedHotels));
    } catch (errorMessage) {
      emit(RecentlyViewedHotelsState.error(errorMessage.toString()));
    }
  }
}