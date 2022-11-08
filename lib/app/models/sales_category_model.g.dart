// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesCategory _$SalesCategoryFromJson(Map<String, dynamic> json) {
  return SalesCategory(
    value: json['Value'] as String? ?? '',
    text: json['Text'] as String? ?? '',
  );
}

Map<String, dynamic> _$SalesCategoryToJson(SalesCategory instance) =>
    <String, dynamic>{
      'Value': instance.value,
      'Text': instance.text,
    };
