import 'package:json_annotation/json_annotation.dart';

part 'articles_model.g.dart';

@JsonSerializable()
class ArticlesModel {
  ArticlesModel({
    this.id = 0,
    this.name = '',
    this.image = '',
    this.createdDate = '',
    this.creditAmount = 0,
    this.isVip = false,
    this.priceAmount = 0,
    this.quantity = 0,
    this.address = '',
    this.phoneNumber = '',
  });

  factory ArticlesModel.fromJson(dynamic json) => _$ArticlesModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$ArticlesModelToJson(this);

  @JsonKey(name: 'Name', defaultValue: '')
  String name;
  @JsonKey(name: 'CreatedDate', defaultValue: '')
  String createdDate;
  @JsonKey(name: 'ImagePath', defaultValue: '')
  String image;
  @JsonKey(name: 'Address', defaultValue: '')
  String address;
  @JsonKey(name: 'PhoneNumber', defaultValue: '')
  String phoneNumber;
  @JsonKey(name: 'IsVip', defaultValue: false)
  bool isVip;
  @JsonKey(name: 'Id', defaultValue: 0)
  int id;
  @JsonKey(name: 'Quantity', defaultValue: 0)
  int quantity;
  @JsonKey(name: 'PriceAmount', defaultValue: 0)
  int priceAmount;
  @JsonKey(name: 'CreditAmount', defaultValue: 0)
  int creditAmount;
}
