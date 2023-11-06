// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:tunceducationn/core/enums/notification_enum.dart';

class Notification extends Equatable {
  const Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    this.seen = false,
    required this.sentAt,
  });

  Notification.empty()
      : id = '_empty.id',
        title = '_empty.title',
        body = '_empty.body',
        category = NotificationCategory.NONE,
        seen = false,
        sentAt = DateTime.now();

  final String id;
  final String title;
  final String body;
  final NotificationCategory category;
  final bool seen;
  final DateTime sentAt;

  @override
  List<Object> get props {
    return [
      id,
      title,
      body,
      category,
      seen,
      sentAt,
    ];
  }

  Notification copyWith({
    String? id,
    String? title,
    String? body,
    NotificationCategory? category,
    bool? seen,
    DateTime? sentAt,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      category: category ?? this.category,
      seen: seen ?? this.seen,
      sentAt: sentAt ?? this.sentAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'category': category.toMap(),
      'seen': seen,
      'sentAt': sentAt.millisecondsSinceEpoch,
    };
  }

  @override
  bool get stringify => true;
}
