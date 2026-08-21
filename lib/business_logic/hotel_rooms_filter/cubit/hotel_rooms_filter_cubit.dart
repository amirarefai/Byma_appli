import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:byma_app/data/models/room_model.dart';
import 'package:byma_app/data/models/room_filter_model.dart';
import 'package:byma_app/data/repositories/hotels_repo.dart';

part 'hotel_rooms_filter_state.dart';
part 'hotel_rooms_filter_cubit.freezed.dart';

class HotelRoomsFilterCubit extends Cubit<HotelRoomsFilterState> {
  final HotelsRepo hotelsRepo;

  HotelRoomsFilterCubit(this.hotelsRepo) : super(const HotelRoomsFilterState.initial());

  void resetFilter() {
    emit(const HotelRoomsFilterState.initial());
  }

  Future<void> fetchFilteredRooms(int hotelId, RoomFilterModel filter) async {
    emit(const HotelRoomsFilterState.loading());
    
    try {
      final rooms = await hotelsRepo.fetchHotelRooms(
        hotelId,
        filter: filter,
      );
      
      if (rooms.isEmpty) {
        // Handling empty states explicitly is much safer for the UI
        emit(const HotelRoomsFilterState.success([])); 
        return;
      }
      
      emit(HotelRoomsFilterState.success(rooms));
    } catch (errorMessage) {
      emit(HotelRoomsFilterState.error(errorMessage.toString()));
    }
  }
}