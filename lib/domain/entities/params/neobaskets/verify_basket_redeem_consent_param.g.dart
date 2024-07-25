// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_basket_redeem_consent_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyBasketRedeemConsentParams _$VerifyBasketRedeemConsentParamsFromJson(
        Map<String, dynamic> json) =>
    VerifyBasketRedeemConsentParams(
      redemptionRef: json['redemptionRef'] as String,
      otp: json['otp'] as String,
      consentId: json['consentID'] as String,
    );

Map<String, dynamic> _$VerifyBasketRedeemConsentParamsToJson(
        VerifyBasketRedeemConsentParams instance) =>
    <String, dynamic>{
      'redemptionRef': instance.redemptionRef,
      'otp': instance.otp,
      'consentID': instance.consentId,
    };
