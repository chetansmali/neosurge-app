import 'package:json_annotation/json_annotation.dart';

part 'delete_sip_params.g.dart';

@JsonSerializable()
class DeleteSipParams {
  final String sipOrderRef;

  DeleteSipParams({
    required this.sipOrderRef,
  });

  factory DeleteSipParams.fromJson(Map<String, dynamic> json) =>
      _$DeleteSipParamsFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteSipParamsToJson(this);
}
