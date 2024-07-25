import 'package:json_annotation/json_annotation.dart';
part 'create_custom_goals_params.g.dart';

@JsonSerializable()
class CreateCustomGoalsParams {
  final String goalName;
  final String targetedGoalDate;
  final String goalType;
  final double targetGoalAmount;

  CreateCustomGoalsParams({
    required this.goalName,
    required this.targetedGoalDate,
    required this.goalType,
    required this.targetGoalAmount,
  });

  factory CreateCustomGoalsParams.fromJson(Map<String, dynamic> json) =>
      _$CreateCustomGoalsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCustomGoalsParamsToJson(this);
}
