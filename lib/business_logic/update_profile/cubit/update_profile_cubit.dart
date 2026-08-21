import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:byma_app/data/models/profile_model.dart';
import 'package:byma_app/data/repositories/profile_repo.dart';

part 'update_profile_state.dart';
part 'update_profile_cubit.freezed.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final ProfileRepo _profileRepo;

  UpdateProfileCubit(this._profileRepo) : super(const UpdateProfileState.initial());

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? profileImagePath,
  }) async {
    emit(const UpdateProfileState.loading());
    try {
      final updatedProfile = await _profileRepo.updateProfile(
        firstName: firstName,
        lastName: lastName,
        profileImagePath: profileImagePath,
      );
      
      emit(UpdateProfileState.success(updatedProfile));
    } catch (errorMessage) {
      emit(UpdateProfileState.error(errorMessage.toString()));
    }
  }
}