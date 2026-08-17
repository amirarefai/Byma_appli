import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/repositories/favorite_rooms_repo.dart';
import 'toggle_favorite_rooms_state.dart';

class ToggleFavoriteRoomsCubit extends Cubit<ToggleFavoriteRoomsState> {
  final FavoriteRoomsRepo favoriteRoomsRepo;

  ToggleFavoriteRoomsCubit(this.favoriteRoomsRepo) : super(const ToggleFavoriteRoomsState.initial());

  Future<void> addFavorite(int roomId) async {
    emit(const ToggleFavoriteRoomsState.loading());

    try {
      await favoriteRoomsRepo.addFavoriteRoom(roomId);
      emit(const ToggleFavoriteRoomsState.success());
    } catch (errorMessage) {
      emit(ToggleFavoriteRoomsState.error(errorMessage.toString()));
    }
  }

  Future<void> removeFavorite(int favoriteRoomId) async {
    emit(const ToggleFavoriteRoomsState.loading());

    try {
      await favoriteRoomsRepo.removeFavoriteRoom(favoriteRoomId);
      emit(const ToggleFavoriteRoomsState.success());
    } catch (errorMessage) {
      emit(ToggleFavoriteRoomsState.error(errorMessage.toString()));
    }
  }
}