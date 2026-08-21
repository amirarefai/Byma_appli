import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/repositories/room_details_repo.dart';
import 'room_category_state.dart';

class RoomCategoryCubit extends Cubit<RoomCategoryState> {
  final RoomDetailsRepo roomDetailsRepo;

  RoomCategoryCubit(this.roomDetailsRepo) : super(const RoomCategoryState.initial());

  Future<void> fetchAllRoomCategories() async {
    emit(const RoomCategoryState.loading());

    try {
      final roomCategories = await roomDetailsRepo.fetchAllRoomCategories();
      emit(RoomCategoryState.success(roomCategories));
    } catch (errorMessage) {
      emit(RoomCategoryState.error(errorMessage.toString()));
    }
  }
}