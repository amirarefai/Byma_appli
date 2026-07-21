import 'package:dio/dio.dart';

class HotelApi {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://maybe-puzzling-citation.ngrok-free.dev/', // رابط السيرفر الخاص بك
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // 🌟 هذا السطر السحري يحل مشكلة الـ Ngrok تماماً ويمنع حظر الفلاتر من جلب البيانات
        'ngrok-skip-browser-warning': 'true', 
      },
    ),
  );

  Future<Response> getHotels() async {
    return await _dio.get('hotels');
  }

  Future<Response> getHotelDetails(String id) async {
    return await _dio.get('hotels/$id');
  }
}