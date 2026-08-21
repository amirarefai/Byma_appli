import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:byma_app/data/models/profile_model.dart';
import 'package:byma_app/data/repositories/profile_repo.dart'; 

part 'get_profile_state.dart';
part 'get_profile_cubit.freezed.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  final ProfileRepo _profileRepo;

  GetProfileCubit(this._profileRepo) : super(const GetProfileState.initial());

  Future<void> fetchProfile() async {
    emit(const GetProfileState.loading());
    try {
      final profile = await _profileRepo.fetchProfile();
      emit(GetProfileState.success(profile));
    } catch (errorMessage) {
      emit(GetProfileState.error(errorMessage.toString()));
    }
  }
}