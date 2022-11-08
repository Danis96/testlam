import 'package:json_annotation/json_annotation.dart';

part 'token_model.g.dart';

@JsonSerializable()
class TokenModel {
  TokenModel({this.accessToken = '', this.expiresIn = 0, this.tokenType = '', this.userName = '', this.expires = '', this.issued = ''});

  factory TokenModel.fromJson(dynamic json) => _$TokenModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$TokenModelToJson(this);

  @JsonKey(name: 'access_token', defaultValue: '')
  String accessToken;
  @JsonKey(name: 'token_type', defaultValue: '')
  String tokenType;
  @JsonKey(name: 'expires_in', defaultValue: 0)
  int expiresIn;
  @JsonKey(name: 'userName', defaultValue: '')
  String userName;
  @JsonKey(name: '.issued', defaultValue: '')
  String issued;
  @JsonKey(name: '.expires', defaultValue: '')
  String expires;
}
