// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoCodeModel _$PromoCodeModelFromJson(Map<String, dynamic> json) {
  return PromoCodeModel(
    articleCode: json['ArticleCode'] as String? ?? '',
    status: json['Status'] as int? ?? 0,
    cardNo: json['CardNo'] as int? ?? 0,
    remainingAttempts: json['RemainingAttempts'] as int? ?? 0,
  );
}

Map<String, dynamic> _$PromoCodeModelToJson(PromoCodeModel instance) =>
    <String, dynamic>{
      'CardNo': instance.cardNo,
      'ArticleCode': instance.articleCode,
      'Status': instance.status,
      'RemainingAttempts': instance.remainingAttempts,
    };
