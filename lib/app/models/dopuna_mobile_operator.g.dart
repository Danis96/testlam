// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dopuna_mobile_operator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MobileOperator _$MobileOperatorFromJson(Map<String, dynamic> json) {
  return MobileOperator(
    value: json['Value'] as String? ?? '',
    text: json['Text'] as String? ?? '',
    disabled: json['Disabled'] as bool? ?? false,
    selected: json['Selected'] as bool? ?? false,
  );
}

Map<String, dynamic> _$MobileOperatorToJson(MobileOperator instance) =>
    <String, dynamic>{
      'Text': instance.text,
      'Value': instance.value,
      'Disabled': instance.disabled,
      'Selected': instance.selected,
    };
