import 'package:dio/dio.dart';

class HotelsApi {
  final Dio dio;

  HotelsApi(this.dio);

  Future<Response> getAllHotels() async {
    return await dio.get('hotels');
  }
}