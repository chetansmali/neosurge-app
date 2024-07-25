// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_lumpsum_order_verify_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketLumpsumOrderVerifyParams _$BasketLumpsumOrderVerifyParamsFromJson(
        Map<String, dynamic> json) =>
    BasketLumpsumOrderVerifyParams(
      orderRef: json['orderRef'] as String,
      consentId: json['consentID'] as int,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$BasketLumpsumOrderVerifyParamsToJson(
        BasketLumpsumOrderVerifyParams instance) =>
    <String, dynamic>{
      'orderRef': instance.orderRef,
      'consentID': instance.consentId,
      'otp': instance.otp,
    };
