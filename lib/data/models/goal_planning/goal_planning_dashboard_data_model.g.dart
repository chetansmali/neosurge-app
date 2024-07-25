// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_planning_dashboard_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalPlanningDashboardDataModel _$GoalPlanningDashboardDataModelFromJson(
        Map<String, dynamic> json) =>
    GoalPlanningDashboardDataModel(
      id: json['id'] as int?,
      goalName: json['goalName'] as String?,
      goalType: json['goalType'] as String?,
      goalIcon: json['goalIcon'] as String?,
      currentGoalAmount: (json['currentGoalAmount'] as num?)?.toDouble(),
      goalCompletionPercentage:
          (json['goalCompletionPercentage'] as num?)?.toDouble(),
      goalCompleted: json['goalCompleted'] as bool?,
    );

Map<String, dynamic> _$GoalPlanningDashboardDataModelToJson(
        GoalPlanningDashboardDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'goalName': instance.goalName,
      'goalType': instance.goalType,
      'goalIcon': instance.goalIcon,
      'currentGoalAmount': instance.currentGoalAmount,
      'goalCompletionPercentage': instance.goalCompletionPercentage,
      'goalCompleted': instance.goalCompleted,
    };
