import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:byma_app/data/models/city_model.dart';

part 'cities_state.freezed.dart';

@freezed
sealed class CitiesState with _$CitiesState {
  const factory CitiesState.initial() = _Initial;
  const factory CitiesState.loading() = _Loading;
  const factory CitiesState.success(List<CityModel> cities) = _Success;
  const factory CitiesState.error(String message) = _Error;
}