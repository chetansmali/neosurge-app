// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_stp_funds_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetStpFundsParams _$GetStpFundsParamsFromJson(Map<String, dynamic> json) =>
    GetStpFundsParams(
      amcCode: json['amc_code'] as String,
      schemeCode: json['scheme_code'] as String,
      stpAmount: (json['stp_amount'] as num).toDouble(),
    );

Map<String, dynamic> _$GetStpFundsParamsToJson(GetStpFundsParams instance) =>
    <String, dynamic>{
      'amc_code': instance.amcCode,
      'scheme_code': instance.schemeCode,
      'stp_amount': instance.stpAmount,
    };
