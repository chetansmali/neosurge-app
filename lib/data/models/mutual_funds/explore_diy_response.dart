import 'package:json_annotation/json_annotation.dart';

import 'mutual_fund.dart';

part 'explore_diy_response.g.dart';

@JsonSerializable()
class ExploreDIYDataResponse {
  final CategoryAndSubCategory categoryAndSubCategory;
  final String currentAssetCategory;

  @JsonKey(fromJson: _popularMutualFundsFromJson)
  final List<MutualFund> popularMutualFunds;

  ExploreDIYDataResponse({
    required this.categoryAndSubCategory,
    required this.currentAssetCategory,
    required this.popularMutualFunds,
  });

  factory ExploreDIYDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ExploreDIYDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExploreDIYDataResponseToJson(this);
}

List<MutualFund> _popularMutualFundsFromJson(
  Map<String, dynamic> json,
) {
  return (json['content'] as List)
      .map(
        (e) => MutualFund.fromJson(e),
      )
      .toList();
}

@JsonSerializable()
class CategoryAndSubCategory {
  final String assetCategory;
  final List<String> assetSubCategories;

  CategoryAndSubCategory({
    required this.assetCategory,
    required this.assetSubCategories,
  });

  factory CategoryAndSubCategory.fromJson(Map<String, dynamic> json) =>
      _$CategoryAndSubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryAndSubCategoryToJson(this);
}
