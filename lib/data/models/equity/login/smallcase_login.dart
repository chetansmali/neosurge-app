import 'package:json_annotation/json_annotation.dart';
part 'smallcase_login.g.dart';
@JsonSerializable()
class SmallCaseLoginModel{
  final String smallcaseAuthToken;
  final String brokerName;
  final String brokerKey;
  final String profileType;
  final int errorCode;
  final bool success;

  SmallCaseLoginModel({
    required this.smallcaseAuthToken,
    required this.brokerName,
    required this.brokerKey,
    required this.profileType,
    required this.errorCode,
    required this.success,
});
  factory SmallCaseLoginModel.fromJson(Map<String, dynamic> json) =>
      _$SmallCaseLoginModelFromJson(json);

  Map<String,dynamic> toJson() =>
      _$SmallCaseLoginModelToJson(this);
}