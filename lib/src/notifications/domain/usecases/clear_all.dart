import 'package:tunceducationn/core/usecases/usecases.dart';
import 'package:tunceducationn/core/utils/utils.dart';
import 'package:tunceducationn/src/notifications/domain/repos/notification_repo.dart';

class ClearAll extends FutureUsecaseWithoutParams<void> {
  const ClearAll(this._repo);

  final NotificationRepo _repo;

  @override
  ResultFuture<void> call() => _repo.clearAll();
}
