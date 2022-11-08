// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_main_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMainInfo _$UserMainInfoFromJson(Map<String, dynamic> json) {
  return UserMainInfo(
    lastName: json['LastName'] as String? ?? '',
    firstName: json['FirstName'] as String? ?? '',
    cardNumber: json['CardNo'] as String? ?? '',
    profileImg: json['ProfileImagePath'] as String? ?? '',
    reservedAwardName: json['ReservedAwardName'] as String? ?? '',
    reservedAwardPath: json['ReservedAwardPath'] as String? ?? '',
    reservedAwardProgressForm: json['ReservedAwardProgressFrom'] as int? ?? 0,
    reservedAwardProgressTo: json['ReservedAwardProgressTo'] as int? ?? 0,
    totalMoneyAmount: (json['TotalMoneyAmount'] as num?)?.toDouble() ?? 0.0,
    totalPointsAmount: json['TotalPointsAmount'] as int? ?? 0,
  );
}

Map<String, dynamic> _$UserMainInfoToJson(UserMainInfo instance) =>
    <String, dynamic>{
      'CardNo': instance.cardNumber,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'TotalMoneyAmount': instance.totalMoneyAmount,
      'TotalPointsAmount': instance.totalPointsAmount,
      'ReservedAwardName': instance.reservedAwardName,
      'ReservedAwardPath': instance.reservedAwardPath,
      'ProfileImagePath': instance.profileImg,
      'ReservedAwardProgressFrom': instance.reservedAwardProgressForm,
      'ReservedAwardProgressTo': instance.reservedAwardProgressTo,
    };
