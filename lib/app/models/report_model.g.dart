// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) {
  return ReportModel(
    merchantName: json['MerchantName'] as String? ?? '',
    id: json['Id'] as int? ?? 0,
    year: json['Year'] as int? ?? 0,
    month: json['Month'] as int? ?? 0,
    additionalInfo: json['AdditionalInfo'] as String? ?? '',
    isDeleted: json['IsDeleted'] as bool? ?? false,
    purchaseDate: json['PurchaseDate'] as String? ?? '',
    purchaseDateFilter: json['PurchaseDateFilter'] as String? ?? '',
    salesAmount: (json['SalesAmount'] as num?)?.toDouble() ?? 0,
    transactionMoneyAmount:
        (json['TransactionMoneyAmount'] as num?)?.toDouble() ?? 0,
    transactionPointsAmount: json['TransactionPointsAmount'] as int? ?? 0,
  );
}

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'PurchaseDate': instance.purchaseDate,
      'PurchaseDateFilter': instance.purchaseDateFilter,
      'MerchantName': instance.merchantName,
      'AdditionalInfo': instance.additionalInfo,
      'Id': instance.id,
      'Month': instance.month,
      'Year': instance.year,
      'TransactionPointsAmount': instance.transactionPointsAmount,
      'TransactionMoneyAmount': instance.transactionMoneyAmount,
      'SalesAmount': instance.salesAmount,
      'IsDeleted': instance.isDeleted,
    };
