import 'package:dio/dio.dart';

class ProfileApi {
  final Dio dio;

  ProfileApi(this.dio);

  Future<Response> getProfile() async {
    return await dio.get('customers/6');
  }

  Future<Response> updateProfile({
    String? firstName,
    String? lastName,
    String? profileImagePath,
  }) async {
    final Map<String, dynamic> data = {};

    if (firstName != null && firstName.isNotEmpty) {
      data['firstName'] = firstName;
    }
    
    if (lastName != null && lastName.isNotEmpty) {
      data['lastName'] = lastName;
    }
    
    if (profileImagePath != null && profileImagePath.isNotEmpty) {
      data['profileImage'] = await MultipartFile.fromFile(
        profileImagePath,
        filename: profileImagePath.split('/').last,
      );
    }

    final formData = FormData.fromMap(data);

    return await dio.patch(
      'customers',
      data: formData,
    );
  }
}