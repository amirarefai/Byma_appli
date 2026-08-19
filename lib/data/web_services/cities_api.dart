import 'package:dio/dio.dart';

class CitiesApi {
  final Dio dio;

  CitiesApi(this.dio);

  Future<Response> getAllCities() async {
    return await dio.get('cities');
  }
}