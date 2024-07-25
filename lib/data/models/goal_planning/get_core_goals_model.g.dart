// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_core_goals_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCoreGoalsModel _$GetCoreGoalsModelFromJson(Map<String, dynamic> json) =>
    GetCoreGoalsModel(
      goalType: json['goalType'] as String,
      goals: (json['goals'] as List<dynamic>)
          .map((e) => Goal.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCoreGoalsModelToJson(GetCoreGoalsModel instance) =>
    <String, dynamic>{
      'goalType': instance.goalType,
      'goals': instance.goals,
    };

Goal _$GoalFromJson(Map<String, dynamic> json) => Goal(
      goalName: json['goalName'] as String,
      goalType: json['goalType'] as String,
      goalIcon: json['goalIcon'] as String?,
    );

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
      'goalName': instance.goalName,
      'goalType': instance.goalType,
      'goalIcon': instance.goalIcon,
    };
