part of 'deposit_history_cubit.dart';

@freezed
class DepositHistoryState with _$DepositHistoryState {
  const factory DepositHistoryState.initial() = _Initial;
  const factory DepositHistoryState.loading() = _Loading;
  const factory DepositHistoryState.success(List<DepositHistoryModel> depositHistory) = _Success;
  const factory DepositHistoryState.error(String message) = _Error;
}