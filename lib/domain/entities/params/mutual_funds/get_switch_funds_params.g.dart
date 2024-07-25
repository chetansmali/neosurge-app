// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_switch_funds_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSwitchFundsParams _$GetSwitchFundsParamsFromJson(
        Map<String, dynamic> json) =>
    GetSwitchFundsParams(
      amcCode: json['amc_code'] as String,
      schemeCode: json['scheme_code'] as String,
      switchAmount: (json['switch_amount'] as num).toDouble(),
    );

Map<String, dynamic> _$GetSwitchFundsParamsToJson(
        GetSwitchFundsParams instance) =>
    <String, dynamic>{
      'amc_code': instance.amcCode,
      'scheme_code': instance.schemeCode,
      'switch_amount': instance.switchAmount,
    };
