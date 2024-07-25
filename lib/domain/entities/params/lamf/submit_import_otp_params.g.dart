// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_import_otp_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitImportOtpParams _$SubmitImportOtpParamsFromJson(
        Map<String, dynamic> json) =>
    SubmitImportOtpParams(
      questionKey: json['questionKey'] as String,
      answerKey: json['answerKey'] as String,
      accessToken: json['accessToken'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$SubmitImportOtpParamsToJson(
        SubmitImportOtpParams instance) =>
    <String, dynamic>{
      'questionKey': instance.questionKey,
      'answerKey': instance.answerKey,
      'accessToken': instance.accessToken,
      'otp': instance.otp,
    };
