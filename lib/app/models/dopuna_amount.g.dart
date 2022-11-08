// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dopuna_amount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DopunaAmount _$DopunaAmountFromJson(Map<String, dynamic> json) {
  return DopunaAmount(
    value: json['Value'] as String? ?? '',
    text: json['Text'] as String? ?? '',
    disabled: json['Disabled'] as bool? ?? false,
    selected: json['Selected'] as bool? ?? false,
  );
}

Map<String, dynamic> _$DopunaAmountToJson(DopunaAmount instance) =>
    <String, dynamic>{
      'Text': instance.text,
      'Value': instance.value,
      'Disabled': instance.disabled,
      'Selected': instance.selected,
    };
