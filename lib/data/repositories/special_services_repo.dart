import 'package:byma_app/data/models/special_service_model.dart';
import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/special_services_api.dart';

class SpecialServicesRepo {
  final SpecialServicesApi specialServicesApi;

  SpecialServicesRepo(this.specialServicesApi);

  Future<List<SpecialServiceModel>> fetchAllSpecialServices(int roomId) async {
    try {
      final response = await specialServicesApi.getAllSpecialServices(roomId);

      final List<dynamic> data = response.data;

      final List<SpecialServiceModel> specialServices = data
          .map(
            (item) => SpecialServiceModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();

      return specialServices;
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
}
