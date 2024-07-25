// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_funds_by_investment_idea_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFundsByInvestmentIdeaParams _$GetFundsByInvestmentIdeaParamsFromJson(
        Map<String, dynamic> json) =>
    GetFundsByInvestmentIdeaParams(
      page: json['page'] as int,
      size: json['size'] as int,
      filter: json['filter'] as String,
      viewKey: json['viewkey'] as String,
      sort: json['sort'] as String,
    );

Map<String, dynamic> _$GetFundsByInvestmentIdeaParamsToJson(
        GetFundsByInvestmentIdeaParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'sort': instance.sort,
      'viewkey': instance.viewKey,
      'filter': instance.filter,
    };
