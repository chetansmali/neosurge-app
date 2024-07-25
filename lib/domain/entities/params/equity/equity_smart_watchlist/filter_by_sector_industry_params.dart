import 'package:json_annotation/json_annotation.dart';

part 'filter_by_sector_industry_params.g.dart';

@JsonSerializable()
class FilterBySectorIndustryParams {
  final String sectors;
  final String industries;
  final String page;
  final String size;
  final String sort;
  FilterBySectorIndustryParams(
      {required this.sectors,
      required this.industries,
      required this.page,
      required this.size,
      required this.sort});

  factory FilterBySectorIndustryParams.fromJson(Map<String, dynamic> json) =>
      _$FilterBySectorIndustryParamsFromJson(json);
  Map<String, dynamic> toJson() => _$FilterBySectorIndustryParamsToJson(this);
}
