// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_mutual_fund_details_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMutualFundDetailsParams _$GetMutualFundDetailsParamsFromJson(
        Map<String, dynamic> json) =>
    GetMutualFundDetailsParams(
      schemeCode: json['scheme_code'] as String,
      holdingPeriod: json['holding_period'] as String? ?? '1M',
      planName: json['plan_name'] as String? ?? 'broker',
      optionName: json['option_name'] as String? ?? 'growth',
    );

Map<String, dynamic> _$GetMutualFundDetailsParamsToJson(
        GetMutualFundDetailsParams instance) =>
    <String, dynamic>{
      'scheme_code': instance.schemeCode,
      'holding_period': instance.holdingPeriod,
      'plan_name': instance.planName,
      'option_name': instance.optionName,
    };
