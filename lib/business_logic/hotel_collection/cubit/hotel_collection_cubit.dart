import 'package:byma_app/data/repositories/hotel_collection_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'hotel_collection_state.dart';

class HotelCollectionCubit extends Cubit<HotelCollectionState> {
  final HotelCollectionRepo hotelCollectionRepo;

  HotelCollectionCubit(this.hotelCollectionRepo) : super(const HotelCollectionState.initial());

  Future<void> getHotelCollection(int collectionId) async {
    emit(const HotelCollectionState.loading());

    try {
      final hotelCollection = await hotelCollectionRepo.fetchHotelCollection(collectionId);
      
      emit(HotelCollectionState.success(hotelCollection));
    } catch (errorMessage) {
      emit(HotelCollectionState.error(errorMessage.toString()));
    }
  }


  void deleteHotelFromCollectionOptimistically(int hotelId) {
    state.whenOrNull(
      success: (currentHotels) {
        final updatedList = currentHotels
            .where((item) => item.hotel.id != hotelId)
            .toList();

        emit(HotelCollectionState.success(updatedList));
      },
    );
  }

}