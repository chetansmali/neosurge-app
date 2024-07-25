// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index_price_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexPriceParams _$IndexPriceParamsFromJson(Map<String, dynamic> json) =>
    IndexPriceParams(
      (json['indexes'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$IndexPriceParamsToJson(IndexPriceParams instance) =>
    <String, dynamic>{
      'indexes': instance.indexes,
    };
