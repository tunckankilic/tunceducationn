import 'package:tunceducationn/core/utils/utils.dart';

// An abstract repository interface for OnBoarding feature.
abstract class OnBoardingRepo {
  // Caches information about whether the user is a first-time user.
  ResultFuture<void> cacheFirstTimer();

  // Checks if the user is a first-time user.
  ResultFuture<bool> checkIfUserIsFirstTimer();
}
