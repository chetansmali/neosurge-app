// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Choice _$ChoiceFromJson(Map<String, dynamic> json) => Choice(
      id: json['id'] as int,
      choiceId: json['choiceId'] as int,
      name: json['name'] as String,
      weight: json['weight'] as int,
      description: json['description'] as String?,
      choiceImgUrl: json['choiceImgUrl'] as String?,
    );

Map<String, dynamic> _$ChoiceToJson(Choice instance) => <String, dynamic>{
      'id': instance.id,
      'choiceId': instance.choiceId,
      'name': instance.name,
      'weight': instance.weight,
      'description': instance.description,
      'choiceImgUrl': instance.choiceImgUrl,
    };
