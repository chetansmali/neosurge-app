// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'razor_pay_error_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RazorPayErrorResponseModel _$RazorPayErrorResponseModelFromJson(
        Map<String, dynamic> json) =>
    RazorPayErrorResponseModel(
      code: json['code'] as String,
      description: json['description'] as String,
      field: json['field'] as String?,
      source: json['source'] as String,
      step: json['step'] as String,
      reason: json['reason'] as String,
      metadata: json['metadata'] == null
          ? null
          : ErrorMetaDataModel.fromJson(
              json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RazorPayErrorResponseModelToJson(
        RazorPayErrorResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'field': instance.field,
      'source': instance.source,
      'step': instance.step,
      'reason': instance.reason,
      'metadata': instance.metadata,
    };

ErrorMetaDataModel _$ErrorMetaDataModelFromJson(Map<String, dynamic> json) =>
    ErrorMetaDataModel(
      paymentId: json['payment_id'] as String,
      orderId: json['order_id'] as String,
    );

Map<String, dynamic> _$ErrorMetaDataModelToJson(ErrorMetaDataModel instance) =>
    <String, dynamic>{
      'payment_id': instance.paymentId,
      'order_id': instance.orderId,
    };
