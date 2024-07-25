import 'package:json_annotation/json_annotation.dart';

part 'verify_transaction_otp_params.g.dart';

@JsonSerializable()
class VerifyTransactionOtpParams {
  final int id;
  final String otp;

  VerifyTransactionOtpParams({
    required this.id,
    required this.otp,
  });

  factory VerifyTransactionOtpParams.fromJson(Map<String, dynamic> json) =>
      _$VerifyTransactionOtpParamsFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyTransactionOtpParamsToJson(this);
}
