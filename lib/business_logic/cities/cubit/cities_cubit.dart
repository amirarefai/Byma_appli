import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/repositories/cities_repo.dart';
import 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  final CitiesRepo citiesRepo;

  CitiesCubit(this.citiesRepo) : super(const CitiesState.initial());

  Future<void> fetchAllCities() async {
    emit(const CitiesState.loading());

    try {
      final cities = await citiesRepo.fetchAllCities();
      emit(CitiesState.success(cities));
    } catch (errorMessage) {
      emit(CitiesState.error(errorMessage.toString()));
    }
  }
}