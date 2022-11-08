// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticlesModel _$ArticlesModelFromJson(Map<String, dynamic> json) {
  return ArticlesModel(
    id: json['Id'] as int? ?? 0,
    name: json['Name'] as String? ?? '',
    image: json['ImagePath'] as String? ?? '',
    createdDate: json['CreatedDate'] as String? ?? '',
    creditAmount: json['CreditAmount'] as int? ?? 0,
    isVip: json['IsVip'] as bool? ?? false,
    priceAmount: json['PriceAmount'] as int? ?? 0,
    quantity: json['Quantity'] as int? ?? 0,
    address: json['Address'] as String? ?? '',
    phoneNumber: json['PhoneNumber'] as String? ?? '',
  );
}

Map<String, dynamic> _$ArticlesModelToJson(ArticlesModel instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'CreatedDate': instance.createdDate,
      'ImagePath': instance.image,
      'Address': instance.address,
      'PhoneNumber': instance.phoneNumber,
      'IsVip': instance.isVip,
      'Id': instance.id,
      'Quantity': instance.quantity,
      'PriceAmount': instance.priceAmount,
      'CreditAmount': instance.creditAmount,
    };
