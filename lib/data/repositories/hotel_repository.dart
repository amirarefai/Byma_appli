import 'package:dio/dio.dart';
import '../web_services/hotel_api.dart'; // 🌟 تم تصحيح المسار هنا
import '../models/hotel_model.dart';

class HotelRepository {
  final HotelApi _hotelApi = HotelApi(); // استدعاء طبقة الـ API

  Future<List<HotelModel>> fetchHotels() async {
    try {
      final response = await _hotelApi.getHotels();
      if (response.statusCode == 200) {
        final List data = response.data is List ? response.data : response.data['data'] ?? [];
        return data.map((json) => HotelModel.fromJson(json)).toList();
      }
      throw Exception('فشل التحميل');
    } catch (e) {
      throw Exception('خطأ في الشبكة: $e');
    }
  }

  Future<HotelModel> fetchHotelDetails(String id) async {
    try {
      final response = await _hotelApi.getHotelDetails(id);
      if (response.statusCode == 200 && response.data != null) {
        return HotelModel.fromJson(response.data);
      }
      throw Exception('فشل تحميل تفاصيل الفندق');
    } catch (e) {
      throw Exception('خطأ في الشبكة أثناء جلب تفاصيل الفندق: $e');
    }
  }
}