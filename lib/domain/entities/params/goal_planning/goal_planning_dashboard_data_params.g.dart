// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_planning_dashboard_data_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalPlanningOnboardDataParams _$GoalPlanningOnboardDataParamsFromJson(
        Map<String, dynamic> json) =>
    GoalPlanningOnboardDataParams(
      page: json['page'] as int,
      size: json['size'] as int,
      goaltype: json['goaltype'] as String,
    );

Map<String, dynamic> _$GoalPlanningOnboardDataParamsToJson(
        GoalPlanningOnboardDataParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'goaltype': instance.goaltype,
    };
