import 'package:json_annotation/json_annotation.dart';
part 'create_goal_investment_params.g.dart';

@JsonSerializable()
class CreateGoalInvestmentParams {
  final int userId;
  final int paymentId;
  final int goalId;

  CreateGoalInvestmentParams({
    required this.userId,
    required this.paymentId,
    required this.goalId,
  });

  factory CreateGoalInvestmentParams.fromJson(Map<String, dynamic> json) =>
      _$CreateGoalInvestmentParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGoalInvestmentParamsToJson(this);
}
