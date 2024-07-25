// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_sector_allocation_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSectorAllocationParams _$GetSectorAllocationParamsFromJson(
        Map<String, dynamic> json) =>
    GetSectorAllocationParams(
      schemeCode: json['scheme_code'] as String,
      asOn: json['as_on'] as String?,
      portfolioType: json['portfolio_type'] as String?,
    );

Map<String, dynamic> _$GetSectorAllocationParamsToJson(
        GetSectorAllocationParams instance) =>
    <String, dynamic>{
      'scheme_code': instance.schemeCode,
      'as_on': instance.asOn,
      'portfolio_type': instance.portfolioType,
    };
