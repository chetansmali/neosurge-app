// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_sip_order_verify_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketSipOrderVerifyParams _$BasketSipOrderVerifyParamsFromJson(
        Map<String, dynamic> json) =>
    BasketSipOrderVerifyParams(
      orderRef: json['orderRef'] as String,
      consentId: json['consentID'] as int,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$BasketSipOrderVerifyParamsToJson(
        BasketSipOrderVerifyParams instance) =>
    <String, dynamic>{
      'orderRef': instance.orderRef,
      'consentID': instance.consentId,
      'otp': instance.otp,
    };
