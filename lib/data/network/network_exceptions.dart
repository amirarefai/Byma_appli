import 'dart:io';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

@freezed
sealed class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;
  const factory NetworkExceptions.unauthorizedRequest(String reason) = UnauthorizedRequest;
  const factory NetworkExceptions.badRequest(String reason) = BadRequest;
  const factory NetworkExceptions.notFound(String reason) = NotFound;
  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;
  const factory NetworkExceptions.notAcceptable() = NotAcceptable;
  const factory NetworkExceptions.requestTimeout() = RequestTimeout;
  const factory NetworkExceptions.sendTimeout() = SendTimeout;
  const factory NetworkExceptions.unprocessableEntity(String reason) = UnprocessableEntity;
  const factory NetworkExceptions.conflict(String reason) = Conflict;
  const factory NetworkExceptions.internalServerError() = InternalServerError;
  const factory NetworkExceptions.notImplemented() = NotImplemented;
  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;
  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;
  const factory NetworkExceptions.formatException() = FormatException;
  const factory NetworkExceptions.unableToProcess() = UnableToProcess;
  const factory NetworkExceptions.defaultError(String error) = DefaultError;
  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  // Updated to parse NestJS standard JSON error responses
  static NetworkExceptions handleResponse(Response? response) {
    int statusCode = response?.statusCode ?? 0;
    var data = response?.data;
    String errorMessage = "An unexpected error occurred";

    if (data != null && data is Map<String, dynamic>) {
      if (data['message'] is List) {
        errorMessage = (data['message'] as List).join('\n');
      } else if (data['message'] is String) {
        errorMessage = data['message'];
      }
    }

    switch (statusCode) {
      case 400:
        return NetworkExceptions.badRequest(errorMessage);
      case 401:
      case 403:
        return NetworkExceptions.unauthorizedRequest(errorMessage);
      case 404:
        return NetworkExceptions.notFound(errorMessage);
      case 409:
        return NetworkExceptions.conflict(errorMessage);
      case 408:
        return const NetworkExceptions.requestTimeout();
      case 422:
        return NetworkExceptions.unprocessableEntity(errorMessage);
      case 500:
        return const NetworkExceptions.internalServerError();
      case 503:
        return const NetworkExceptions.serviceUnavailable();
      default:
        return NetworkExceptions.defaultError("Received invalid status code: $statusCode");
    }
  }

  static NetworkExceptions getDioException(dynamic error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioExceptionType.connectionTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioExceptionType.connectionError:
            case DioExceptionType.unknown:
              networkExceptions = const NetworkExceptions.noInternetConnection();
              break;
            case DioExceptionType.receiveTimeout:
            case DioExceptionType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType.badResponse:
              networkExceptions = NetworkExceptions.handleResponse(error.response);
              break;
            case DioExceptionType.badCertificate:
              networkExceptions = const NetworkExceptions.unexpectedError();
              break;
            case DioExceptionType.transformTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException catch (_) {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  // Updated to use Dart 3 native pattern matching switch instead of .when()
  static String getErrorMessage(NetworkExceptions networkExceptions) {
    return switch (networkExceptions) {
      NotImplemented() => "Not Implemented",
      RequestCancelled() => "Request Cancelled",
      InternalServerError() => "Internal Server Error",
      NotFound(reason: final reason) => reason,
      ServiceUnavailable() => "Service unavailable",
      MethodNotAllowed() => "Method Not Allowed",
      BadRequest(reason: final reason) => reason,
      UnauthorizedRequest(reason: final error) => error,
      UnprocessableEntity(reason: final error) => error,
      UnexpectedError() => "Unexpected error occurred",
      RequestTimeout() => "Connection request timeout",
      NoInternetConnection() => "No internet connection",
      Conflict(reason: final reason) => reason,
      SendTimeout() => "Send timeout in connection with API server",
      UnableToProcess() => "Unable to process the data",
      DefaultError(error: final error) => error,
      FormatException() => "Unexpected error occurred",
      NotAcceptable() => "Not acceptable",
    };
  }
}