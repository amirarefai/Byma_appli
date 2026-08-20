import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/repositories/points_transactions_repo.dart';
import 'points_transactions_state.dart';

class PointsTransactionsCubit extends Cubit<PointsTransactionsState> {
  final PointsTransactionsRepo pointsTransactionsRepo;

  PointsTransactionsCubit(this.pointsTransactionsRepo) : super(const PointsTransactionsState.initial());

  Future<void> createPointsTransactions(int pointsAmount) async {
    emit(const PointsTransactionsState.loading());

    try {
      await pointsTransactionsRepo.createPointsTransactions(pointsAmount);
      emit(const PointsTransactionsState.success());
    } catch (errorMessage) {
      emit(PointsTransactionsState.error(errorMessage.toString()));
    }
  }
}