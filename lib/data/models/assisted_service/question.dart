import 'package:json_annotation/json_annotation.dart';

import 'choice.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  final int quizeId;
  final String question;
  final List<Choice> choices;

  Question({
    required this.quizeId,
    required this.question,
    required this.choices,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
