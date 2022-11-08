// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    email: json['Email'] as String? ?? '',
    hasRegistered: json['HasRegistered'] as bool? ?? false,
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'Email': instance.email,
      'HasRegistered': instance.hasRegistered,
    };
