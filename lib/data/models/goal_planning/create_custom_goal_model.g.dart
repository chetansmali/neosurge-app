// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_custom_goal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCustomGoalModel _$CreateCustomGoalModelFromJson(
        Map<String, dynamic> json) =>
    CreateCustomGoalModel(
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as int?,
      goalName: json['goalName'] as String?,
      goalIcon: json['goalIcon'] as String?,
      goalType: json['goalType'] as String?,
      currentGoalAmount: (json['currentGoalAmount'] as num?)?.toDouble(),
      targetGoalAmount: (json['targetGoalAmount'] as num?)?.toDouble(),
      targetedGoalDate: json['targetedGoalDate'] == null
          ? null
          : DateTime.parse(json['targetedGoalDate'] as String),
      goalCompletionPercentage: json['goalCompletionPercentage'] as int?,
      goalCompletionDate: json['goalCompletionDate'] as String?,
      goalCompleted: json['goalCompleted'] as bool?,
      userId: json['userId'] as int?,
    );

Map<String, dynamic> _$CreateCustomGoalModelToJson(
        CreateCustomGoalModel instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'id': instance.id,
      'goalName': instance.goalName,
      'goalIcon': instance.goalIcon,
      'goalType': instance.goalType,
      'currentGoalAmount': instance.currentGoalAmount,
      'targetGoalAmount': instance.targetGoalAmount,
      'targetedGoalDate': instance.targetedGoalDate?.toIso8601String(),
      'goalCompletionPercentage': instance.goalCompletionPercentage,
      'goalCompletionDate': instance.goalCompletionDate,
      'goalCompleted': instance.goalCompleted,
      'userId': instance.userId,
    };
