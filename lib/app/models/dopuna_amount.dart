

import 'package:json_annotation/json_annotation.dart';

part 'dopuna_amount.g.dart';

@JsonSerializable()
class DopunaAmount {
  DopunaAmount({this.value = '', this.text = '', this.disabled = false, this.selected = false});

  factory DopunaAmount.fromJson(dynamic json) => _$DopunaAmountFromJson(json as Map<String, dynamic>);
  Map<String, dynamic> toJson() => _$DopunaAmountToJson(this);

  @JsonKey(name: 'Text', defaultValue: '')
  String text;
  @JsonKey(name: 'Value', defaultValue: '')
  String value;
  @JsonKey(name: 'Disabled', defaultValue: false)
  bool disabled;
  @JsonKey(name: 'Selected', defaultValue: false)
  bool selected;
}
