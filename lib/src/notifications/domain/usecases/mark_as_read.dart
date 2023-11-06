import 'package:tunceducationn/core/usecases/usecases.dart';
import 'package:tunceducationn/core/utils/typedefs.dart';
import 'package:tunceducationn/src/notifications/domain/repos/notification_repo.dart';

class MarkAsRead extends FutureUsecaseWithParams<void, String> {
  const MarkAsRead(this._repo);

  final NotificationRepo _repo;

  @override
  ResultFuture<void> call(String params) => _repo.markAsRead(params);
}
