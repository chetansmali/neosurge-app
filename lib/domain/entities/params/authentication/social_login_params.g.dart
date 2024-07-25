// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_login_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialLoginParams _$SocialLoginParamsFromJson(Map<String, dynamic> json) =>
    SocialLoginParams(
      emailId: json['emailId'] as String,
      socialLoginType: $enumDecode(_$SocialLoginTypeEnumMap, json['loginType']),
      accessToken: json['accessToken'] as String,
      secretKey: json['secretKey'] as String? ?? 'A*C:-1/Lg-N!KK-gpwr-QY@z',
      fcmToken: json['fcmToken'] as String,
      authCode: json['authCode'] as String?,
    );

Map<String, dynamic> _$SocialLoginParamsToJson(SocialLoginParams instance) =>
    <String, dynamic>{
      'emailId': instance.emailId,
      'loginType': _$SocialLoginTypeEnumMap[instance.socialLoginType]!,
      'secretKey': instance.secretKey,
      'accessToken': instance.accessToken,
      'fcmToken': instance.fcmToken,
      'authCode': instance.authCode,
    };

const _$SocialLoginTypeEnumMap = {
  SocialLoginType.google: 'GOOGLE',
  SocialLoginType.apple: 'APPLE',
};
