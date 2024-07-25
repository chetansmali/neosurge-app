import 'package:json_annotation/json_annotation.dart';

part 'get_init_loan_import_response.g.dart';

@JsonSerializable()
class GetInitiateLoanImportResponse {
  String? questionKey;
  String? answerKey;
  String? accessToken;

  GetInitiateLoanImportResponse({
    this.questionKey,
    this.answerKey,
    this.accessToken,
  });

  factory GetInitiateLoanImportResponse.fromJson(Map<String, dynamic> json) =>
      _$GetInitiateLoanImportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetInitiateLoanImportResponseToJson(this);
}
