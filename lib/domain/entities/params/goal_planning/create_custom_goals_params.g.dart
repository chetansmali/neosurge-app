// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_custom_goals_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCustomGoalsParams _$CreateCustomGoalsParamsFromJson(
        Map<String, dynamic> json) =>
    CreateCustomGoalsParams(
      goalName: json['goalName'] as String,
      targetedGoalDate: json['targetedGoalDate'] as String,
      goalType: json['goalType'] as String,
      targetGoalAmount: (json['targetGoalAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$CreateCustomGoalsParamsToJson(
        CreateCustomGoalsParams instance) =>
    <String, dynamic>{
      'goalName': instance.goalName,
      'targetedGoalDate': instance.targetedGoalDate,
      'goalType': instance.goalType,
      'targetGoalAmount': instance.targetGoalAmount,
    };
