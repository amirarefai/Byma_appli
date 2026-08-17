import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/repositories/room_collection_repo.dart';
import 'add_room_to_collection_state.dart';

class AddRoomToCollectionCubit extends Cubit<AddRoomToCollectionState> {
  final RoomCollectionRepo roomCollectionRepo;

  AddRoomToCollectionCubit(this.roomCollectionRepo) : super(const AddRoomToCollectionState.initial());

  Future<void> addRoomToCollection(int collectionId, int roomId) async {
    emit(const AddRoomToCollectionState.loading());

    try {
      await roomCollectionRepo.addRoomToCollection(collectionId, roomId);
      emit(const AddRoomToCollectionState.success());
    } catch (errorMessage) {
      emit(AddRoomToCollectionState.error(errorMessage.toString()));
    }
  }
}