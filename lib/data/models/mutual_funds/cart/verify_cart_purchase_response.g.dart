// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_cart_purchase_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyCartPurchaseOtpResponse _$VerifyCartPurchaseOtpResponseFromJson(
        Map<String, dynamic> json) =>
    VerifyCartPurchaseOtpResponse(
      tokenUrl: json['tokenUrl'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$VerifyCartPurchaseOtpResponseToJson(
        VerifyCartPurchaseOtpResponse instance) =>
    <String, dynamic>{
      'tokenUrl': instance.tokenUrl,
      'status': instance.status,
    };
