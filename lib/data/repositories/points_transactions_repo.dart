import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/points_transactions_api.dart';

class PointsTransactionsRepo {
  final PointsTransactionsApi pointsTransactionsApi;

  PointsTransactionsRepo(this.pointsTransactionsApi);
  
  Future<void> createPointsTransactions(int pointsAmount) async {
    try {
      await pointsTransactionsApi.createPointsTransactions(pointsAmount);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
}