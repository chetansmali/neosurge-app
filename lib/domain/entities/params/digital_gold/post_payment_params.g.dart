// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_payment_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostPaymentParams _$PostPaymentParamsFromJson(Map<String, dynamic> json) =>
    PostPaymentParams(
      orderId: json['orderId'] as String,
      paymentId: json['paymentId'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$PostPaymentParamsToJson(PostPaymentParams instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'paymentId': instance.paymentId,
      'status': instance.status,
    };
