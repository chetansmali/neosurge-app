import 'package:json_annotation/json_annotation.dart';
part 'create_custom_goal_model.g.dart';

@JsonSerializable()
class CreateCustomGoalModel {
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? id;
  final String? goalName;
  final String? goalIcon;
  final String? goalType;
  final double? currentGoalAmount;
  final double? targetGoalAmount;
  final DateTime? targetedGoalDate;
  final int? goalCompletionPercentage;
  final String? goalCompletionDate;
  final bool? goalCompleted;
  final int? userId;

  CreateCustomGoalModel({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.goalName,
    required this.goalIcon,
    required this.goalType,
    required this.currentGoalAmount,
    required this.targetGoalAmount,
    required this.targetedGoalDate,
    required this.goalCompletionPercentage,
    required this.goalCompletionDate,
    required this.goalCompleted,
    required this.userId,
  });
  factory CreateCustomGoalModel.fromJson(Map<String, dynamic> json) =>
      _$CreateCustomGoalModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCustomGoalModelToJson(this);
}
