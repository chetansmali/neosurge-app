import 'package:json_annotation/json_annotation.dart';

part 'get_mutual_fund_details_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetMutualFundDetailsParams {
  final String schemeCode;
  final String holdingPeriod;
  final String planName;
  final String optionName;

  GetMutualFundDetailsParams({
    required this.schemeCode,
    this.holdingPeriod = '1M',
    //TODO: change to direct when the api is ready
    this.planName = 'broker',
    this.optionName = 'growth',
  }) :
        // assert(holdingPeriod == '1M', 'The holding period should be 1M'),
        // assert(planName == 'direct', 'The plan name should be direct'),
        assert(optionName == 'growth', 'The option name should be empty');

  factory GetMutualFundDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$GetMutualFundDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetMutualFundDetailsParamsToJson(this);
}
