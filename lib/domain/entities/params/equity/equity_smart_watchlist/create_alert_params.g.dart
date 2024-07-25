// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_alert_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAlertParams _$CreateAlertParamsFromJson(Map<String, dynamic> json) =>
    CreateAlertParams(
      symbol: json['symbol'] as String,
      price: (json['price'] as num).toDouble(),
      comparisonMetric: json['comparisonMetric'] as String,
    );

Map<String, dynamic> _$CreateAlertParamsToJson(CreateAlertParams instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'price': instance.price,
      'comparisonMetric': instance.comparisonMetric,
    };
