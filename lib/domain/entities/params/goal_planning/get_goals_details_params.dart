import 'package:json_annotation/json_annotation.dart';
part 'get_goals_details_params.g.dart';

@JsonSerializable()
class GetGoalsDetailsParams {
  final String id;

  GetGoalsDetailsParams({
    required this.id,
  });
  factory GetGoalsDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$GetGoalsDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetGoalsDetailsParamsToJson(this);
}
