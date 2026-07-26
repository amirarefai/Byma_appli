import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/repositories/favorite_hotels_repo.dart';
import 'toggle_favorite_hotels_state.dart';

class ToggleFavoriteHotelsCubit extends Cubit<ToggleFavoriteHotelsState> {
  final FavoriteHotelsRepo favoriteHotelsRepo;

  ToggleFavoriteHotelsCubit(this.favoriteHotelsRepo) : super(const ToggleFavoriteHotelsState.initial());

  Future<void> addFavorite(int hotelId) async {
    emit(const ToggleFavoriteHotelsState.loading());

    try {
      await favoriteHotelsRepo.addFavoriteHotel(hotelId);
      emit(const ToggleFavoriteHotelsState.success());
    } catch (errorMessage) {
      emit(ToggleFavoriteHotelsState.error(errorMessage.toString()));
    }
  }

  Future<void> removeFavorite(int favoriteHotelId) async {
    emit(const ToggleFavoriteHotelsState.loading());

    try {
      await favoriteHotelsRepo.removeFavoriteHotel(favoriteHotelId);
      emit(const ToggleFavoriteHotelsState.success());
    } catch (errorMessage) {
      emit(ToggleFavoriteHotelsState.error(errorMessage.toString()));
    }
  }
}