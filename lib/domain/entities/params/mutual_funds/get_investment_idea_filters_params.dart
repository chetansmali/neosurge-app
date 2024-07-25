import 'package:json_annotation/json_annotation.dart';

part 'get_investment_idea_filters_params.g.dart';

@JsonSerializable(includeIfNull: false)
class GetInvestmentIdeaFiltersParams {
  @JsonKey(name: 'viewkey')
  final String viewKey;
  @JsonKey(name: 'numberoffilters')
  final String? numberOfFilters;
  @JsonKey(name: 'popularview')
  final bool? popularView;

  GetInvestmentIdeaFiltersParams({
    required this.viewKey,
    this.numberOfFilters,
    this.popularView,
  });

  factory GetInvestmentIdeaFiltersParams.fromJson(Map<String, dynamic> json) =>
      _$GetInvestmentIdeaFiltersParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetInvestmentIdeaFiltersParamsToJson(this);
}
