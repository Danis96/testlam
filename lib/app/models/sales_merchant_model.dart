import 'package:json_annotation/json_annotation.dart';

part 'sales_merchant_model.g.dart';

@JsonSerializable()
class SalesMerchant {
  SalesMerchant({
    this.city = '',
    this.image = '',
    this.borderLimitAmount = 0,
    this.categoryId = '',
    this.categoryName = '',
    this.endLoyaltyPoints = 0,
    this.isTopMerchant = false,
    this.merchantID = 0,
    this.merchantName = '',
    this.startLoyaltyPoints = 0,
    this.turnedOn = 0,
    this.additionalInfo = '',
    this.moneyOnFullLoyalty = 0,
    this.moneyOnLowLoyalty = 0,
    this.moneyToFullLoyalty = 0,
  });

  factory SalesMerchant.fromJson(dynamic json) => _$SalesMerchantFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$SalesMerchantToJson(this);

  @JsonKey(name: 'MerchantId', defaultValue: 0)
  int merchantID;
  @JsonKey(name: 'MerchantName', defaultValue: '')
  String merchantName;
  @JsonKey(name: 'CategoryId', defaultValue: '')
  String categoryId;
  @JsonKey(name: 'CategoryName', defaultValue: '')
  String categoryName;
  @JsonKey(name: 'City', defaultValue: '')
  String city;
  @JsonKey(name: 'ImagePath', defaultValue: '')
  String image;
  @JsonKey(name: 'AdditionalInfo', defaultValue: '')
  String additionalInfo;
  @JsonKey(name: 'StartLoyaltyPoints', defaultValue: 0)
  int startLoyaltyPoints;
  @JsonKey(name: 'EndLoyaltyPoints', defaultValue: 0)
  int endLoyaltyPoints;
  @JsonKey(name: 'BorderLimitAmount', defaultValue: 0.0)
  double borderLimitAmount;
  @JsonKey(name: 'MoneyOnLowLoyalty', defaultValue: 0.0)
  double moneyOnLowLoyalty;
  @JsonKey(name: 'MoneyOnFullLoyalty', defaultValue: 0.0)
  double moneyOnFullLoyalty;
  @JsonKey(name: 'MoneyToFullLoyalty', defaultValue: 0.0)
  double moneyToFullLoyalty;
  @JsonKey(name: 'TurnedOn', defaultValue: 0)
  int turnedOn;
  @JsonKey(name: 'IsTopMerchant', defaultValue: false)
  bool isTopMerchant;
}
