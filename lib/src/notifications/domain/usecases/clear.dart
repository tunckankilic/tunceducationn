import 'package:tunceducationn/core/usecases/usecases.dart';
import 'package:tunceducationn/core/utils/utils.dart';
import 'package:tunceducationn/src/notifications/domain/repos/notification_repo.dart';

class Clear extends FutureUsecaseWithParams<void, String> {
  const Clear(this._repo);

  final NotificationRepo _repo;

  @override
  ResultFuture<void> call(String params) => _repo.clear(params);
}
