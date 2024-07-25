// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_basket_chart_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBasketChartParams _$GetBasketChartParamsFromJson(
        Map<String, dynamic> json) =>
    GetBasketChartParams(
      basketId: json['basketID'] as String,
      duration: json['duration'] as String,
    );

Map<String, dynamic> _$GetBasketChartParamsToJson(
        GetBasketChartParams instance) =>
    <String, dynamic>{
      'basketID': instance.basketId,
      'duration': instance.duration,
    };
