import 'package:json_annotation/json_annotation.dart';

part 'promo_code_model.g.dart';

@JsonSerializable()
class PromoCodeModel {
  PromoCodeModel({this.articleCode = '', this.status = 0, this.cardNo = 0, this.remainingAttempts = 0});

  factory PromoCodeModel.fromJson(dynamic json) => _$PromoCodeModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$PromoCodeModelToJson(this);

  @JsonKey(name: 'CardNo', defaultValue: 0)
  int cardNo;
  @JsonKey(name: 'ArticleCode', defaultValue: '')
  String articleCode;
  @JsonKey(name: 'Status', defaultValue: 0)
  int status;
  @JsonKey(name: 'RemainingAttempts', defaultValue: 0)
  int remainingAttempts;
}
