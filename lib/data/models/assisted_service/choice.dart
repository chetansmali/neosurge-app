import 'package:json_annotation/json_annotation.dart';

part 'choice.g.dart';

@JsonSerializable()
class Choice {
  final int id;
  final int choiceId;
  final String name;
  final int weight;
  final String? description;
  final String? choiceImgUrl;

  Choice({
    required this.id,
    required this.choiceId,
    required this.name,
    required this.weight,
    this.description,
    this.choiceImgUrl,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceToJson(this);
}
