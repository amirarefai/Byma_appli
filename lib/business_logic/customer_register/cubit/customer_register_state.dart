import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_register_state.freezed.dart';

@freezed
sealed class CustomerRegisterState with _$CustomerRegisterState {
  const factory CustomerRegisterState.initial() = _Initial;
  const factory CustomerRegisterState.loading() = _Loading;
  const factory CustomerRegisterState.success(String message) = _Success;
  const factory CustomerRegisterState.error(String message) = _Error;
}