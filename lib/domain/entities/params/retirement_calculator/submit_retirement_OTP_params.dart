import 'package:json_annotation/json_annotation.dart';
part 'submit_retirement_OTP_params.g.dart';

@JsonSerializable()
class SubmitRetirementOTPParams {
  final String requestId;
  final String otp;

  SubmitRetirementOTPParams({
    required this.requestId,
    required this.otp,
  });

  factory SubmitRetirementOTPParams.fromJson(Map<String, dynamic> json) =>
      _$SubmitRetirementOTPParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitRetirementOTPParamsToJson(this);
}
