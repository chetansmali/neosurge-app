import 'package:json_annotation/json_annotation.dart';

part 'verify_cart_purchase_otp_params.g.dart';

@JsonSerializable()
class VerifyCartPurchaseOtpParams {
  final String cartPurchaseID;
  final String otp;

  VerifyCartPurchaseOtpParams({
    required this.cartPurchaseID,
    required this.otp,
  });

  factory VerifyCartPurchaseOtpParams.fromJson(Map<String, dynamic> json) =>
      _$VerifyCartPurchaseOtpParamsFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyCartPurchaseOtpParamsToJson(this);
}
