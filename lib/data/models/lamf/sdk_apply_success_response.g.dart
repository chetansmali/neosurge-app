// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sdk_apply_success_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SDKApplySuccessResponse _$SDKApplySuccessResponseFromJson(
        Map<String, dynamic> json) =>
    SDKApplySuccessResponse(
      intent: json['intent'] as String,
      userId: json['userId'] as String,
      loanApplication: LoanApplicationInfo.fromJson(
          json['loanApplication'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SDKApplySuccessResponseToJson(
        SDKApplySuccessResponse instance) =>
    <String, dynamic>{
      'intent': instance.intent,
      'userId': instance.userId,
      'loanApplication': instance.loanApplication,
    };

LoanApplicationInfo _$LoanApplicationInfoFromJson(Map<String, dynamic> json) =>
    LoanApplicationInfo(
      status: json['status'] as String,
      lid: json['lid'] as String,
    );

Map<String, dynamic> _$LoanApplicationInfoToJson(
        LoanApplicationInfo instance) =>
    <String, dynamic>{
      'status': instance.status,
      'lid': instance.lid,
    };
