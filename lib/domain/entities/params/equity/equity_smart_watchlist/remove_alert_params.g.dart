// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_alert_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoveAlertParams _$RemoveAlertParamsFromJson(Map<String, dynamic> json) =>
    RemoveAlertParams(
      alertIds:
          (json['alertIds'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RemoveAlertParamsToJson(RemoveAlertParams instance) =>
    <String, dynamic>{
      'alertIds': instance.alertIds,
    };
