// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'etf_stocks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ETFStocksParams _$ETFStocksParamsFromJson(Map<String, dynamic> json) =>
    ETFStocksParams(
      sort: json['sort'] as String?,
      filter: json['filter'] as String?,
      size: json['size'] as String?,
      page: json['page'] as String?,
    );

Map<String, dynamic> _$ETFStocksParamsToJson(ETFStocksParams instance) =>
    <String, dynamic>{
      'sort': instance.sort,
      'filter': instance.filter,
      'size': instance.size,
      'page': instance.page,
    };
