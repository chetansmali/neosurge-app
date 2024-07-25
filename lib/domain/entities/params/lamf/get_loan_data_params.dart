import 'package:json_annotation/json_annotation.dart';

part 'get_loan_data_params.g.dart';

@JsonSerializable()
class GetLoanDataParams {
  String accountID;

  GetLoanDataParams({
    required this.accountID,
  });

  factory GetLoanDataParams.fromJson(Map<String, dynamic> json) =>
      _$GetLoanDataParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetLoanDataParamsToJson(this);
}
