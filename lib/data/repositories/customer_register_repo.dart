import 'package:byma_app/data/models/customer_register_model.dart';
import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/customer_register_api.dart';

class CustomerRegisterRepo {
  final CustomerRegisterApi customerRegisterApi;

  CustomerRegisterRepo(this.customerRegisterApi);

  Future<String> registerCustomer(CustomerRegisterModel model) async {
    try {
      final response = await customerRegisterApi.registerCustomer(model);

      final Map<String, dynamic> data = response.data;
      final String message = data['message'] ?? 'Registration successful';

      return message;
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
}