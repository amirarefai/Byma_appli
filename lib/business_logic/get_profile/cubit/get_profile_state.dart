part of 'get_profile_cubit.dart';

@freezed
class GetProfileState with _$GetProfileState {
  const factory GetProfileState.initial() = _Initial;
  const factory GetProfileState.loading() = _Loading;
  const factory GetProfileState.success(ProfileModel profile) = _Success;
  const factory GetProfileState.error(String message) = _Error;
}