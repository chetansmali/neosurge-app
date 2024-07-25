// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smallcase_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmallCaseLoginModel _$SmallCaseLoginModelFromJson(Map<String, dynamic> json) =>
    SmallCaseLoginModel(
      smallcaseAuthToken: json['smallcaseAuthToken'] as String,
      brokerName: json['brokerName'] as String,
      brokerKey: json['brokerKey'] as String,
      profileType: json['profileType'] as String,
      errorCode: json['errorCode'] as int,
      success: json['success'] as bool,
    );

Map<String, dynamic> _$SmallCaseLoginModelToJson(
        SmallCaseLoginModel instance) =>
    <String, dynamic>{
      'smallcaseAuthToken': instance.smallcaseAuthToken,
      'brokerName': instance.brokerName,
      'brokerKey': instance.brokerKey,
      'profileType': instance.profileType,
      'errorCode': instance.errorCode,
      'success': instance.success,
    };
