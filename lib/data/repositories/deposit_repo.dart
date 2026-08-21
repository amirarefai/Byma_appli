import 'package:byma_app/data/models/deposit_history_model.dart';
import 'package:byma_app/data/models/deposit_request_model.dart';
import 'package:byma_app/data/network/network_exceptions.dart';
import 'package:byma_app/data/web_services/deposit_api.dart';

class DepositRepo {
  final DepositApi depositApi;

  DepositRepo(this.depositApi);

  Future<String> createDeposit(DepositRequestModel model) async {
    try {
      final response = await depositApi.createDeposit(model);

      final Map<String, dynamic> data = response.data;
      final String message = data['message'] ?? 'Deposit created successfully';

      return message;
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }

  Future<List<DepositHistoryModel>> fetchDepositHistory() async {
    try {
      final response = await depositApi.getDepositHistory();
      final List<dynamic> data = response.data;
      return data
          .map((e) => DepositHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (error) {
      final networkException = NetworkExceptions.getDioException(error);
      final errorMessage = NetworkExceptions.getErrorMessage(networkException);
      throw errorMessage;
    }
  }
}
