import 'package:bloc/bloc.dart';
import 'package:byma_app/data/repositories/favorite_rooms_repo.dart' show FavoriteRoomsRepo;
import 'package:freezed_annotation/freezed_annotation.dart';
// أو المسار الفعلي للملف حسب مكان وجوده
import 'package:byma_app/data/models/favorite_room_model.dart';

part 'favorite_rooms_state.dart';
part 'favorite_rooms_cubit.freezed.dart';

class FavoriteRoomsCubit extends Cubit<FavoriteRoomsState> {
  final FavoriteRoomsRepo favoriteRoomsRepo;

  FavoriteRoomsCubit(this.favoriteRoomsRepo) : super(const FavoriteRoomsState.initial());

  Future<void> getFavoriteRooms() async {
    emit(const FavoriteRoomsState.loading());

    try {
      final favoriteRooms = await favoriteRoomsRepo.fetchFavoriteRooms();
      emit(FavoriteRoomsState.success(favoriteRooms));
    } catch (errorMessage) {
      emit(FavoriteRoomsState.error(errorMessage.toString()));
    }
  }

  void removeRoomOptimistically(int favoriteRoomId) {
    state.whenOrNull(
      success: (currentRooms) {
        final updatedList = currentRooms
            .where((room) => room.id != favoriteRoomId)
            .toList();

        emit(FavoriteRoomsState.success(updatedList));
      },
    );
  }
}