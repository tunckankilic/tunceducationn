import 'package:dartz/dartz.dart';
import 'package:tunceducationn/core/errors/errors.dart';
import 'package:tunceducationn/core/utils/typedefs.dart';
import 'package:tunceducationn/src/on_boarding/data/datasources/datasources.dart';
import 'package:tunceducationn/src/on_boarding/domain/domain.dart';

// An implementation of the OnBoardingRepo interface.
class OnBoardingRepoImplementation implements OnBoardingRepo {
  const OnBoardingRepoImplementation(this._localDataSource);
  final OnBoardingLocalDataSource _localDataSource;

  // Caches information about whether the user is a first-time user.
  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      // Call the local data source to cache the first-timer information.
      await _localDataSource.cacheFirstTimer();
      return const Right(null); // Operation completed successfully.
    } on CacheExceptions catch (e) {
      // Handle and convert cache-related exceptions to CacheFailure.
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  // Checks if the user is a first-time user.
  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
      // Call the local data source to check if the user is a first-time user.
      final result = await _localDataSource.checkIfUserIsFirstTimer();
      return Right(result); // Return the result as a success.
    } on CacheExceptions catch (e) {
      // Handle and convert cache-related exceptions to CacheFailure.
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
