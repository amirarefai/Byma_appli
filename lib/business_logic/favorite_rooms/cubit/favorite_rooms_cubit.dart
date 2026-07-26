import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_rooms_state.dart';
part 'favorite_rooms_cubit.freezed.dart';

class FavoriteRoomsCubit extends Cubit<FavoriteRoomsState> {
  FavoriteRoomsCubit() : super(FavoriteRoomsState.initial());
}
