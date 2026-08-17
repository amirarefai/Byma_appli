import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/repositories/room_collection_repo.dart';
import 'delete_room_from_collection_state.dart';

class DeleteRoomFromCollectionCubit extends Cubit<DeleteRoomFromCollectionState> {
  final RoomCollectionRepo roomCollectionRepo;

  DeleteRoomFromCollectionCubit(this.roomCollectionRepo) : super(const DeleteRoomFromCollectionState.initial());

  Future<void> deleteRoomFromCollection(int collectionId, int roomId) async {
    emit(const DeleteRoomFromCollectionState.loading());

    try {
      await roomCollectionRepo.removeRoomFromCollection(collectionId, roomId);
      emit(const DeleteRoomFromCollectionState.success());
    } catch (errorMessage) {
      emit(DeleteRoomFromCollectionState.error(errorMessage.toString()));
    }
  }
}