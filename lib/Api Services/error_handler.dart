import 'package:dio/dio.dart';

class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException(this.message, this.statusCode);

  @override
  String toString() {
    return 'AppException: $message (Status Code: $statusCode)';
  }
}

// Handle errors
Exception handleError(dynamic error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return AppException('Connection Timeout', error.response?.statusCode);
      case DioExceptionType.sendTimeout:
        return AppException('Send Timeout', error.response?.statusCode);
      case DioExceptionType.receiveTimeout:
        return AppException('Receive Timeout', error.response?.statusCode);
      case DioExceptionType.badResponse:
        return AppException(
            error.response?.data['message'] ?? 'Unknown Server Error',
            error.response?.statusCode);
      case DioExceptionType.cancel:
        return AppException('Request Cancelled', null);
      case DioExceptionType.badCertificate:
        return AppException('Invalid Certificate', null);
      case DioExceptionType.connectionError:
        return AppException('Network Connectivity Error', null);
      case DioExceptionType.unknown:
        return AppException('Unknown Error', null);
    }
  }
  return AppException('Unexpected Error', null);
}
