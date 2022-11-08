import 'package:json_annotation/json_annotation.dart';

part 'recipient_info_model.g.dart';

@JsonSerializable()
class RecipientInfo {
  RecipientInfo({this.amount = 0, this.firstName = '', this.lastName = '', this.cardNo = ''});

  factory RecipientInfo.fromJson(dynamic json) => _$RecipientInfoFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$RecipientInfoToJson(this);

  @JsonKey(name: 'CardNo', defaultValue: '')
  String cardNo;
  @JsonKey(name: 'FirstName', defaultValue: '')
  String firstName;
  @JsonKey(name: 'LastName', defaultValue: '')
  String lastName;
  @JsonKey(name: 'Amount', defaultValue: 0)
  int amount;
}
