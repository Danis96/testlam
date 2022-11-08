import 'package:json_annotation/json_annotation.dart';

part 'user_main_info.g.dart';

@JsonSerializable()
class UserMainInfo {
  UserMainInfo({
    this.lastName = '',
    this.firstName = '',
    this.cardNumber = '',
    this.profileImg = '',
    this.reservedAwardName = '',
    this.reservedAwardPath = '',
    this.reservedAwardProgressForm = 0,
    this.reservedAwardProgressTo = 0,
    this.totalMoneyAmount = 0,
    this.totalPointsAmount = 0,
  });

  factory UserMainInfo.fromJson(dynamic json) => _$UserMainInfoFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$UserMainInfoToJson(this);

  @JsonKey(name: 'CardNo', defaultValue: '')
  String cardNumber;
  @JsonKey(name: 'FirstName', defaultValue: '')
  String firstName;
  @JsonKey(name: 'LastName', defaultValue: '')
  String lastName;
  @JsonKey(name: 'TotalMoneyAmount', defaultValue: 0.0)
  double totalMoneyAmount;
  @JsonKey(name: 'TotalPointsAmount', defaultValue: 0)
  int totalPointsAmount;
  @JsonKey(name: 'ReservedAwardName', defaultValue: '')
  String reservedAwardName;
  @JsonKey(name: 'ReservedAwardPath', defaultValue: '')
  String reservedAwardPath;
  @JsonKey(name: 'ProfileImagePath', defaultValue: '')
  String profileImg;
  @JsonKey(name: 'ReservedAwardProgressFrom', defaultValue: 0)
  int reservedAwardProgressForm;
  @JsonKey(name: 'ReservedAwardProgressTo', defaultValue: 0)
  int reservedAwardProgressTo;

  String get fullName => '$firstName $lastName';
}
