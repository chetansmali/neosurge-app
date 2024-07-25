import 'package:json_annotation/json_annotation.dart';
part 'smallcase_login.g.dart';

@JsonSerializable()
class SmallCaseLoginParams {
  final String email;
  final String profileType;
  final String? smallcaseAuthToken;
  final String broker;

  SmallCaseLoginParams(
      {required this.email,
      required this.profileType,
      required this.smallcaseAuthToken,
      required this.broker});

  factory SmallCaseLoginParams.fromJson(Map<String, dynamic> json) =>
      _$SmallCaseLoginParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SmallCaseLoginParamsToJson(this);
}
