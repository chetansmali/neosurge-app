// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_us_question_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactUsQuestionsModel _$ContactUsQuestionsModelFromJson(
        Map<String, dynamic> json) =>
    ContactUsQuestionsModel(
      id: json['id'] as String,
      category: json['category'] as String,
      question: json['question'] as String,
      answer: json['answer'] as String?,
      dislikes: json['dislikes'] as int?,
      likes: json['likes'] as int?,
      views: json['views'] as int?,
    );

Map<String, dynamic> _$ContactUsQuestionsModelToJson(
        ContactUsQuestionsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'question': instance.question,
      'answer': instance.answer,
      'dislikes': instance.dislikes,
      'likes': instance.likes,
      'views': instance.views,
    };
