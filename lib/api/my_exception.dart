part of '../mymo.dart';

enum MyServerExceptionType {
  requestCancelled,
  requestTimeout,
  receiveTimeout,
  sendTimeout,
  connectionError,
  badCertificate,
  badRequest,
  unauthorisedRequest,
  notFound,
  notImplemented,
  unableToProcess,
  conflict,
  internalServerError,
  serviceUnavailable,
  formatException,
  unexpectedError,
  socketException,
}

abstract class MyBaseException {}

class MyServerException extends MyCompare implements MyBaseException {
  final String name, message;
  final String? key;
  final int? statusCode;
  final dynamic details;
  final MyServerExceptionType exceptionType;

  MyServerException({
    required this.message,
    this.key,
    this.details,
    this.exceptionType = MyServerExceptionType.unexpectedError,
    int? statusCode,
  })  : statusCode = statusCode ?? 500,
        name = exceptionType.name;

  factory MyServerException.fromError(Object error, [StackTrace? stackTrace]) {
    switch (error) {
      case SocketException _:
        return MyServerException(
          exceptionType: MyServerExceptionType.connectionError,
          message: 'Connection error : ${error.toString()}',
        );
      case HttpException _:
        return MyServerException(
          exceptionType: MyServerExceptionType.unexpectedError,
          message: 'HTTP request error : ${error.toString()}',
        );
      case FormatException _:
        return MyServerException(
          exceptionType: MyServerExceptionType.formatException,
          statusCode: 400,
          message: 'Invalid format : ${error.toString()}',
        );
      default:
        return MyServerException(
          exceptionType: MyServerExceptionType.unexpectedError,
          message: 'Unexpected error : ${error.toString()}',
        );
    }
  }

  factory MyServerException.fromHttpResponse(int statusCode, String? body) {
    final data = body != null ? jsonDecode(body) : {};
    final key = data['key']?.toString();
    final message = data['msg']?.toString();
    final details = data['reason']?.toString();

    switch (statusCode) {
      case 400:
        return MyServerException(
          statusCode: statusCode,
          key: key,
          details: details,
          exceptionType: MyServerExceptionType.badRequest,
          message: message ?? 'Bad request',
        );
      case 401:
        return MyServerException(
          statusCode: statusCode,
          key: key,
          details: details,
          exceptionType: MyServerExceptionType.unauthorisedRequest,
          message: message ?? 'Authentication failure',
        );
      case 403:
        return MyServerException(
          statusCode: statusCode,
          key: key,
          details: details,
          exceptionType: MyServerExceptionType.unauthorisedRequest,
          message: message ?? 'User is not authorized to access API',
        );
      case 404:
        return MyServerException(
          statusCode: statusCode,
          key: key,
          details: details,
          exceptionType: MyServerExceptionType.notFound,
          message: message ?? 'Resource not found',
        );
      case 500:
        return MyServerException(
          statusCode: statusCode,
          key: key,
          details: details,
          exceptionType: MyServerExceptionType.internalServerError,
          message: message ?? 'Internal server error',
        );
      case 503:
        return MyServerException(
          statusCode: statusCode,
          key: key,
          details: details,
          exceptionType: MyServerExceptionType.serviceUnavailable,
          message: message ?? 'Service unavailable',
        );
      default:
        return MyServerException(
          statusCode: statusCode,
          key: key,
          details: details,
          exceptionType: MyServerExceptionType.unexpectedError,
          message: message ?? 'Unexpected error',
        );
    }
  }

  @override
  List<Object?> get props => [name, statusCode, exceptionType];
}
