import 'package:json_annotation/json_annotation.dart';

part 'get_systematic_plans_params.g.dart';

@JsonSerializable()
class GetSystematicPlansParams {
  final int userId;
  final bool isActive;

  GetSystematicPlansParams({
    required this.userId,
    required this.isActive,
  });

  factory GetSystematicPlansParams.fromJson(Map<String, dynamic> json) =>
      _$GetSystematicPlansParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetSystematicPlansParamsToJson(this);
}
