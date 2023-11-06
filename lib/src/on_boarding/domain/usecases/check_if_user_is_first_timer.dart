import 'package:tunceducationn/core/usecases/usecases.dart';
import 'package:tunceducationn/core/utils/utils.dart';
import 'package:tunceducationn/src/on_boarding/domain/repositories/on_boarding_repo.dart';

// A use case to check if the user is a first-time user.
class CheckIfUserIsFirstTimer extends FutureUsecaseWithoutParams<bool> {
  const CheckIfUserIsFirstTimer(this._repo);
  final OnBoardingRepo _repo;

  @override
  ResultFuture<bool> call() => _repo.checkIfUserIsFirstTimer();
}
