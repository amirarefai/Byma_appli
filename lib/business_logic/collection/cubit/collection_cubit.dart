import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/repositories/collection_repo.dart';
import 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  final CollectionRepo collectionRepo;

  CollectionCubit(this.collectionRepo) : super(const CollectionState.initial());

  Future<void> fetchAllCollections() async {
    emit(const CollectionState.loading());

    try {
      final collections = await collectionRepo.fetchAllCollections();
      emit(CollectionState.success(collections));
    } catch (errorMessage) {
      emit(CollectionState.error(errorMessage.toString()));
    }
  }

   void deleteCollectionOptimistically(int collectionId) {
    // Safely execute only if the current state is the 'success' state
    state.whenOrNull(
      success: (currentCollections) {
        // Filter out the deleted collection and assign to a new list
        final updatedList = currentCollections.where((collection) => collection.id != collectionId).toList();
        
        // Instantly emit the new list to redraw the UI without a loading spinner
        emit(CollectionState.success(updatedList));
      },
    );
  }
}