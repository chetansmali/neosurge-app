import 'package:json_annotation/json_annotation.dart';

part 'sdk_apply_success_response.g.dart';

@JsonSerializable()
class SDKApplySuccessResponse {
  final String intent;
  final String userId;
  final LoanApplicationInfo loanApplication;

  SDKApplySuccessResponse({
    required this.intent,
    required this.userId,
    required this.loanApplication,
  });

  factory SDKApplySuccessResponse.fromJson(Map<String, dynamic> json) =>
      _$SDKApplySuccessResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SDKApplySuccessResponseToJson(this);
}

@JsonSerializable()
class LoanApplicationInfo {
  final String status;
  final String lid;

  LoanApplicationInfo({required this.status, required this.lid});

  factory LoanApplicationInfo.fromJson(Map<String, dynamic> json) =>
      _$LoanApplicationInfoFromJson(json);
  Map<String, dynamic> toJson() => _$LoanApplicationInfoToJson(this);
}
