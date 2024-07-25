import 'package:json_annotation/json_annotation.dart';

import '../../enums.dart';

part 'social_login_params.g.dart';

@JsonSerializable()
class SocialLoginParams {
  final String emailId;
  @JsonKey(name: 'loginType')
  final SocialLoginType socialLoginType;

  final String secretKey;
  final String accessToken;
  final String fcmToken;
  final String? authCode;

  SocialLoginParams(
      {required this.emailId,
      required this.socialLoginType,
      required this.accessToken,
      this.secretKey = 'A*C:-1/Lg-N!KK-gpwr-QY@z',
      required this.fcmToken,
      this.authCode
      });

  factory SocialLoginParams.fromJson(Map<String, dynamic> json) =>
      _$SocialLoginParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SocialLoginParamsToJson(this);
}
