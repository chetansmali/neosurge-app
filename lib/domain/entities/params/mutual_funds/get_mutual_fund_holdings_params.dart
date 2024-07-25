import 'package:json_annotation/json_annotation.dart';

part 'get_mutual_fund_holdings_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetMutualFundHoldingParams {
  //{
  //
  // 	"scheme_code": "112354",
  //     "as_on": "2022-01",
  //     "portfolio_type": "growth"
  // }

  final String schemeCode;
  final String? asOn;
  final String? portfolioType;

  GetMutualFundHoldingParams(
      {required this.schemeCode, this.asOn, this.portfolioType});

  factory GetMutualFundHoldingParams.fromJson(Map<String, dynamic> json) =>
      _$GetMutualFundHoldingParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetMutualFundHoldingParamsToJson(this);
}
