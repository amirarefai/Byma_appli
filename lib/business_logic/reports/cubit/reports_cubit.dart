import 'package:byma_app/business_logic/reports/cubit/reports_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/repositories/reports_repo.dart';

class ReportsCubit extends Cubit<ReportsState> {
  final ReportsRepo reportsRepo;

  ReportsCubit(this.reportsRepo) : super(const ReportsState.initial());

  

  Future<void> createReport({required int hotelId, required String reason}) async {
    emit(const ReportsState.loading());
    try {
      await reportsRepo.createReport(hotelId, reason);
      emit(const ReportsState.success());
    } catch (errorMessage) {
      emit(ReportsState.error(errorMessage.toString()));
    }
  }

  
}