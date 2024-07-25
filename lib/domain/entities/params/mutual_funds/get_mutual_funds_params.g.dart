// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_mutual_funds_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMutualFundsParams _$GetMutualFundsParamsFromJson(
        Map<String, dynamic> json) =>
    GetMutualFundsParams(
      from: json['from'] as int,
      size: json['size'] as int,
      minInitialInvestment: json['min_initial_investment'] as String?,
      minSipAmount: json['min_sip_amount'] as String?,
      riskProfile: json['risk_profile'] as String?,
      amcCode: json['amc_code'] as String?,
      assetCategory: json['asset_category'] as String?,
      assetSubCategory: json['asset_sub_category'] as String?,
      searchText: json['search_text'] as String?,
      schemeCode: json['scheme_code'] as String?,
      returnsPerc: json['returns_perc'] as String?,
      sortBy: json['sort_by'] as String?,
      sortOrder: json['sort_order'] as String?,
      holdingPeriod: json['holding_period'] as String? ?? '1M',
      planName: json['plan_name'] as String? ?? 'broker',
      optionName: json['option_name'] as String? ?? 'growth',
      ratings:
          (json['ratings'] as List<dynamic>?)?.map((e) => e as int).toList() ??
              const [],
    );

Map<String, dynamic> _$GetMutualFundsParamsToJson(
        GetMutualFundsParams instance) =>
    <String, dynamic>{
      'from': instance.from,
      'size': instance.size,
      'min_initial_investment': instance.minInitialInvestment,
      'min_sip_amount': instance.minSipAmount,
      'risk_profile': instance.riskProfile,
      'amc_code': instance.amcCode,
      'plan_name': instance.planName,
      'option_name': instance.optionName,
      'asset_category': instance.assetCategory,
      'asset_sub_category': instance.assetSubCategory,
      'search_text': instance.searchText,
      'scheme_code': instance.schemeCode,
      'holding_period': instance.holdingPeriod,
      'returns_perc': instance.returnsPerc,
      'sort_by': instance.sortBy,
      'sort_order': instance.sortOrder,
      'ratings': instance.ratings,
    };
