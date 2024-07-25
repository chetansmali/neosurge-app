import 'package:json_annotation/json_annotation.dart';

part 'verify_assisted_service_pin_params.g.dart';

@JsonSerializable()
class VerifyAssistedServicePinParams {
  final String pin;
  final int userId;

  VerifyAssistedServicePinParams({
    required this.pin,
    required this.userId,
  });

  factory VerifyAssistedServicePinParams.fromJson(Map<String, dynamic> json) =>
      _$VerifyAssistedServicePinParamsFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyAssistedServicePinParamsToJson(this);
}
