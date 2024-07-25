import 'package:json_annotation/json_annotation.dart';

part 'contact_us_question_response.g.dart';

@JsonSerializable()
class ContactUsQuestionsModel {
  String id;
  String category;
  String question;
  String? answer;
  int? dislikes;
  int? likes;
  int? views;

  ContactUsQuestionsModel({
    required this.id,
    required this.category,
    required this.question,
    this.answer,
    this.dislikes,
    this.likes,
    this.views,
  });

  factory ContactUsQuestionsModel.fromJson(Map<String, dynamic> json) =>
      _$ContactUsQuestionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactUsQuestionsModelToJson(this);
}
