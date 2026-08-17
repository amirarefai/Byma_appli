import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/repositories/collection_repo.dart';
import 'create_collection_state.dart';

class CreateCollectionCubit extends Cubit<CreateCollectionState> {
  final CollectionRepo collectionRepo;

  CreateCollectionCubit(this.collectionRepo) : super(const CreateCollectionState.initial());

  Future<void> createCollection(String collectionName) async {
    emit(const CreateCollectionState.loading());

    try {
      await collectionRepo.createCollection(collectionName);
      emit(const CreateCollectionState.success());
    } catch (errorMessage) {
      emit(CreateCollectionState.error(errorMessage.toString()));
    }
  }
}