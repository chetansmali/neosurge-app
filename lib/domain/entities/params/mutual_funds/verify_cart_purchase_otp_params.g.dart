// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_cart_purchase_otp_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyCartPurchaseOtpParams _$VerifyCartPurchaseOtpParamsFromJson(
        Map<String, dynamic> json) =>
    VerifyCartPurchaseOtpParams(
      cartPurchaseID: json['cartPurchaseID'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$VerifyCartPurchaseOtpParamsToJson(
        VerifyCartPurchaseOtpParams instance) =>
    <String, dynamic>{
      'cartPurchaseID': instance.cartPurchaseID,
      'otp': instance.otp,
    };
