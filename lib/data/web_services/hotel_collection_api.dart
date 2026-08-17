import 'package:dio/dio.dart';

class HotelCollectionApi {
  final Dio dio;

  HotelCollectionApi(this.dio);

  Future<Response> getHotelsCollection(int collectionId) async {
    return await dio.get('collections/$collectionId/hotels');
  }

  Future<Response> removeHotelFromCollection(int collectionId, int hotelId) async {
    return await dio.delete('collections/$collectionId/hotels/$hotelId');
  }

   Future<Response> addHotelToCollection(int collectionId, int hotelId) async {
    return await dio.post('collections/$collectionId/hotels', data: {'hotelId': hotelId});
  }
}