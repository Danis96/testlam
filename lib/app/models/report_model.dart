import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportModel {
  ReportModel({
    this.merchantName = '',
    this.id = 0,
    this.year = 0,
    this.month = 0,
    this.additionalInfo = '',
    this.isDeleted = false,
    this.purchaseDate = '',
    this.purchaseDateFilter = '',
    this.salesAmount = 0,
    this.transactionMoneyAmount = 0,
    this.transactionPointsAmount = 0,
  });

  factory ReportModel.fromJson(dynamic json) => _$ReportModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);

  @JsonKey(name: 'PurchaseDate', defaultValue: '')
  String purchaseDate;
  @JsonKey(name: 'PurchaseDateFilter', defaultValue: '')
  String purchaseDateFilter;
  @JsonKey(name: 'MerchantName', defaultValue: '')
  String merchantName;
  @JsonKey(name: 'AdditionalInfo', defaultValue: '')
  String additionalInfo;
  @JsonKey(name: 'Id', defaultValue: 0)
  int id;
  @JsonKey(name: 'Month', defaultValue: 0)
  int month;
  @JsonKey(name: 'Year', defaultValue: 0)
  int year;
  @JsonKey(name: 'TransactionPointsAmount', defaultValue: 0)
  int transactionPointsAmount;
  @JsonKey(name: 'TransactionMoneyAmount', defaultValue: 0)
  double transactionMoneyAmount;
  @JsonKey(name: 'SalesAmount', defaultValue: 0)
  double salesAmount;
  @JsonKey(name: 'IsDeleted', defaultValue: false)
  bool isDeleted;
}
