// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_cities_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesCity _$SalesCityFromJson(Map<String, dynamic> json) {
  return SalesCity(
    value: json['Value'] as String? ?? '',
    text: json['Text'] as String? ?? '',
  );
}

Map<String, dynamic> _$SalesCityToJson(SalesCity instance) => <String, dynamic>{
      'Value': instance.value,
      'Text': instance.text,
    };
