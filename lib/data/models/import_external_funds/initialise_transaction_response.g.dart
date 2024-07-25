// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initialise_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitialiseTransactionReposnse _$InitialiseTransactionReposnseFromJson(
        Map<String, dynamic> json) =>
    InitialiseTransactionReposnse(
      transactionID: json['transactionID'] as String,
      success: json['success'] as bool,
      errorMessage: json['errorMessage'] as String,
    );

Map<String, dynamic> _$InitialiseTransactionReposnseToJson(
        InitialiseTransactionReposnse instance) =>
    <String, dynamic>{
      'transactionID': instance.transactionID,
      'success': instance.success,
      'errorMessage': instance.errorMessage,
    };
