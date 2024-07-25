// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_retirement_OTP_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateRetirementOTPModel _$GenerateRetirementOTPModelFromJson(
        Map<String, dynamic> json) =>
    GenerateRetirementOTPModel(
      requestId: json['requestId'] as String?,
      message: json['message'] as String,
      status: json['status'] as String,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$GenerateRetirementOTPModelToJson(
        GenerateRetirementOTPModel instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'message': instance.message,
      'status': instance.status,
      'reason': instance.reason,
    };
