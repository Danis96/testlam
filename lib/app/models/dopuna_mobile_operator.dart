

import 'package:json_annotation/json_annotation.dart';

part 'dopuna_mobile_operator.g.dart';

@JsonSerializable()
class MobileOperator {
  MobileOperator({this.value = '', this.text = '', this.disabled = false, this.selected = false});

  factory MobileOperator.fromJson(dynamic json) => _$MobileOperatorFromJson(json as Map<String, dynamic>);
  Map<String, dynamic> toJson() => _$MobileOperatorToJson(this);

  @JsonKey(name: 'Text', defaultValue: '')
  String text;
  @JsonKey(name: 'Value', defaultValue: '')
  String value;
  @JsonKey(name: 'Disabled', defaultValue: false)
  bool disabled;
  @JsonKey(name: 'Selected', defaultValue: false)
  bool selected;
}
