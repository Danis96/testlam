// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenModel _$TokenModelFromJson(Map<String, dynamic> json) {
  return TokenModel(
    accessToken: json['access_token'] as String? ?? '',
    expiresIn: json['expires_in'] as int? ?? 0,
    tokenType: json['token_type'] as String? ?? '',
    userName: json['userName'] as String? ?? '',
    expires: json['.expires'] as String? ?? '',
    issued: json['.issued'] as String? ?? '',
  );
}

Map<String, dynamic> _$TokenModelToJson(TokenModel instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'userName': instance.userName,
      '.issued': instance.issued,
      '.expires': instance.expires,
    };
