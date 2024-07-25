import 'package:json_annotation/json_annotation.dart';

part 'sdk_apply_error_details.g.dart';

@JsonSerializable()
class SDKApplyErrorResponse {
  final bool isSuccess;
  final int code;
  final String message;
  final ApplyErrorData data;
  SDKApplyErrorResponse({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.data,
  });

  factory SDKApplyErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$SDKApplyErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SDKApplyErrorResponseToJson(this);
}

@JsonSerializable()
class ApplyErrorData {
  final String intent;
  final String? userId;
  final LoanApplication? loanApplication;

  ApplyErrorData({
    required this.intent,
    this.userId,
    this.loanApplication,
  });

  factory ApplyErrorData.fromJson(Map<String, dynamic> json) =>
      _$ApplyErrorDataFromJson(json);
  Map<String, dynamic> toJson() => _$ApplyErrorDataToJson(this);
}

@JsonSerializable()
class LoanApplication {
  final String lid;
  final String status;

  LoanApplication({
    required this.lid,
    required this.status,
  });

  factory LoanApplication.fromJson(Map<String, dynamic> json) =>
      _$LoanApplicationFromJson(json);
  Map<String, dynamic> toJson() => _$LoanApplicationToJson(this);
}
