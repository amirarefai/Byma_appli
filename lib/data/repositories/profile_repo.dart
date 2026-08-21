import 'package:byma_app/data/models/profile_model.dart';
import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/profile_api.dart';

class ProfileRepo {
  final ProfileApi profileApi;

  ProfileRepo(this.profileApi);

  Future<ProfileModel> fetchProfile() async {
    try {
      final response = await profileApi.getProfile();

      final Map<String, dynamic> data = response.data;

      return ProfileModel.fromJson(data);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

  Future<ProfileModel> updateProfile({
    String? firstName,
    String? lastName,
    String? profileImagePath,
  }) async {
    try {
      final response = await profileApi.updateProfile(
        firstName: firstName,
        lastName: lastName,
        profileImagePath: profileImagePath,
      );

      final Map<String, dynamic> data = response.data;

      return ProfileModel.fromJson(data);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
}
