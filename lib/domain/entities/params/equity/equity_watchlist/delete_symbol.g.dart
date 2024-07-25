// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_symbol.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteSymbolParams _$DeleteSymbolParamsFromJson(Map<String, dynamic> json) =>
    DeleteSymbolParams(
      watchlistId: json['watchlistId'] as int,
      symbolId: json['symbolId'] as int,
    );

Map<String, dynamic> _$DeleteSymbolParamsToJson(DeleteSymbolParams instance) =>
    <String, dynamic>{
      'watchlistId': instance.watchlistId,
      'symbolId': instance.symbolId,
    };
