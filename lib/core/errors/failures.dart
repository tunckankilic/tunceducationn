// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:tunceducationn/core/errors/errors.dart';

// An abstract failure class to represent various types of failures.
abstract class Failure extends Equatable {
  final String message; // A descriptive error message.
  final dynamic statusCode; // The status code associated with the error.

  String get errorMessage =>
      "$statusCode${statusCode is String ? "" : "Error"} : $message";

  @override
  List<dynamic> get props => [message, statusCode];

  Failure({
    required this.message,
    required this.statusCode,
  }) : assert(statusCode is int || statusCode is String,
            "StatusCode cannot be a ${statusCode.runtimeType}");
}

// A specific failure class to represent cache-related errors.
class CacheFailure extends Failure {
  CacheFailure({required super.message, required super.statusCode});
}

// A specific failure class to represent server-related errors.
class ServerFailure extends Failure {
  ServerFailure({required super.message, required super.statusCode});

  // Construct a ServerFailure from a ServerException for easy error handling.
  ServerFailure.fromException(ServerException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
