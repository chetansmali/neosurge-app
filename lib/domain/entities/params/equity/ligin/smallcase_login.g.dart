// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smallcase_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmallCaseLoginParams _$SmallCaseLoginParamsFromJson(
        Map<String, dynamic> json) =>
    SmallCaseLoginParams(
      email: json['email'] as String,
      profileType: json['profileType'] as String,
      smallcaseAuthToken: json['smallcaseAuthToken'] as String?,
      broker: json['broker'] as String,
    );

Map<String, dynamic> _$SmallCaseLoginParamsToJson(
        SmallCaseLoginParams instance) =>
    <String, dynamic>{
      'email': instance.email,
      'profileType': instance.profileType,
      'smallcaseAuthToken': instance.smallcaseAuthToken,
      'broker': instance.broker,
    };
