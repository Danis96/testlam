import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsModel {
  NewsModel({this.id = 0, this.image = '', this.createdDate = '', this.intro = '', this.subject = ''});

  factory NewsModel.fromJson(dynamic json) => _$NewsModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);

  @JsonKey(name: 'Id', defaultValue: 0)
  int id;
  @JsonKey(name: 'Subject', defaultValue: '')
  String subject;
  @JsonKey(name: 'Intro', defaultValue: '')
  String intro;
  @JsonKey(name: 'ImagePath', defaultValue: '')
  String image;
  @JsonKey(name: 'CreatedDate', defaultValue: '')
  String createdDate;

  final DateFormat _format = DateFormat('dd.MM.yyyy.');
  String get formattedDate {
    final DateTime date = DateTime.parse(createdDate);
    if (createdDate.isNotEmpty) {
      return _format.format(date);
    } else {
      return '';
    }
  }
}
