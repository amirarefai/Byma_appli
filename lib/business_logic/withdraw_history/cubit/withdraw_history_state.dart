part of 'withdraw_history_cubit.dart';

@freezed
class WithdrawHistoryState with _$WithdrawHistoryState {
  const factory WithdrawHistoryState.initial() = _Initial;
  const factory WithdrawHistoryState.loading() = _Loading;
  const factory WithdrawHistoryState.success(List<WithdrawHistoryModel> withdrawHistory) = _Success;
  const factory WithdrawHistoryState.error(String message) = _Error;
}