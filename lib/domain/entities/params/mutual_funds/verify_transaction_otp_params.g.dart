// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_transaction_otp_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyTransactionOtpParams _$VerifyTransactionOtpParamsFromJson(
        Map<String, dynamic> json) =>
    VerifyTransactionOtpParams(
      id: json['id'] as int,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$VerifyTransactionOtpParamsToJson(
        VerifyTransactionOtpParams instance) =>
    <String, dynamic>{
      'id': instance.id,
      'otp': instance.otp,
    };
