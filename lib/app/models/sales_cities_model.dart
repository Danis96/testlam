import 'package:json_annotation/json_annotation.dart';

part 'sales_cities_model.g.dart';

@JsonSerializable()
class SalesCity {
  SalesCity({this.value = '', this.text = ''});

  factory SalesCity.fromJson(dynamic json) => _$SalesCityFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$SalesCityToJson(this);

  @JsonKey(name: 'Value', defaultValue: '')
  String value;
  @JsonKey(name: 'Text', defaultValue: '')
  String text;
}