import 'package:byma_app/data/models/customer_register_model.dart';
import 'package:dio/dio.dart';

class CustomerRegisterApi {
  final Dio dio;

  CustomerRegisterApi(this.dio);

  Future<Response> registerCustomer(CustomerRegisterModel model) async {
    // Convert the model into FormData for multipart/form-data upload
    final formData = FormData.fromMap({
      'email': model.email,
      'password': model.password,
      'firstName': model.firstName,
      'lastName': model.lastName,
      'phone': model.phone,
      // MultipartFile.fromFile reads the physical file path for the API
      'profileImage': await MultipartFile.fromFile(
        model.profileImage.path,
        filename: model.profileImage.path.split('/').last,
      ),
      'idImage': await MultipartFile.fromFile(
        model.idImage.path,
        filename: model.idImage.path.split('/').last,
      ),
    });

    // The DioInterceptor already handles the base URL and tokens
    return await dio.post(
      '/auth/customer/register',
      data: formData,
    );
  }
}