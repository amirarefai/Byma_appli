import 'package:freezed_annotation/freezed_annotation.dart';

part 'reports_state.freezed.dart';

@freezed
class ReportsState with _$ReportsState {
  const factory ReportsState.initial() = _Initial;
  const factory ReportsState.loading() = _Loading;
  const factory ReportsState.success(List<dynamic> reports) = _Success; // استبدل dynamic بـ Model التقارير لديك
  const factory ReportsState.error(String message) = _Error;
}