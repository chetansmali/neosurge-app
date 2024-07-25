// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      smallcaseAuthToken: json['smallcaseAuthToken'] as String?,
      smallcaseBrokerKey: json['smallcaseBrokerKey'] as String?,
      success: json['success'] as bool,
      transactionId: json['transactionId'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'smallcaseAuthToken': instance.smallcaseAuthToken,
      'smallcaseBrokerKey': instance.smallcaseBrokerKey,
      'success': instance.success,
      'message': instance.message,
    };
