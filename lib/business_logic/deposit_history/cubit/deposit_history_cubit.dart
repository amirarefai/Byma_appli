import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:byma_app/data/models/deposit_history_model.dart';
import 'package:byma_app/data/repositories/deposit_repo.dart'; 

part 'deposit_history_state.dart';
part 'deposit_history_cubit.freezed.dart';

class DepositHistoryCubit extends Cubit<DepositHistoryState> {
  final DepositRepo _depositRepo;

  DepositHistoryCubit(this._depositRepo) : super(const DepositHistoryState.initial());

  Future<void> fetchDepositHistory() async {
    emit(const DepositHistoryState.loading());
    try {
      final depositHistory = await _depositRepo.fetchDepositHistory();
      emit(DepositHistoryState.success(depositHistory));
    } catch (errorMessage) {
      emit(DepositHistoryState.error(errorMessage.toString()));
    }
  }
}