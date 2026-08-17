import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:byma_app/data/models/room_details_model.dart';
import 'package:byma_app/data/repositories/room_details_repo.dart'; // Adjust import path if needed

part 'room_details_state.dart';
part 'room_details_cubit.freezed.dart';

class RoomDetailsCubit extends Cubit<RoomDetailsState> {
  final RoomDetailsRepo _roomDetailsRepo;

  RoomDetailsCubit(this._roomDetailsRepo) : super(const RoomDetailsState.initial());

  Future<void> fetchRoomDetails(int roomId) async {
    emit(const RoomDetailsState.loading());
    try {
      final roomDetails = await _roomDetailsRepo.fetchRoomDetails(roomId);
      emit(RoomDetailsState.success(roomDetails));
    } catch (errorMessage) {
      emit(RoomDetailsState.error(errorMessage.toString()));
    }
  }
}