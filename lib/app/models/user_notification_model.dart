import 'package:json_annotation/json_annotation.dart';

part 'user_notification_model.g.dart';

@JsonSerializable()
class UserNotification {
  UserNotification({
    this.description = '',
    this.cardId = 0,
    this.dateSent = '',
    this.isRead = false,
    this.notificationId = 0,
    this.notificationTitle = '',
    this.amount = 0,
  });

  factory UserNotification.fromJson(dynamic json) => _$UserNotificationFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$UserNotificationToJson(this);

  @JsonKey(name: 'NotificationId', defaultValue: 0)
  int notificationId;
  @JsonKey(name: 'CardId', defaultValue: 0)
  int cardId;
  @JsonKey(name: 'Amount', defaultValue: 0)
  int amount;
  @JsonKey(name: 'NotificationTitle', defaultValue: '')
  String notificationTitle;
  @JsonKey(name: 'Description', defaultValue: '')
  String description;
  @JsonKey(name: 'DateSent', defaultValue: '')
  String dateSent;
  @JsonKey(name: 'IsRead', defaultValue: false)
  bool isRead;
}
