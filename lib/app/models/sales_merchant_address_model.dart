import 'package:json_annotation/json_annotation.dart';

part 'sales_merchant_address_model.g.dart';

@JsonSerializable()
class SalesMerchantAddress {
  SalesMerchantAddress({
    this.city = '',
    this.id = 0,
    this.address = '',
    this.isLampicaSalesLocation = false,
  });

  factory SalesMerchantAddress.fromJson(dynamic json) => _$SalesMerchantAddressFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$SalesMerchantAddressToJson(this);

  @JsonKey(name: 'Id', defaultValue: 0)
  int id;
  @JsonKey(name: 'City', defaultValue: '')
  String city;
  @JsonKey(name: 'Address', defaultValue: '')
  String address;
  @JsonKey(name: 'IsLampicaSalesLocation', defaultValue: false)
  bool isLampicaSalesLocation;
}
