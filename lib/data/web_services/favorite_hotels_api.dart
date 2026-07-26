import 'package:dio/dio.dart';

class FavoriteHotelsApi {
  final Dio dio;

  FavoriteHotelsApi(this.dio);

  Future<Response> getFavoriteHotels() async {
    return await dio.get('favorites/hotels');
  }

  Future<Response> addFavoriteHotel(int hotelId) async {
    return await dio.post(
      'favorites/hotels',
      data: {
        'hotelId': hotelId,
      },
    );
  }
  Future<Response> removeFavoriteHotel(int favoriteHotelId) async {
    return await dio.delete('favorites/hotels/$favoriteHotelId');
  }
}