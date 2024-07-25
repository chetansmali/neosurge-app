import 'package:json_annotation/json_annotation.dart';
part 'goal_planning_dashboard_data_model.g.dart';

@JsonSerializable()
class GoalPlanningDashboardDataModel {
  final int? id;
  final String? goalName;
  final String? goalType;
  final String? goalIcon;
  final double? currentGoalAmount;
  final double? goalCompletionPercentage;
  final bool? goalCompleted;

  GoalPlanningDashboardDataModel({
    required this.id,
    required this.goalName,
    required this.goalType,
    required this.goalIcon,
    required this.currentGoalAmount,
    required this.goalCompletionPercentage,
    required this.goalCompleted,
  });

  factory GoalPlanningDashboardDataModel.fromJson(Map<String, dynamic> json) =>
      _$GoalPlanningDashboardDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoalPlanningDashboardDataModelToJson(this);

  static List<GoalPlanningDashboardDataModel> listFromJson(
          List<dynamic> json) =>
      json.map((e) => GoalPlanningDashboardDataModel.fromJson(e)).toList();
}
