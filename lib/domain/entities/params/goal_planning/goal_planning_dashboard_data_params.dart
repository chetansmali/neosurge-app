import 'package:json_annotation/json_annotation.dart';
part 'goal_planning_dashboard_data_params.g.dart';

@JsonSerializable()
class GoalPlanningOnboardDataParams {
  final int page;
  final int size;
  final String goaltype;

  GoalPlanningOnboardDataParams({
    required this.page,
    required this.size,
    required this.goaltype,
  });

  factory GoalPlanningOnboardDataParams.fromJson(Map<String, dynamic> json) =>
      _$GoalPlanningOnboardDataParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GoalPlanningOnboardDataParamsToJson(this);
}
