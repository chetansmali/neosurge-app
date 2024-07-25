// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_mutual_fund_holdings_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMutualFundHoldingParams _$GetMutualFundHoldingParamsFromJson(
        Map<String, dynamic> json) =>
    GetMutualFundHoldingParams(
      schemeCode: json['scheme_code'] as String,
      asOn: json['as_on'] as String?,
      portfolioType: json['portfolio_type'] as String?,
    );

Map<String, dynamic> _$GetMutualFundHoldingParamsToJson(
        GetMutualFundHoldingParams instance) =>
    <String, dynamic>{
      'scheme_code': instance.schemeCode,
      'as_on': instance.asOn,
      'portfolio_type': instance.portfolioType,
    };
