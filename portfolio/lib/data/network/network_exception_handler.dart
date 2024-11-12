import 'package:dio/dio.dart';
import 'package:my_portfolio_web_app/data/network/network_error_messages.dart';

class APIException implements Exception {
  final String message;

  APIException({required this.message});
}

class NetworkExceptionHandler {
  static APIException handleError(Exception exception) {
    if (exception is DioException) {
      switch (exception.type) {
        case DioExceptionType.sendTimeout:
          return APIException(message: ErrorMessages.noInternet);
        case DioExceptionType.connectionTimeout:
          return APIException(message: ErrorMessages.connectionTimeout);
        case DioExceptionType.badResponse:
          return APIException(
              message:
                  ErrorResponse.fromJson(exception.response?.data).message);
        default:
          return APIException(message: ErrorMessages.noInternet);
      }
    } else {
      return APIException(message: ErrorMessages.networkGeneral);
    }
  }
}

class ErrorResponse {
  late String message;

  ErrorResponse({required this.message});

  ErrorResponse.fromJson(json) {
    if (json is String) {
      message = json;
    } else {
      message = json['message'] ?? '';
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
