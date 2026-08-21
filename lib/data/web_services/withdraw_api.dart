import 'package:dio/dio.dart';

class WithdrawApi {
  final Dio dio;

  WithdrawApi(this.dio);
  Future<Response> createWithdrawRequest(num amount) async {
    return await dio.post(
      'wallet/withdraw',
      data: {'amount': amount},
    );
  }

  Future<Response> getWithdrawHistory() async {
    return await dio.get('wallet/withdraw-transactions');
  }
}
