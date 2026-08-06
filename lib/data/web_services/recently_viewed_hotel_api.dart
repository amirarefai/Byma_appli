import 'package:dio/dio.dart';

class RecentlyViewedHotelApi {
  final Dio dio;

  RecentlyViewedHotelApi(this.dio);

  Future<Response> getRecentlyViewedHotels() async {
    return await dio.get('recently-viewed/hotels'); 
  }

  Future<Response> addRecentlyViewedHotel(int hotelId) async {
    return await dio.post(
      'recently-viewed/hotels', 
      data: {
        'hotelId': hotelId,
      },
    );
  }
}