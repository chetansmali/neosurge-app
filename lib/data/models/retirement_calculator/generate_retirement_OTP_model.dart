import 'package:json_annotation/json_annotation.dart';
part 'generate_retirement_OTP_model.g.dart';

@JsonSerializable()
class GenerateRetirementOTPModel {
  final String? requestId;
  final String message;
  final String status;
  final String? reason;

  GenerateRetirementOTPModel({
    required this.requestId,
    required this.message,
    required this.status,
    required this.reason,
  });

  factory GenerateRetirementOTPModel.fromJson(Map<String, dynamic> json) =>
      _$GenerateRetirementOTPModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenerateRetirementOTPModelToJson(this);
}
