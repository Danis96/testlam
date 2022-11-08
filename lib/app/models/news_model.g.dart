// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) {
  return NewsModel(
    id: json['Id'] as int? ?? 0,
    image: json['ImagePath'] as String? ?? '',
    createdDate: json['CreatedDate'] as String? ?? '',
    intro: json['Intro'] as String? ?? '',
    subject: json['Subject'] as String? ?? '',
  );
}

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'Id': instance.id,
      'Subject': instance.subject,
      'Intro': instance.intro,
      'ImagePath': instance.image,
      'CreatedDate': instance.createdDate,
    };
