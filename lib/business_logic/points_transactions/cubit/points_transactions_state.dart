import 'package:freezed_annotation/freezed_annotation.dart';

part 'points_transactions_state.freezed.dart';

@freezed
sealed class PointsTransactionsState with _$PointsTransactionsState {
  const factory PointsTransactionsState.initial() = _Initial;
  const factory PointsTransactionsState.loading() = _Loading;
  const factory PointsTransactionsState.success() = _Success;
  const factory PointsTransactionsState.error(String message) = _Error;
}