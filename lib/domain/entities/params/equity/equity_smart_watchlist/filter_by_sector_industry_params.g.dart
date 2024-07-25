// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_by_sector_industry_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterBySectorIndustryParams _$FilterBySectorIndustryParamsFromJson(
        Map<String, dynamic> json) =>
    FilterBySectorIndustryParams(
      sectors: json['sectors'] as String,
      industries: json['industries'] as String,
      page: json['page'] as String,
      size: json['size'] as String,
      sort: json['sort'] as String,
    );

Map<String, dynamic> _$FilterBySectorIndustryParamsToJson(
        FilterBySectorIndustryParams instance) =>
    <String, dynamic>{
      'sectors': instance.sectors,
      'industries': instance.industries,
      'page': instance.page,
      'size': instance.size,
      'sort': instance.sort,
    };
