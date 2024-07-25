import 'package:json_annotation/json_annotation.dart';
part 'generate_retirement_OTP_params.g.dart';

@JsonSerializable()
class GenerateRetirementOTPParams {
  final String mobileNumber;

  GenerateRetirementOTPParams({
    required this.mobileNumber,
  });

  factory GenerateRetirementOTPParams.fromJson(Map<String, dynamic> json) =>
      _$GenerateRetirementOTPParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GenerateRetirementOTPParamsToJson(this);
}
