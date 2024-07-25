// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_transaction_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateTransactionParams _$ValidateTransactionParamsFromJson(
        Map<String, dynamic> json) =>
    ValidateTransactionParams(
      userID: json['userID'] as int,
      panNumber: json['panNumber'] as String,
      phoneNumber: json['phoneNumber'] as String,
      transactionID: json['transactionID'] as String,
      otp: json['otp'] as String?,
    );

Map<String, dynamic> _$ValidateTransactionParamsToJson(
        ValidateTransactionParams instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'panNumber': instance.panNumber,
      'phoneNumber': instance.phoneNumber,
      'transactionID': instance.transactionID,
      'otp': instance.otp,
    };
