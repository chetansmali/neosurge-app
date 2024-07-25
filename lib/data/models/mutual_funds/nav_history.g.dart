// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nav_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavHistory _$NavHistoryFromJson(Map<String, dynamic> json) => NavHistory(
      date: DateTime.parse(json['date'] as String),
      nav: (json['nav'] as num).toDouble(),
    );

Map<String, dynamic> _$NavHistoryToJson(NavHistory instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'nav': instance.nav,
    };
