import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:tunceducationn/core/errors/errors.dart';
import 'package:tunceducationn/core/utils/utils.dart';

import 'package:tunceducationn/src/notifications/data/datasources/notification_remote_data_src.dart';
import 'package:tunceducationn/src/notifications/data/models/notification_model.dart';
import 'package:tunceducationn/src/notifications/domain/entities/notification.dart';
import 'package:tunceducationn/src/notifications/domain/repos/notification_repo.dart';
import 'package:flutter/foundation.dart';

class NotificationRepoImpl implements NotificationRepo {
  const NotificationRepoImpl(this._remoteDataSrc);

  final NotificationRemoteDataSrc _remoteDataSrc;

  @override
  ResultFuture<void> clear(String notificationId) async {
    try {
      await _remoteDataSrc.clear(notificationId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> clearAll() async {
    try {
      await _remoteDataSrc.clearAll();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultStream<List<Notification>> getNotifications() {
    return _remoteDataSrc.getNotifications().transform(
          StreamTransformer<List<NotificationModel>,
              Either<Failure, List<Notification>>>.fromHandlers(
            handleData: (notifications, sink) {
              sink.add(Right(notifications));
            },
            handleError: (error, stackTrace, sink) {
              debugPrint(stackTrace.toString());
              if (error is ServerException) {
                sink.add(Left(ServerFailure.fromException(error)));
              } else {
                sink.add(
                  Left(
                    ServerFailure(message: error.toString(), statusCode: 505),
                  ),
                );
              }
            },
          ),
        );
  }

  @override
  ResultFuture<void> markAsRead(String notificationId) async {
    try {
      await _remoteDataSrc.markAsRead(notificationId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> sendNotification(Notification notification) async {
    try {
      await _remoteDataSrc.sendNotification(notification);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
