// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_with_email_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginWithEmailResponseModel _$LoginWithEmailResponseModelFromJson(
        Map<String, dynamic> json) =>
    LoginWithEmailResponseModel(
      message: json['message'] as String?,
      sessionId: json['sessionId'] as String?,
      creationTime: json['creationTime'] as String?,
      status: json['status'] as bool,
      errorCode: json['errorCode'] as int?,
    );

Map<String, dynamic> _$LoginWithEmailResponseModelToJson(
        LoginWithEmailResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'sessionId': instance.sessionId,
      'creationTime': instance.creationTime,
      'status': instance.status,
      'errorCode': instance.errorCode,
    };
