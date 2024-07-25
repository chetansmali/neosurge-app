import 'package:json_annotation/json_annotation.dart';

part 'login_with_email_response_model.g.dart';

@JsonSerializable()
class LoginWithEmailResponseModel {
  final String? message;
  final String? sessionId;
  final String? creationTime;
  final bool status;
  final int? errorCode;

  LoginWithEmailResponseModel({
    this.message,
    required this.sessionId,
    required this.creationTime,
    required this.status,
    this.errorCode,
  });

  factory LoginWithEmailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginWithEmailResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginWithEmailResponseModelToJson(this);
}
