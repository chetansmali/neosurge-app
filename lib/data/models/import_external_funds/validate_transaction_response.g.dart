// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateTransactionResponse _$ValidateTransactionResponseFromJson(
        Map<String, dynamic> json) =>
    ValidateTransactionResponse(
      transactionID: json['transactionID'] as String,
      success: json['success'] as bool,
      errorMessage: json['errorMessage'] as String,
    );

Map<String, dynamic> _$ValidateTransactionResponseToJson(
        ValidateTransactionResponse instance) =>
    <String, dynamic>{
      'transactionID': instance.transactionID,
      'success': instance.success,
      'errorMessage': instance.errorMessage,
    };
