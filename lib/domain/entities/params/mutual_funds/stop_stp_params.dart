import 'package:json_annotation/json_annotation.dart';

part 'stop_stp_params.g.dart';

@JsonSerializable()
class StopStpParams {
  final int userId;
  final int stpId;

  StopStpParams({required this.userId, required this.stpId});

  factory StopStpParams.fromJson(Map<String, dynamic> json) =>
      _$StopStpParamsFromJson(json);

  Map<String, dynamic> toJson() => _$StopStpParamsToJson(this);
}
