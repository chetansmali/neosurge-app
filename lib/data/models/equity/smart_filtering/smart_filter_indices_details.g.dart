// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_filter_indices_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmartFilterIndicesDetails _$SmartFilterIndicesDetailsFromJson(
        Map<String, dynamic> json) =>
    SmartFilterIndicesDetails(
      indices: (json['indices'] as List<dynamic>)
          .map((e) => IndexDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      availableCategories: (json['availableCategories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SmartFilterIndicesDetailsToJson(
        SmartFilterIndicesDetails instance) =>
    <String, dynamic>{
      'indices': instance.indices,
      'availableCategories': instance.availableCategories,
    };

IndexDetails _$IndexDetailsFromJson(Map<String, dynamic> json) => IndexDetails(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      close: double.parse(json['close'] as String),
      name: json['name'] as String,
      category: json['category'] as String,
      oneDayChange: double.parse(json['oneDayChange'] as String),
      oneDayPercentChange: double.parse(json['oneDayPercentChange'] as String),
      oneWeekChange: double.parse(json['oneWeekChange'] as String),
      oneWeekPercentChange:
          double.parse(json['oneWeekPercentChange'] as String),
      oneMonthChange: double.parse(json['oneMonthChange'] as String),
      oneMonthPercentChange:
          double.parse(json['oneMonthPercentChange'] as String),
      oneYearChange: double.parse(json['oneYearChange'] as String),
      oneYearPercentChange:
          double.parse(json['oneYearPercentChange'] as String),
      active: json['active'] as bool,
    );

Map<String, dynamic> _$IndexDetailsToJson(IndexDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'close': instance.close,
      'name': instance.name,
      'category': instance.category,
      'oneDayChange': instance.oneDayChange,
      'oneDayPercentChange': instance.oneDayPercentChange,
      'oneWeekChange': instance.oneWeekChange,
      'oneWeekPercentChange': instance.oneWeekPercentChange,
      'oneMonthChange': instance.oneMonthChange,
      'oneMonthPercentChange': instance.oneMonthPercentChange,
      'oneYearChange': instance.oneYearChange,
      'oneYearPercentChange': instance.oneYearPercentChange,
      'active': instance.active,
    };
