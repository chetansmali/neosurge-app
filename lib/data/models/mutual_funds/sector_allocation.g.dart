// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sector_allocation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectorAllocationList _$SectorAllocationListFromJson(
        Map<String, dynamic> json) =>
    SectorAllocationList(
      sectors: (json['sectors'] as List<dynamic>)
          .map((e) => HoldingSector.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SectorAllocationListToJson(
        SectorAllocationList instance) =>
    <String, dynamic>{
      'sectors': instance.sectors,
    };

HoldingSector _$HoldingSectorFromJson(Map<String, dynamic> json) =>
    HoldingSector(
      asOnDate: json['as_on_date'] as String,
      sector: json['sector'] as String,
      holdingPercent: (json['holding_perc'] as num).toDouble(),
      marketValue: (json['market_value'] as num).toDouble(),
    );

Map<String, dynamic> _$HoldingSectorToJson(HoldingSector instance) =>
    <String, dynamic>{
      'as_on_date': instance.asOnDate,
      'sector': instance.sector,
      'holding_perc': instance.holdingPercent,
      'market_value': instance.marketValue,
    };
