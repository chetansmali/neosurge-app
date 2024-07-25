import 'package:json_annotation/json_annotation.dart';

part 'kyc_video_otp_response_model.g.dart';

@JsonSerializable()
class KycVideoOtpResponseModel {
  final String otp;

  const KycVideoOtpResponseModel({
    required this.otp,
  });

  factory KycVideoOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$KycVideoOtpResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$KycVideoOtpResponseModelToJson(this);
}
