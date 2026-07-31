import 'package:byma_app/data/models/recently_viewed_hotel_model.dart';
import 'package:byma_app/data/repositories/recently_viewed_hotel_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'recently_viewed_hotels_state.dart';
// import 'package:byma_app/data/repositories/recently_viewed_repo.dart'; // أضف الـ Repo الخاص بك هنا

class RecentlyViewedHotelsCubit extends Cubit<RecentlyViewedHotelsState> {
  // final RecentlyViewedRepo recentlyViewedRepo;

  RecentlyViewedHotelsCubit([RecentlyViewedHotelRepo? recentlyViewedHotelRepo]) : super(const RecentlyViewedHotelsState.initial());

  Future<void> getRecentlyViewedHotels() async {
    emit(const RecentlyViewedHotelsState.loading());

    try {
      // final recentlyViewedHotels = await recentlyViewedRepo.fetchRecentlyViewed();
      List<RecentlyViewedHotelModel> recentlyViewedHotels = []; // مؤقتاً

      emit(RecentlyViewedHotelsState.success(recentlyViewedHotels));
    } catch (errorMessage) {
      emit(RecentlyViewedHotelsState.error(errorMessage.toString()));
    }
  }

  // دالة الحذف المتفائل (Optimistic Update) مطابقة تماماً للفنادق المفضلة لديك
  void removeRecentlyViewedOptimistically(int recordId) {
    state.whenOrNull(
      success: (currentList) {
        final updatedList = currentList
            .where((item) => item.id != recordId)
            .toList();
        emit(RecentlyViewedHotelsState.success(updatedList));
      },
    );
  }
}