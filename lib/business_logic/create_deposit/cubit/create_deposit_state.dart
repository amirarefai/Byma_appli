import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_deposit_state.freezed.dart';

@freezed
sealed class CreateDepositState with _$CreateDepositState {
  const factory CreateDepositState.initial() = _Initial;
  const factory CreateDepositState.loading() = _Loading;
  const factory CreateDepositState.success() = _Success;
  const factory CreateDepositState.error(String message) = _Error;
}