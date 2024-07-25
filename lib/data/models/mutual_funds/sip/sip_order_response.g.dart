// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sip_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SipOrderResponse _$SipOrderResponseFromJson(Map<String, dynamic> json) =>
    SipOrderResponse(
      paymentUrl: json['tokenUrl'] as String,
      paymentId: json['id'] as int,
      amcLogo: AmcLogo.fromJson(json['amcLogo'] as Map<String, dynamic>),
      planName: json['planName'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
      startDay: json['startDay'] as int,
      folioNumber: json['folioNumber'] as String?,
    );

Map<String, dynamic> _$SipOrderResponseToJson(SipOrderResponse instance) =>
    <String, dynamic>{
      'tokenUrl': instance.paymentUrl,
      'id': instance.paymentId,
      'amcLogo': instance.amcLogo,
      'planName': instance.planName,
      'amount': instance.amount,
      'type': instance.type,
      'folioNumber': instance.folioNumber,
      'startDay': instance.startDay,
    };
