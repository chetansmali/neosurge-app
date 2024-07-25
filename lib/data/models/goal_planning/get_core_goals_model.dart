import 'package:json_annotation/json_annotation.dart';
part 'get_core_goals_model.g.dart';

@JsonSerializable()
class GetCoreGoalsModel {
  final String goalType;
  final List<Goal> goals;

  GetCoreGoalsModel({
    required this.goalType,
    required this.goals,
  });
  factory GetCoreGoalsModel.fromJson(Map<String, dynamic> json) =>
      _$GetCoreGoalsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetCoreGoalsModelToJson(this);

  static List<GetCoreGoalsModel> listFromJson(List<dynamic> json) =>
      json.map((e) => GetCoreGoalsModel.fromJson(e)).toList();
}

@JsonSerializable()
class Goal {
  final String goalName;
  final String goalType;
  final String? goalIcon;

  Goal({
    required this.goalName,
    required this.goalType,
    required this.goalIcon,
  });
  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  Map<String, dynamic> toJson() => _$GoalToJson(this);
}
