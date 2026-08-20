import 'package:dio/dio.dart';

class PointsTransactionsApi {
  final Dio dio;

  PointsTransactionsApi(this.dio);
  Future<Response> createPointsTransactions(int pointsAmount) async {
    return await dio.post(
      'points-transactions',
      data: {'pointsAmount': pointsAmount},
    );
  }
}
