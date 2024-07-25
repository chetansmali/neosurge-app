// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sdk_apply_error_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SDKApplyErrorResponse _$SDKApplyErrorResponseFromJson(
        Map<String, dynamic> json) =>
    SDKApplyErrorResponse(
      isSuccess: json['isSuccess'] as bool,
      code: json['code'] as int,
      message: json['message'] as String,
      data: ApplyErrorData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SDKApplyErrorResponseToJson(
        SDKApplyErrorResponse instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ApplyErrorData _$ApplyErrorDataFromJson(Map<String, dynamic> json) =>
    ApplyErrorData(
      intent: json['intent'] as String,
      userId: json['userId'] as String?,
      loanApplication: json['loanApplication'] == null
          ? null
          : LoanApplication.fromJson(
              json['loanApplication'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApplyErrorDataToJson(ApplyErrorData instance) =>
    <String, dynamic>{
      'intent': instance.intent,
      'userId': instance.userId,
      'loanApplication': instance.loanApplication,
    };

LoanApplication _$LoanApplicationFromJson(Map<String, dynamic> json) =>
    LoanApplication(
      lid: json['lid'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$LoanApplicationToJson(LoanApplication instance) =>
    <String, dynamic>{
      'lid': instance.lid,
      'status': instance.status,
    };
