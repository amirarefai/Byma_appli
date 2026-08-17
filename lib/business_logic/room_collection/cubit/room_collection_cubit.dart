import 'package:byma_app/data/repositories/room_collection_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'room_collection_state.dart';

class RoomCollectionCubit extends Cubit<RoomCollectionState> {
  final RoomCollectionRepo roomCollectionRepo;

  RoomCollectionCubit(this.roomCollectionRepo) : super(const RoomCollectionState.initial());

  Future<void> getRoomCollection(int collectionId) async {
    emit(const RoomCollectionState.loading());

    try {
      final roomCollection = await roomCollectionRepo.fetchRoomCollection(collectionId);
      
      emit(RoomCollectionState.success(roomCollection));
    } catch (errorMessage) {
      emit(RoomCollectionState.error(errorMessage.toString()));
    }
  }

  void deleteRoomFromCollectionOptimistically(int roomId) {
    state.whenOrNull(
      success: (currentRooms) {
        final updatedList = currentRooms
            .where((item) => item.room.id != roomId)
            .toList();

        emit(RoomCollectionState.success(updatedList));
      },
    );
  }

}