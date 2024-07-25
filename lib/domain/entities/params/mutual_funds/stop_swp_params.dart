import 'package:json_annotation/json_annotation.dart';

part 'stop_swp_params.g.dart';

@JsonSerializable()
class StopSwpParams {
  final int userId;
  final int swpId;

  StopSwpParams({
    required this.userId,
    required this.swpId,
  });

  factory StopSwpParams.fromJson(Map<String, dynamic> json) =>
      _$StopSwpParamsFromJson(json);

  Map<String, dynamic> toJson() => _$StopSwpParamsToJson(this);
}
