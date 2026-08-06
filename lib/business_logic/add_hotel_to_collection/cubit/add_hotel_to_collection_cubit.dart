import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/repositories/hotel_collection_repo.dart';
import 'add_hotel_to_collection_state.dart';

class AddHotelToCollectionCubit extends Cubit<AddHotelToCollectionState> {
  final HotelCollectionRepo hotelCollectionRepo;

  AddHotelToCollectionCubit(this.hotelCollectionRepo) : super(const AddHotelToCollectionState.initial());

  Future<void> addHotelToCollection(int collectionId, int hotelId) async {
    emit(const AddHotelToCollectionState.loading());

    try {
      await hotelCollectionRepo.addHotelToCollection(collectionId, hotelId);
      emit(const AddHotelToCollectionState.success());
    } catch (errorMessage) {
      emit(AddHotelToCollectionState.error(errorMessage.toString()));
    }
  }
}