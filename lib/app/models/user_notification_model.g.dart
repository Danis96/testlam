// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNotification _$UserNotificationFromJson(Map<String, dynamic> json) {
  return UserNotification(
    description: json['Description'] as String? ?? '',
    cardId: json['CardId'] as int? ?? 0,
    dateSent: json['DateSent'] as String? ?? '',
    isRead: json['IsRead'] as bool? ?? false,
    notificationId: json['NotificationId'] as int? ?? 0,
    notificationTitle: json['NotificationTitle'] as String? ?? '',
    amount: json['Amount'] as int? ?? 0,
  );
}

Map<String, dynamic> _$UserNotificationToJson(UserNotification instance) =>
    <String, dynamic>{
      'NotificationId': instance.notificationId,
      'CardId': instance.cardId,
      'Amount': instance.amount,
      'NotificationTitle': instance.notificationTitle,
      'Description': instance.description,
      'DateSent': instance.dateSent,
      'IsRead': instance.isRead,
    };
