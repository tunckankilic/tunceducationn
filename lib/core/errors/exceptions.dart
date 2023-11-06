// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// Custom exception class to represent server-related errors.
class ServerException extends Equatable implements Exception {
  final String message; // A descriptive error message.
  final String statusCode; // The HTTP status code associated with the error.

  const ServerException({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object> get props => [message, statusCode];
}

// Custom exception class to represent cache-related errors.
class CacheExceptions extends Equatable implements Exception {
  final String message; // A descriptive error message.
  final int
      statusCode; // A custom status code for cache-related errors, default is 500.

  const CacheExceptions({
    required this.message,
    this.statusCode = 500,
  });

  @override
  List<dynamic> get props => [message, statusCode];
}
