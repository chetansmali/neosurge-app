// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initiate_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitiatePaymentResponse _$InitiatePaymentResponseFromJson(
        Map<String, dynamic> json) =>
    InitiatePaymentResponse(
      id: json['id'] as int,
      paymentUrl: json['tokenUrl'] as String,
    );

Map<String, dynamic> _$InitiatePaymentResponseToJson(
        InitiatePaymentResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tokenUrl': instance.paymentUrl,
    };
