import 'package:byma_app/data/repositories/recently_viewed_room_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_recently_viewed_room_state.dart';

class AddRecentlyViewedRoomsCubit extends Cubit<AddRecentlyViewedRoomState> {
  final RecentlyViewedRoomRepo recentlyViewedRoomRepo;

  AddRecentlyViewedRoomsCubit(this.recentlyViewedRoomRepo) : super(const AddRecentlyViewedRoomState.initial());

  Future<void> addRecentlyViewed(int roomId) async {
    emit(const AddRecentlyViewedRoomState.loading());

    try {
      await recentlyViewedRoomRepo.addRecentlyViewedRoom(roomId);
      emit(const AddRecentlyViewedRoomState.success());
    } catch (errorMessage) {
      emit(AddRecentlyViewedRoomState.error(errorMessage.toString()));
    }
  }
}