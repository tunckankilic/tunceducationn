import 'package:tunceducationn/core/utils/typedefs.dart';
import 'package:tunceducationn/src/notifications/domain/entities/notification.dart';

abstract class NotificationRepo {
  const NotificationRepo();

  ResultFuture<void> markAsRead(String notificationId);

  ResultFuture<void> clearAll();

  ResultFuture<void> clear(String notificationId);

  ResultFuture<void> sendNotification(Notification notification);

  ResultStream<List<Notification>> getNotifications();
}
