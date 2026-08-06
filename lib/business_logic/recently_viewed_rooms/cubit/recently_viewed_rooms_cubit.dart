import 'package:flutter_bloc/flutter_bloc.dart';
import 'recently_viewed_rooms_state.dart';
import 'package:byma_app/data/repositories/recently_viewed_room_repo.dart';

class RecentlyViewedRoomsCubit extends Cubit<RecentlyViewedRoomsState> {
  final RecentlyViewedRoomRepo recentlyViewedRoomsRepo;

  RecentlyViewedRoomsCubit(this.recentlyViewedRoomsRepo) : super(const RecentlyViewedRoomsState.initial());

  Future<void> getRecentlyViewedRooms() async {
    emit(const RecentlyViewedRoomsState.loading());

    try {
      final RecentlyViewedRooms = await recentlyViewedRoomsRepo.fetchRecentlyViewedRooms();
      
      emit(RecentlyViewedRoomsState.success(RecentlyViewedRooms));
    } catch (errorMessage) {
      emit(RecentlyViewedRoomsState.error(errorMessage.toString()));
    }
  }
}