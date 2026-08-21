import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_withdraw_state.freezed.dart';

@freezed
sealed class CreateWithdrawState with _$CreateWithdrawState {
  const factory CreateWithdrawState.initial() = _Initial;
  const factory CreateWithdrawState.loading() = _Loading;
  const factory CreateWithdrawState.success() = _Success;
  const factory CreateWithdrawState.error(String message) = _Error;
}