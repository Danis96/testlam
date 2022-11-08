// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_merchant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesMerchant _$SalesMerchantFromJson(Map<String, dynamic> json) {
  return SalesMerchant(
    city: json['City'] as String? ?? '',
    image: json['ImagePath'] as String? ?? '',
    borderLimitAmount: (json['BorderLimitAmount'] as num?)?.toDouble() ?? 0.0,
    categoryId: json['CategoryId'] as String? ?? '',
    categoryName: json['CategoryName'] as String? ?? '',
    endLoyaltyPoints: json['EndLoyaltyPoints'] as int? ?? 0,
    isTopMerchant: json['IsTopMerchant'] as bool? ?? false,
    merchantID: json['MerchantId'] as int? ?? 0,
    merchantName: json['MerchantName'] as String? ?? '',
    startLoyaltyPoints: json['StartLoyaltyPoints'] as int? ?? 0,
    turnedOn: json['TurnedOn'] as int? ?? 0,
    additionalInfo: json['AdditionalInfo'] as String? ?? '',
    moneyOnFullLoyalty: (json['MoneyOnFullLoyalty'] as num?)?.toDouble() ?? 0.0,
    moneyOnLowLoyalty: (json['MoneyOnLowLoyalty'] as num?)?.toDouble() ?? 0.0,
    moneyToFullLoyalty: (json['MoneyToFullLoyalty'] as num?)?.toDouble() ?? 0.0,
  );
}

Map<String, dynamic> _$SalesMerchantToJson(SalesMerchant instance) =>
    <String, dynamic>{
      'MerchantId': instance.merchantID,
      'MerchantName': instance.merchantName,
      'CategoryId': instance.categoryId,
      'CategoryName': instance.categoryName,
      'City': instance.city,
      'ImagePath': instance.image,
      'AdditionalInfo': instance.additionalInfo,
      'StartLoyaltyPoints': instance.startLoyaltyPoints,
      'EndLoyaltyPoints': instance.endLoyaltyPoints,
      'BorderLimitAmount': instance.borderLimitAmount,
      'MoneyOnLowLoyalty': instance.moneyOnLowLoyalty,
      'MoneyOnFullLoyalty': instance.moneyOnFullLoyalty,
      'MoneyToFullLoyalty': instance.moneyToFullLoyalty,
      'TurnedOn': instance.turnedOn,
      'IsTopMerchant': instance.isTopMerchant,
    };
