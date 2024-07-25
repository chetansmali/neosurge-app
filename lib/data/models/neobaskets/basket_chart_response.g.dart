// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_chart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketChartResponse _$BasketChartResponseFromJson(Map<String, dynamic> json) =>
    BasketChartResponse(
      returns: (json['possibleValue'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BasketChartResponseToJson(
        BasketChartResponse instance) =>
    <String, dynamic>{
      'possibleValue': instance.returns,
    };
