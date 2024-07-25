import 'package:json_annotation/json_annotation.dart';
part 'entity.g.dart';
@JsonSerializable()
class Entity {
  String newsUuid;
  String symbol;
  String industry;
  String name;
  double sentimentScore;
  String type;

  Entity({
    required this.newsUuid,
    required this.symbol,
    required this.industry,
    required this.name,
    required this.sentimentScore,
    required this.type,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => _$EntityFromJson(json);

  Map<String,dynamic>toJson()=>_$EntityToJson(this);
}
