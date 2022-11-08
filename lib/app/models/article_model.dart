import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  ArticleModel({
    this.id = 0,
    this.name = '',
    this.image = const <String>[],
    this.createdDate = '',
    this.creditAmount = 0,
    this.isVip = false,
    this.priceAmount = 0,
    this.quantity = 0,
    this.address = '',
    this.phoneNumber = '',
  });

  factory ArticleModel.fromJson(dynamic json) => _$ArticleModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  @JsonKey(name: 'Name', defaultValue: '')
  String name;
  @JsonKey(name: 'CreatedDate', defaultValue: '')
  String createdDate;
  @JsonKey(name: 'Images', defaultValue: <String>[])
  List<String> image;
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
