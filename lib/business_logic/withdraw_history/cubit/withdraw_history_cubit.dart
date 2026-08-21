import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:byma_app/data/models/withdraw_history_model.dart';
import 'package:byma_app/data/repositories/withdraw_repo.dart'; 

part 'withdraw_history_state.dart';
part 'withdraw_history_cubit.freezed.dart';

class WithdrawHistoryCubit extends Cubit<WithdrawHistoryState> {
  final WithdrawRepo _withdrawRepo;

  WithdrawHistoryCubit(this._withdrawRepo) : super(const WithdrawHistoryState.initial());

  Future<void> fetchWithdrawHistory() async {
    emit(const WithdrawHistoryState.loading());
    try {
      final withdrawHistory = await _withdrawRepo.fetchWithdrawHistory();
      emit(WithdrawHistoryState.success(withdrawHistory));
    } catch (errorMessage) {
      emit(WithdrawHistoryState.error(errorMessage.toString()));
    }
  }
}