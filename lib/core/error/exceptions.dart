/// Base class for all application exceptions
abstract class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const AppException(this.message, [this.stackTrace]);

  @override
  String toString() => message;
}

/// Thrown when there's an error from the server
class ServerException extends AppException {
  final int? statusCode;
  final dynamic data;

  ServerException({
    String message = 'Server error occurred',
    this.statusCode,
    this.data,
    StackTrace? stackTrace,
  }) : super(message, stackTrace);

  @override
  String toString() => 'ServerException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

/// Thrown when there's a cache-related error
class CacheException extends AppException {
  CacheException({
    String message = 'Cache error occurred',
    StackTrace? stackTrace,
  }) : super(message, stackTrace);
}

/// Thrown when there's a network connectivity issue
class NetworkException extends AppException {
  NetworkException({
    String message = 'No internet connection',
    StackTrace? stackTrace,
  }) : super(message, stackTrace);
}

/// Thrown when there's an error parsing data
class ParseException extends AppException {
  final dynamic data;

  ParseException({
    String message = 'Error parsing data',
    this.data,
    StackTrace? stackTrace,
  }) : super(message, stackTrace);

  @override
  String toString() => 'ParseException: $message\nData: $data';
}
