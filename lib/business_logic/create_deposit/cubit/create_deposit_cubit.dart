import 'package:byma_app/data/models/deposit_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/repositories/deposit_repo.dart';
import 'create_deposit_state.dart';

class CreateDepositCubit extends Cubit<CreateDepositState> {
  final DepositRepo depositRepo;

  CreateDepositCubit(this.depositRepo) : super(const CreateDepositState.initial());

  Future<void> createDeposit(DepositRequestModel model) async {
    emit(const CreateDepositState.loading());

    try {
      await depositRepo.createDeposit(model);
      emit(const CreateDepositState.success());
    } catch (errorMessage) {
      emit(CreateDepositState.error(errorMessage.toString()));
    }
  }
}