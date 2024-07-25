import 'package:json_annotation/json_annotation.dart';

part 'submit_import_otp_params.g.dart';

@JsonSerializable()
class SubmitImportOtpParams {
  String questionKey;
  String answerKey;
  @JsonKey(name: 'accessToken')
  String accessToken;
  String otp;

  SubmitImportOtpParams({
    required this.questionKey,
    required this.answerKey,
    required this.accessToken,
    required this.otp,
  });

  factory SubmitImportOtpParams.fromJson(Map<String, dynamic> json) =>
      _$SubmitImportOtpParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitImportOtpParamsToJson(this);
}
