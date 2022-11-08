// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipient_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipientInfo _$RecipientInfoFromJson(Map<String, dynamic> json) {
  return RecipientInfo(
    amount: json['Amount'] as int? ?? 0,
    firstName: json['FirstName'] as String? ?? '',
    lastName: json['LastName'] as String? ?? '',
    cardNo: json['CardNo'] as String? ?? '',
  );
}

Map<String, dynamic> _$RecipientInfoToJson(RecipientInfo instance) =>
    <String, dynamic>{
      'CardNo': instance.cardNo,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'Amount': instance.amount,
    };
