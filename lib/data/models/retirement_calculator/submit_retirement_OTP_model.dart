import 'package:json_annotation/json_annotation.dart';
part 'submit_retirement_OTP_model.g.dart';

@JsonSerializable()
class SubmitRetirementOTPModel {
  final String requestId;
  final String otpVerified;

  SubmitRetirementOTPModel(
      {required this.requestId, required this.otpVerified});
  factory SubmitRetirementOTPModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitRetirementOTPModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitRetirementOTPModelToJson(this);
}
