import 'package:tunceducationn/core/usecases/usecases.dart';
import 'package:tunceducationn/core/utils/typedefs.dart';
import 'package:tunceducationn/src/notifications/domain/entities/notification.dart';
import 'package:tunceducationn/src/notifications/domain/repos/notification_repo.dart';

class SendNotification extends FutureUsecaseWithParams<void, Notification> {
  const SendNotification(this._repo);

  final NotificationRepo _repo;

  @override
  ResultFuture<void> call(Notification params) =>
      _repo.sendNotification(params);
}
