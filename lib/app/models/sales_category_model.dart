import 'package:json_annotation/json_annotation.dart';

part 'sales_category_model.g.dart';

@JsonSerializable()
class SalesCategory {
  SalesCategory({this.value = '', this.text = ''});

  factory SalesCategory.fromJson(dynamic json) => _$SalesCategoryFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$SalesCategoryToJson(this);

  @JsonKey(name: 'Value', defaultValue: '')
  String value;
  @JsonKey(name: 'Text', defaultValue: '')
  String text;
}
