import 'package:dio/dio.dart';

class HotelsApi {
  final Dio dio;

  HotelsApi(this.dio);

  Future<Response> getAllHotels({Map<String, dynamic>? queryParameters}) async {
    return await dio.get('hotels', queryParameters: queryParameters);
  }

  Future<Response> getHotelDetails(int hotelId) async {
    return await dio.get('hotels/$hotelId');
  }

  Future<Response> getHotelRooms(int hotelId, {Map<String, dynamic>? queryParameters}) async {
    return await dio.get('hotels/$hotelId/rooms', queryParameters: queryParameters);
  }
}
