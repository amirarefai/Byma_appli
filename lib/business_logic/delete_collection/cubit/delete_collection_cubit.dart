import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/repositories/collection_repo.dart';
import 'delete_collection_state.dart';

class DeleteCollectionCubit extends Cubit<DeleteCollectionState> {
  final CollectionRepo collectionRepo;

  DeleteCollectionCubit(this.collectionRepo) : super(const DeleteCollectionState.initial());

  Future<void> deleteCollection(int collectionId) async {
    emit(const DeleteCollectionState.loading());

    try {
      await collectionRepo.removeCollection(collectionId);
      emit(const DeleteCollectionState.success());
    } catch (errorMessage) {
      emit(DeleteCollectionState.error(errorMessage.toString()));
    }
  }
}