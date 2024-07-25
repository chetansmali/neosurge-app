// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entity _$EntityFromJson(Map<String, dynamic> json) => Entity(
      newsUuid: json['newsUuid'] as String,
      symbol: json['symbol'] as String,
      industry: json['industry'] as String,
      name: json['name'] as String,
      sentimentScore: (json['sentimentScore'] as num).toDouble(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$EntityToJson(Entity instance) => <String, dynamic>{
      'newsUuid': instance.newsUuid,
      'symbol': instance.symbol,
      'industry': instance.industry,
      'name': instance.name,
      'sentimentScore': instance.sentimentScore,
      'type': instance.type,
    };
