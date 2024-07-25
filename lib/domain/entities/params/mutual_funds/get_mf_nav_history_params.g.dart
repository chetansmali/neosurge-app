// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_mf_nav_history_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMFNavHistoryParams _$GetMFNavHistoryParamsFromJson(
        Map<String, dynamic> json) =>
    GetMFNavHistoryParams(
      schemeCode: json['scheme_code'] as String,
      from: DateTime.parse(json['from'] as String),
      to: DateTime.parse(json['to'] as String),
      frequency: json['frequency'] as String,
    );

Map<String, dynamic> _$GetMFNavHistoryParamsToJson(
        GetMFNavHistoryParams instance) =>
    <String, dynamic>{
      'scheme_code': instance.schemeCode,
      'from': GetMFNavHistoryParams._dateTimeToString(instance.from),
      'to': GetMFNavHistoryParams._dateTimeToString(instance.to),
      'frequency': instance.frequency,
    };
