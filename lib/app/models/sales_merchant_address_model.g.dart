// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_merchant_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesMerchantAddress _$SalesMerchantAddressFromJson(Map<String, dynamic> json) {
  return SalesMerchantAddress(
    city: json['City'] as String? ?? '',
    id: json['Id'] as int? ?? 0,
    address: json['Address'] as String? ?? '',
    isLampicaSalesLocation: json['IsLampicaSalesLocation'] as bool? ?? false,
  );
}

Map<String, dynamic> _$SalesMerchantAddressToJson(
        SalesMerchantAddress instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'City': instance.city,
      'Address': instance.address,
      'IsLampicaSalesLocation': instance.isLampicaSalesLocation,
    };
