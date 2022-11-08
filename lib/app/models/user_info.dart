import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  UserInfo({this.email = '', this.hasRegistered = false});

  factory UserInfo.fromJson(dynamic json) => _$UserInfoFromJson(json as Map<String, dynamic>);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  @JsonKey(name: 'Email', defaultValue: '')
  String email;
  @JsonKey(name: 'HasRegistered', defaultValue: false)
  bool hasRegistered;

}