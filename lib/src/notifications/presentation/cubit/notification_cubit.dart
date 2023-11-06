// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:tunceducationn/core/errors/failures.dart';
import 'package:tunceducationn/src/notifications/domain/entities/notification.dart';
import 'package:tunceducationn/src/notifications/domain/usecases/clear.dart';
import 'package:tunceducationn/src/notifications/domain/usecases/clear_all.dart';
import 'package:tunceducationn/src/notifications/domain/usecases/get_notifications.dart';
import 'package:tunceducationn/src/notifications/domain/usecases/mark_as_read.dart';
import 'package:tunceducationn/src/notifications/domain/usecases/send_notification.dart';
import 'package:equatable/equatable.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({
    required Clear clear,
    required ClearAll clearAll,
    required GetNotifications getNotifications,
    required MarkAsRead markAsRead,
    required SendNotification sendNotification,
  })  : _clear = clear,
        _clearAll = clearAll,
        _getNotifications = getNotifications,
        _markAsRead = markAsRead,
        _sendNotification = sendNotification,
        super(const NotificationInitial());

  final Clear _clear;
  final ClearAll _clearAll;
  final GetNotifications _getNotifications;
  final MarkAsRead _markAsRead;
  final SendNotification _sendNotification;
  StreamSubscription<Either<Failure, List<Notification>>>? subscription;

  Future<void> clear(String notificationId) async {
    emit(const ClearingNotifications());
    final result = await _clear(notificationId);
    result.fold(
      (failure) => emit(NotificationError(failure.errorMessage)),
      (_) => emit(const NotificationCleared()),
    );
  }

  Future<void> clearAll() async {
    emit(const ClearingNotifications());
    final result = await _clearAll();
    result.fold(
      (failure) => emit(NotificationError(failure.errorMessage)),
      (_) => emit(const NotificationCleared()),
    );
  }

  Future<void> markAsRead(String notificationId) async {
    final result = await _markAsRead(notificationId);
    result.fold(
      (failure) => emit(NotificationError(failure.errorMessage)),
      (_) {
        getNotifications();
        emit(const NotificationInitial());
      },
    );
  }

  Future<void> sendNotification(Notification notification) async {
    emit(const SendingNotification());
    final result = await _sendNotification(notification);
    result.fold(
      (failure) => emit(NotificationError(failure.errorMessage)),
      (_) => emit(const NotificationCleared()),
    );
  }

  // Future<void> sendNotification(Notification notification) async {
  //   emit(const SendingNotification());
  //   final result = await _sendNotification(notification);
  //   result.fold(
  //     (failure) => emit(NotificationError(failure.errorMessage)),
  //     (_) => emit(const NotificationCleared()),
  //   );
  // }

  // void getNotifications() {
  //   emit(const GettingNotifications());
  //   StreamSubscription<Either<Failure, List<Notification>>>? subscription;

  //   subscription = _getNotifications().listen(
  //     /*onData:*/
  //     (result) {
  //       result.fold(
  //         (failure) {
  //           emit(NotificationError(failure.errorMessage));
  //           subscription?.cancel();
  //         },
  //         (notifications) => emit(NotificationsLoaded(notifications)),
  //       );
  //     },
  //     onError: (dynamic error) {
  //       emit(NotificationError(error.toString()));
  //       subscription?.cancel();
  //     },
  //     onDone: () {
  //       subscription?.cancel();
  //     },
  //   );
  // }

  // void getNotifications() {
  //   emit(const GettingNotifications());

  //   subscription = _getNotifications().listen(
  //     (result) {
  //       result.fold(
  //         (failure) {
  //           emit(NotificationError(failure.errorMessage));
  //           // Hata durumunda subscription'ı iptal etmeyin.
  //         },
  //         (notifications) {
  //           emit(NotificationsLoaded(notifications));
  //           // Başarılı durumda subscription'ı iptal etmeyin.
  //         },
  //       );
  //     },
  //     onError: (dynamic error) {
  //       emit(NotificationError(error.toString()));
  //       // Hata durumunda subscription'ı iptal etmeyin.
  //     },
  //     onDone: () {
  //       // Yayın tamamlandığında subscription'ı iptal etmeyin.
  //     },
  //   );
  // }

  Future<void> getNotifications() async {
    emit(const GettingNotifications());

    subscription = _getNotifications().listen(
      (result) {
        result.fold(
          (failure) {
            final errorDetails =
                "Hata: ${failure.runtimeType.toString()} - ${failure.errorMessage}";
            emit(NotificationError(errorDetails));
            subscription?.cancel(); // Aboneliği iptal et
          },
          (notifications) {
            emit(NotificationsLoaded(notifications));
          },
        );
      },
      onError: (dynamic error) {
        final errorDetails = "Hata: ${error.toString()}";
        emit(NotificationError(errorDetails));
        subscription?.cancel(); // Hata durumunda da aboneliği iptal et
      },
      onDone: () {
        subscription?.cancel();
      },
    );
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
