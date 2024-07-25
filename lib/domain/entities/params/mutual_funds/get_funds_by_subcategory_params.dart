import 'package:json_annotation/json_annotation.dart';

part 'get_funds_by_subcategory_params.g.dart';

@JsonSerializable()
class GetFundsBySubCategoryParams {
  final int page;
  final int size;
  final String sort;
  @JsonKey(name: 'assetCategory')
  final String category;
  @JsonKey(name: 'assetSubCategory')
  final String subCategory;

  GetFundsBySubCategoryParams({
    required this.subCategory,
    required this.page,
    required this.size,
    required this.sort,
    required this.category,
  });

  factory GetFundsBySubCategoryParams.fromJson(Map<String, dynamic> json) =>
      _$GetFundsBySubCategoryParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetFundsBySubCategoryParamsToJson(this);
}
