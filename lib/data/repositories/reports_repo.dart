import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/reports_api.dart';

class ReportsRepo {
  final ReportsApi reportsApi;

  ReportsRepo(this.reportsApi);

  // إنشاء تقرير جديد
  Future<void> createReport(int hotelId, String reason) async {
    try {
      await reportsApi.createReport(hotelId, reason);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

  // جلب كافة التقارير كـ List مباشرة بدون موديل
  Future<List<dynamic>> fetchAllReports() async {
    try {
      final response = await reportsApi.getAllReports();
      return response.data as List<dynamic>;
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

  // حذف تقرير
  Future<void> removeReport(int reportId) async {
    try {
      await reportsApi.removeReport(reportId);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
}