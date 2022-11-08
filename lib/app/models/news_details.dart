import 'package:json_annotation/json_annotation.dart';

part 'news_details.g.dart';

@JsonSerializable()
class NewsDetailsModel {
  NewsDetailsModel({this.id = 0, this.image = const <String>[], this.createdDate = '', this.body = '', this.subject = ''});

  factory NewsDetailsModel.fromJson(dynamic json) => _$NewsDetailsModelFromJson(json as Map<String, dynamic>);
  Map<String, dynamic> toJson() => _$NewsDetailsModelToJson(this);

  @JsonKey(name: 'Id', defaultValue: 0)
  int id;
  @JsonKey(name: 'Subject', defaultValue: '')
  String subject;
  @JsonKey(name: 'Body', defaultValue: '')
  String body;
  @JsonKey(name: 'Images', defaultValue: <String>[])
  List<String> image;
  @JsonKey(name: 'CreatedDate', defaultValue: '')
  String createdDate;
}
