import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/models/customer_register_model.dart';
import 'package:byma_app/data/repositories/customer_register_repo.dart';
import 'customer_register_state.dart';

class CustomerRegisterCubit extends Cubit<CustomerRegisterState> {
  final CustomerRegisterRepo customerRegisterRepo;

  CustomerRegisterCubit(this.customerRegisterRepo)
      : super(const CustomerRegisterState.initial());

  Future<void> registerCustomer(CustomerRegisterModel model) async {
    emit(const CustomerRegisterState.loading());

    try {
      final message = await customerRegisterRepo.registerCustomer(model);
      emit(CustomerRegisterState.success(message));
    } catch (errorMessage) {
      emit(CustomerRegisterState.error(errorMessage.toString()));
    }
  }
}