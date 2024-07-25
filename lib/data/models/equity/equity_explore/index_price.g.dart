// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexPriceModel _$IndexPriceModelFromJson(Map<String, dynamic> json) =>
    IndexPriceModel(
      symbolName: json['symbolName'] as String,
      close: double.parse(json['close'] as String),
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
    );

Map<String, dynamic> _$IndexPriceModelToJson(IndexPriceModel instance) =>
    <String, dynamic>{
      'symbolName': instance.symbolName,
      'close': instance.close,
      'oneDayChange': instance.oneDayChange,
      'oneDayPercentChange': instance.oneDayPercentChange,
      'oneWeekChange': instance.oneWeekChange,
      'oneWeekPercentChange': instance.oneWeekPercentChange,
      'oneMonthChange': instance.oneMonthChange,
      'oneMonthPercentChange': instance.oneMonthPercentChange,
      'oneYearChange': instance.oneYearChange,
      'oneYearPercentChange': instance.oneYearPercentChange,
    };
