import 'package:dio/dio.dart';

class ReportsApi {
  final Dio dio;

  ReportsApi(this.dio);

  Future<Response> createReport(int hotelId, String reason) async {
    return await dio.post(
      'reports',
      data: {'hotelId': hotelId, 'reason': reason},
    );
  }
}
