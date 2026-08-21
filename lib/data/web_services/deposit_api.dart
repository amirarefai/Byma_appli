import 'package:byma_app/data/models/deposit_request_model.dart';
import 'package:dio/dio.dart';

class DepositApi {
  final Dio dio;

  DepositApi(this.dio);

  Future<Response> createDeposit(DepositRequestModel model) async {
    // Convert the model into FormData for multipart/form-data upload
    final formData = FormData.fromMap({
      'amount': model.amount,
      'receiptNumber': model.receiptNumber,
      // MultipartFile.fromFile reads the physical file path for the API
      'receiptImage': await MultipartFile.fromFile(
        model.receiptImage.path,
        filename: model.receiptImage.path.split('/').last,
      ),
      
    });

    // The DioInterceptor already handles the base URL and tokens
    return await dio.post(
      'wallet/deposit',
      data: formData,
    );  
  }

  Future<Response> getDepositHistory() async {
    return await dio.get('wallet/deposit-transactions');
  }
}