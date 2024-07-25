// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_chart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockChartModel _$StockChartModelFromJson(Map<String, dynamic> json) =>
    StockChartModel(
      datetime: DateTime.parse(json['datetime'] as String),
      close: double.parse(json['close'] as String),
    );

Map<String, dynamic> _$StockChartModelToJson(StockChartModel instance) =>
    <String, dynamic>{
      'datetime': instance.datetime.toIso8601String(),
      'close': instance.close,
    };
