import 'package:json_annotation/json_annotation.dart';

part 'verify_basket_redeem_consent_param.g.dart';

@JsonSerializable()
class VerifyBasketRedeemConsentParams {
  final String redemptionRef;
  final String otp;
  @JsonKey(name: 'consentID')
  final String consentId;

  VerifyBasketRedeemConsentParams({
    required this.redemptionRef,
    required this.otp,
    required this.consentId,
  });

  factory VerifyBasketRedeemConsentParams.fromJson(Map<String, dynamic> json) =>
      _$VerifyBasketRedeemConsentParamsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$VerifyBasketRedeemConsentParamsToJson(this);
}
