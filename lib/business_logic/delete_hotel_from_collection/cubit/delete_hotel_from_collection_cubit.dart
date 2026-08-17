import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/repositories/hotel_collection_repo.dart';
import 'delete_hotel_from_collection_state.dart';

class DeleteHotelFromCollectionCubit extends Cubit<DeleteHotelFromCollectionState> {
  final HotelCollectionRepo hotelCollectionRepo;

  DeleteHotelFromCollectionCubit(this.hotelCollectionRepo) : super(const DeleteHotelFromCollectionState.initial());

  Future<void> deleteHotelFromCollection(int collectionId, int hotelId) async {
    emit(const DeleteHotelFromCollectionState.loading());

    try {
      await hotelCollectionRepo.removeHotelFromCollection(collectionId, hotelId);
      emit(const DeleteHotelFromCollectionState.success());
    } catch (errorMessage) {
      emit(DeleteHotelFromCollectionState.error(errorMessage.toString()));
    }
  }
}