import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:byma_app/data/models/special_service_model.dart';

part 'special_services_state.freezed.dart';

@freezed
class SpecialServicesState with _$SpecialServicesState {
  const factory SpecialServicesState.initial() = _Initial;
  const factory SpecialServicesState.loading() = _Loading;
  const factory SpecialServicesState.success(
    List<SpecialServiceModel> specialServices,
  ) = _Success;
  const factory SpecialServicesState.error(String message) = _Error;
}
