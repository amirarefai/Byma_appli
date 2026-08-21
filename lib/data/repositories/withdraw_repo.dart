import 'package:byma_app/data/models/withdraw_history_model.dart';
import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/withdraw_api.dart';

class WithdrawRepo {
  final WithdrawApi withdrawApi;

  WithdrawRepo(this.withdrawApi);

  Future<void> createWithdrawRequest(num amount) async {
    try {
      await withdrawApi.createWithdrawRequest(amount);
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

 Future<List<WithdrawHistoryModel>> fetchWithdrawHistory() async {
    try {
      final response = await withdrawApi.getWithdrawHistory();
      final List<dynamic> data = response.data;
      return data
          .map((e) => WithdrawHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
}