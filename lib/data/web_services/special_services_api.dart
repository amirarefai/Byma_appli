import 'package:dio/dio.dart';

class SpecialServicesApi {
  final Dio dio;

  SpecialServicesApi(this.dio);

  Future<Response> getAllSpecialServices(int roomId) async {
    return await dio.get('rooms/$roomId/special-services');
  }
}
