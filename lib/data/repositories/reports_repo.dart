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
}
