import 'package:byma_app/business_logic/reports/cubit/reports_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/repositories/reports_repo.dart';

class ReportsCubit extends Cubit<ReportsState> {
  final ReportsRepo reportsRepo;

  ReportsCubit(this.reportsRepo) : super(const ReportsState.initial());

  // جلب التقارير
  Future<void> fetchAllReports() async {
    emit(const ReportsState.loading());
    try {
      final reports = await reportsRepo.fetchAllReports();
      emit(ReportsState.success(reports));
    } catch (errorMessage) {
      emit(ReportsState.error(errorMessage.toString()));
    }
  }

  // دالة إرسال تقرير جديد
  Future<void> createReport({required int hotelId, required String reason}) async {
    emit(const ReportsState.loading());
    try {
      await reportsRepo.createReport(hotelId, reason);
      // إعادة جلب التقارير بعد الإضافة بنجاح (اختياري)
      await fetchAllReports();
    } catch (errorMessage) {
      emit(ReportsState.error(errorMessage.toString()));
    }
  }

  // الحذف التفاعلي المباشر (Optimistic Delete)
  void deleteReportOptimistically(int reportId) {
    state.whenOrNull(
      success: (currentReports) {
        final updatedList =
            currentReports.where((report) => report.id != reportId).toList();
        emit(ReportsState.success(updatedList));
      },
    );
  }
}