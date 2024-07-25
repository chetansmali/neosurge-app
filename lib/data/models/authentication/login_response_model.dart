import 'package:json_annotation/json_annotation.dart';

import '../user/user.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  final String accessToken;
  final String refreshToken;
  final User user;

  LoginResponseModel(
      {required this.accessToken,
      required this.refreshToken,
      required this.user});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
