import 'package:dio/dio.dart';

class RecentlyViewedHotelApi {
  final Dio dio;

  RecentlyViewedHotelApi(this.dio);

  // جلب قائمة الفنادق المشاهدة مؤخراً
  Future<Response> getRecentlyViewedHotels() async {
    return await dio.get('recently-viewed/hotels'); // عدل الرابط حسب الـ API لديك
  }

  // إضافة فندق لقائمة المشاهدة حديثاً
  Future<Response> addRecentlyViewedHotel(int hotelId) async {
    return await dio.post(
      'recently-viewed/hotels', // عدل الرابط حسب الـ API لديك
      data: {
        'hotelId': hotelId,
      },
    );
  }

  // حذف فندق من قائمة المشاهدة حديثاً
  Future<Response> removeRecentlyViewedHotel(int recordId) async {
    return await dio.delete('recently-viewed/hotels/$recordId'); // عدل الرابط حسب الـ API لديك
  }
}