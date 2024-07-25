// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_chart_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockChartParams _$StockChartParamsFromJson(Map<String, dynamic> json) =>
    StockChartParams(
      filter: json['filter'] as String,
      symbolName: json['symbolName'] as String,
    );

Map<String, dynamic> _$StockChartParamsToJson(StockChartParams instance) =>
    <String, dynamic>{
      'filter': instance.filter,
      'symbolName': instance.symbolName,
    };
