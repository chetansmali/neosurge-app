import 'package:json_annotation/json_annotation.dart';

part 'get_mutual_funds_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetMutualFundsParams {
  final int from;
  final int size;
  final String? minInitialInvestment;
  final String? minSipAmount;
  final String? riskProfile;
  final String? amcCode;
  final String planName;
  final String optionName;
  final String? assetCategory;
  final String? assetSubCategory;
  final String? searchText;
  final String? schemeCode;
  final String holdingPeriod;
  final String? returnsPerc;
  final String? sortBy;
  final String? sortOrder;
  final List<int> ratings;

  GetMutualFundsParams({
    required this.from,
    required this.size,
    this.minInitialInvestment,
    this.minSipAmount,
    this.riskProfile,
    this.amcCode,
    this.assetCategory,
    this.assetSubCategory,
    this.searchText,
    this.schemeCode,
    this.returnsPerc,
    this.sortBy,
    this.sortOrder,
    this.holdingPeriod = '1M',
    //TODO: change to direct when the api is ready
    this.planName = 'broker',
    this.optionName = 'growth',
    this.ratings = const [],
  }) :
        // assert(holdingPeriod == '1M', 'The holding period should be 1M'),
        // assert(planName == 'direct', 'The plan name should be direct'),
        assert(optionName == 'growth', 'The option name should be empty');

  factory GetMutualFundsParams.fromJson(Map<String, dynamic> json) =>
      _$GetMutualFundsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetMutualFundsParamsToJson(this);
}
