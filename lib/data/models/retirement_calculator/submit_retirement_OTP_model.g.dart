// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_retirement_OTP_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitRetirementOTPModel _$SubmitRetirementOTPModelFromJson(
        Map<String, dynamic> json) =>
    SubmitRetirementOTPModel(
      requestId: json['requestId'] as String,
      otpVerified: json['otpVerified'] as String,
    );

Map<String, dynamic> _$SubmitRetirementOTPModelToJson(
        SubmitRetirementOTPModel instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'otpVerified': instance.otpVerified,
    };
