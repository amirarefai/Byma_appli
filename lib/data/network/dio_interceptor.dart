import 'package:byma_app/data/local_storage/secure_storage_service.dart';
import 'package:byma_app/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class DioInterceptor extends Interceptor {
  final SecureStorageService secureStorageService;

  DioInterceptor({required this.secureStorageService});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await secureStorageService.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      debugPrint("Unauthorized access - clearing token and redirecting to login");

      if (navigatorKey.currentContext != null) {
        ScaffoldMessenger.of(navigatorKey.currentContext!).clearSnackBars();
      }

      await secureStorageService.deleteToken();

      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/login',
        (route) => false,
      );
    }

    return handler.next(err);
  }
}