// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_watchlist_search_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmartWatchlistSearchParams _$SmartWatchlistSearchParamsFromJson(
        Map<String, dynamic> json) =>
    SmartWatchlistSearchParams(
      filter: json['filter'] as String,
      size: json['size'] as int,
    );

Map<String, dynamic> _$SmartWatchlistSearchParamsToJson(
        SmartWatchlistSearchParams instance) =>
    <String, dynamic>{
      'filter': instance.filter,
      'size': instance.size,
    };
