import 'package:bloc/bloc.dart';
import 'package:byma_app/data/repositories/special_services_repo.dart';
import 'special_services_state.dart';

class SpecialServicesCubit extends Cubit<SpecialServicesState> {
  final SpecialServicesRepo specialServicesRepo;

  SpecialServicesCubit(this.specialServicesRepo)
      : super(const SpecialServicesState.initial());

  Future<void> fetchAllSpecialServices(int roomId) async {
    emit(const SpecialServicesState.loading());

    try {
      final specialServices = await specialServicesRepo.fetchAllSpecialServices(roomId);
      emit(SpecialServicesState.success(specialServices));
    } catch (errorMessage) {
      emit(SpecialServicesState.error(errorMessage.toString()));
    }
  }
}
