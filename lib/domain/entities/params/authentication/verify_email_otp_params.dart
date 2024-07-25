import 'package:json_annotation/json_annotation.dart';

part 'verify_email_otp_params.g.dart';

@JsonSerializable()
class VerifyEmailOtpParams {
  final String emailAddress;
  final String userOTP;
  final String sessionId;
  final String creationTime;
  final String fcmToken;

  VerifyEmailOtpParams({
    required this.emailAddress,
    required this.userOTP,
    required this.sessionId,
    required this.creationTime,
    required this.fcmToken,
  });

  factory VerifyEmailOtpParams.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailOtpParamsFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyEmailOtpParamsToJson(this);
}
