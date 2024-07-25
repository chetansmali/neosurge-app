// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email_otp_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyEmailOtpParams _$VerifyEmailOtpParamsFromJson(
        Map<String, dynamic> json) =>
    VerifyEmailOtpParams(
      emailAddress: json['emailAddress'] as String,
      userOTP: json['userOTP'] as String,
      sessionId: json['sessionId'] as String,
      creationTime: json['creationTime'] as String,
      fcmToken: json['fcmToken'] as String,
    );

Map<String, dynamic> _$VerifyEmailOtpParamsToJson(
        VerifyEmailOtpParams instance) =>
    <String, dynamic>{
      'emailAddress': instance.emailAddress,
      'userOTP': instance.userOTP,
      'sessionId': instance.sessionId,
      'creationTime': instance.creationTime,
      'fcmToken': instance.fcmToken,
    };
