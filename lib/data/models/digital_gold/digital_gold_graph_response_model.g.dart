// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digital_gold_graph_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DigitalGoldGraphResponseModel _$DigitalGoldGraphResponseModelFromJson(
        Map<String, dynamic> json) =>
    DigitalGoldGraphResponseModel(
      id: json['id'] as int,
      goldBuyRate: (json['goldBuyRate'] as num).toDouble(),
      goldSellRate: (json['goldSellRate'] as num).toDouble(),
      silverBuyRate: (json['silverBuyRate'] as num).toDouble(),
      silverSellRate: (json['silverSellRate'] as num).toDouble(),
      onDate: DateTime.parse(json['onDate'] as String),
    );

Map<String, dynamic> _$DigitalGoldGraphResponseModelToJson(
        DigitalGoldGraphResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'goldBuyRate': instance.goldBuyRate,
      'goldSellRate': instance.goldSellRate,
      'silverBuyRate': instance.silverBuyRate,
      'silverSellRate': instance.silverSellRate,
      'onDate': instance.onDate.toIso8601String(),
    };
