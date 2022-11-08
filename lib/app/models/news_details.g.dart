// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsDetailsModel _$NewsDetailsModelFromJson(Map<String, dynamic> json) {
  return NewsDetailsModel(
    id: json['Id'] as int? ?? 0,
    image:
        (json['Images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
            [],
    createdDate: json['CreatedDate'] as String? ?? '',
    body: json['Body'] as String? ?? '',
    subject: json['Subject'] as String? ?? '',
  );
}

Map<String, dynamic> _$NewsDetailsModelToJson(NewsDetailsModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Subject': instance.subject,
      'Body': instance.body,
      'Images': instance.image,
      'CreatedDate': instance.createdDate,
    };
