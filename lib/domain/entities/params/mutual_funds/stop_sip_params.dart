import 'package:json_annotation/json_annotation.dart';

part 'stop_sip_params.g.dart';

@JsonSerializable()
class StopSipParams {
  final int userId;
  final int sipId;

  StopSipParams({required this.userId, required this.sipId});

  factory StopSipParams.fromJson(Map<String, dynamic> json) =>
      _$StopSipParamsFromJson(json);

  Map<String, dynamic> toJson() => _$StopSipParamsToJson(this);
}
