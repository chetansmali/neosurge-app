// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_investment_idea_filters_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetInvestmentIdeaFiltersParams _$GetInvestmentIdeaFiltersParamsFromJson(
        Map<String, dynamic> json) =>
    GetInvestmentIdeaFiltersParams(
      viewKey: json['viewkey'] as String,
      numberOfFilters: json['numberoffilters'] as String?,
      popularView: json['popularview'] as bool?,
    );

Map<String, dynamic> _$GetInvestmentIdeaFiltersParamsToJson(
    GetInvestmentIdeaFiltersParams instance) {
  final val = <String, dynamic>{
    'viewkey': instance.viewKey,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('numberoffilters', instance.numberOfFilters);
  writeNotNull('popularview', instance.popularView);
  return val;
}
