import 'package:json_annotation/json_annotation.dart';

part 'verify_delete_mandate_params.g.dart';

@JsonSerializable()
class VerifyDeleteMandateParams {
  @JsonKey(name: 'deleteID')
  final String verifyDeleteMandateRedId;
  final String otp;

  VerifyDeleteMandateParams({
    required this.verifyDeleteMandateRedId,
    required this.otp,
  });

  factory VerifyDeleteMandateParams.fromJson(Map<String, dynamic> json) =>
      _$VerifyDeleteMandateParamsFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyDeleteMandateParamsToJson(this);
}
