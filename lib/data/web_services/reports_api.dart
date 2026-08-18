import 'package:dio/dio.dart';

class ReportsApi {
  final Dio dio;

  ReportsApi(this.dio);

  // جلب كافة التقارير
  Future<Response> getAllReports() async {
    return await dio.get('reports');
  }

  // إنشاء تقرير جديد (مطابق لطلب Postman)
  Future<Response> createReport(int hotelId, String reason) async {
    return await dio.post(
      'reports',
      data: {
        'hotelId': hotelId,
        'reason': reason,
      },
    );
  }

  // حذف تقرير محدد
  Future<Response> removeReport(int reportId) async {
    return await dio.delete('reports/$reportId');
  }
}