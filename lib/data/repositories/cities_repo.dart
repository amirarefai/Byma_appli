import 'package:byma_app/data/models/city_model.dart';
import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/cities_api.dart';

class CitiesRepo {
  final CitiesApi citiesApi;

  CitiesRepo(this.citiesApi);

  Future<List<CityModel>> fetchAllCities() async {
    try {
      final response = await citiesApi.getAllCities();

      final List<dynamic> data = response.data;

      final List<CityModel> cities = data
          .map((item) => CityModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return cities;
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
}