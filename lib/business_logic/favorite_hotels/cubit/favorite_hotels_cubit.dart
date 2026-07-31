import 'package:byma_app/data/repositories/favorite_hotels_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorite_hotels_state.dart';

class FavoriteHotelsCubit extends Cubit<FavoriteHotelsState> {
  final FavoriteHotelsRepo favoriteHotelsRepo;

  FavoriteHotelsCubit(this.favoriteHotelsRepo) : super(const FavoriteHotelsState.initial());

  Future<void> getFavoriteHotels() async {
    emit(const FavoriteHotelsState.loading());

    try {
      final favoriteHotels = await favoriteHotelsRepo.fetchFavoriteHotels();
      
      emit(FavoriteHotelsState.success(favoriteHotels));
    } catch (errorMessage) {
      emit(FavoriteHotelsState.error(errorMessage.toString()));
    }
  }

  void removeHotelOptimistically(int favoriteHotelId) {
    // Safely execute only if the current state is the 'success' state
    state.whenOrNull(
      success: (currentHotels) {
        // Filter out the deleted favorite hotel and assign to a new list
        final updatedList = currentHotels.where((favoriteHotel) => favoriteHotel.id != favoriteHotelId).toList();
        
        // Instantly emit the new list to redraw the UI without a loading spinner
        emit(FavoriteHotelsState.success(updatedList));
      },
    );
  }

}