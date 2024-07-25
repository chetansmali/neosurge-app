import 'package:json_annotation/json_annotation.dart';

part 'get_funds_by_investment_idea_params.g.dart';

@JsonSerializable()
class GetFundsByInvestmentIdeaParams {
  final int page;
  final int size;
  final String sort;
  @JsonKey(name: 'viewkey')
  final String viewKey;
  final String filter;

  GetFundsByInvestmentIdeaParams({
    required this.page,
    required this.size,
    required this.filter,
    required this.viewKey,
    required this.sort,
  });

  factory GetFundsByInvestmentIdeaParams.fromJson(Map<String, dynamic> json) =>
      _$GetFundsByInvestmentIdeaParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetFundsByInvestmentIdeaParamsToJson(this);
}
