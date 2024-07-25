import 'package:json_annotation/json_annotation.dart';
part 'create_goal_investment_model.g.dart';

@JsonSerializable()
class CreateGoalInvestmentModel {
  final bool success;
  final String message;
  final String data;

  CreateGoalInvestmentModel(
      {required this.success, required this.message, required this.data});

  factory CreateGoalInvestmentModel.fromJson(Map<String, dynamic> json) =>
      _$CreateGoalInvestmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGoalInvestmentModelToJson(this);
}
