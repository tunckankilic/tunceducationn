import 'package:tunceducationn/core/utils/utils.dart';

// // An abstract base class for use cases with parameters.
// abstract class UsecaseWithParams<Type, Params> {
//   const UsecaseWithParams();

//   // The method to be implemented by concrete use cases with parameters.
//   ResultFuture<Type> call(Params params);
// }

// // An abstract base class for use cases without parameters.
// abstract class UsecaseWithoutParams<Type> {
//   const UsecaseWithoutParams();

//   // The method to be implemented by concrete use cases without parameters.
//   ResultFuture<Type> call();
// }

abstract class FutureUsecaseWithParams<Type, Params> {
  const FutureUsecaseWithParams();

  ResultFuture<Type> call(Params params);
}

abstract class FutureUsecaseWithoutParams<Type> {
  const FutureUsecaseWithoutParams();

  ResultFuture<Type> call();
}

abstract class StreamUsecaseWithoutParams<Type> {
  const StreamUsecaseWithoutParams();

  ResultStream<Type> call();
}

abstract class StreamUsecaseWithParams<Type, Params> {
  const StreamUsecaseWithParams();

  ResultStream<Type> call(Params params);
}
