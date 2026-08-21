import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/repositories/withdraw_repo.dart';
import 'create_withdraw_state.dart';

class CreateWithdrawCubit extends Cubit<CreateWithdrawState> {
  final WithdrawRepo withdrawRepo;

  CreateWithdrawCubit(this.withdrawRepo) : super(const CreateWithdrawState.initial());

  Future<void> createWithdraw(num amount) async {
    emit(const CreateWithdrawState.loading());

    try {
      await withdrawRepo.createWithdrawRequest(amount);
      emit(const CreateWithdrawState.success());
    } catch (errorMessage) {
      emit(CreateWithdrawState.error(errorMessage.toString()));
    }
  }
}