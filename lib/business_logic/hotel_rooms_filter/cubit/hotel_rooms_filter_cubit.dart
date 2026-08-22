import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:byma_app/data/models/room_model.dart';
import 'package:byma_app/data/models/room_filter_model.dart';
import 'package:byma_app/data/repositories/hotels_repo.dart';

part 'hotel_rooms_filter_state.dart';
part 'hotel_rooms_filter_cubit.freezed.dart';

class HotelRoomsFilterCubit extends Cubit<HotelRoomsFilterState> {
  final HotelsRepo hotelsRepo;
  int _requestId = 0;

  HotelRoomsFilterCubit(this.hotelsRepo) : super(const HotelRoomsFilterState.initial());

  void resetFilter() {
    _requestId++;
    emit(const HotelRoomsFilterState.initial());
  }

  Future<void> fetchFilteredRooms(int hotelId, RoomFilterModel filter) async {
    final requestId = ++_requestId;
    emit(const HotelRoomsFilterState.loading());
    
    try {
      final rooms = await hotelsRepo.fetchHotelRooms(
        hotelId,
        filter: filter,
      );
      
      if (!isClosed && requestId == _requestId) {
        emit(HotelRoomsFilterState.success(rooms));
      }
    } catch (errorMessage) {
      if (!isClosed && requestId == _requestId) {
        emit(HotelRoomsFilterState.error(errorMessage.toString()));
      }
    }
  }
}