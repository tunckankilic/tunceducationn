import 'package:dartz/dartz.dart';
import 'package:tunceducationn/core/errors/errors.dart';

// A custom type alias for asynchronous operations that return an Either with a Failure or a specific type T.
typedef ResultFuture<T> = Future<Either<Failure, T>>;

// A custom type alias for a map of key-value pairs where keys are strings and values are dynamic.
typedef DataMap = Map<String, dynamic>;

typedef ResultStream<T> = Stream<Either<Failure, T>>;
