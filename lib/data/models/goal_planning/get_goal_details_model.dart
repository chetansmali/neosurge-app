import 'package:json_annotation/json_annotation.dart';
part 'get_goal_details_model.g.dart';

@JsonSerializable()
class GetGoalDetailsModel {
  final String? goalName;
  final String? goalType;
  final String? goalIcon;
  final bool? goalCompleted;
  final double? currentGoalValue;
  final double? targetGoalValue;
  final double? goalInvestedValue;
  final List<LinkedInvestments>? linkedInvestments;

  GetGoalDetailsModel({
    required this.goalName,
    required this.goalType,
    required this.goalIcon,
    required this.goalCompleted,
    required this.currentGoalValue,
    required this.targetGoalValue,
    required this.goalInvestedValue,
    required this.linkedInvestments,
  });
  factory GetGoalDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$GetGoalDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetGoalDetailsModelToJson(this);
}

@JsonSerializable()
class LinkedInvestments {
  final String? schemeName;
  final String? amcLogo;
  final double? investedValue;
  final double? currentValue;
  final double? returnsPercentage;

  LinkedInvestments({
    required this.investedValue,
    required this.schemeName,
    required this.amcLogo,
    required this.currentValue,
    required this.returnsPercentage,
  });

  factory LinkedInvestments.fromJson(Map<String, dynamic> json) =>
      _$LinkedInvestmentsFromJson(json);

  Map<String, dynamic> toJson() => _$LinkedInvestmentsToJson(this);
}
