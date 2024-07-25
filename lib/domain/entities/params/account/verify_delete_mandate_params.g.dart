// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_delete_mandate_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyDeleteMandateParams _$VerifyDeleteMandateParamsFromJson(
        Map<String, dynamic> json) =>
    VerifyDeleteMandateParams(
      verifyDeleteMandateRedId: json['deleteID'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$VerifyDeleteMandateParamsToJson(
        VerifyDeleteMandateParams instance) =>
    <String, dynamic>{
      'deleteID': instance.verifyDeleteMandateRedId,
      'otp': instance.otp,
    };
