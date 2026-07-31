import 'package:byma_app/constance/strings.dart';
import 'package:byma_app/data/local_storage/secure_storage_service.dart';
import 'package:dio/dio.dart';

import 'dio_interceptor.dart';

class DioFactory {
  static Dio? _dio;

  static Dio getDio() {
    if (_dio != null) return _dio!;

    final BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    _dio = Dio(options);

    _dio!.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );

    _dio!.interceptors.add(
      DioInterceptor(
        secureStorageService: SecureStorageService(),
      ),
    );

    return _dio!;
  }
}