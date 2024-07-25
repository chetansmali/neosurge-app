// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_by_index_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterByIndexParams _$FilterByIndexParamsFromJson(Map<String, dynamic> json) =>
    FilterByIndexParams(
      index: json['index'] as String,
      page: json['page'] as int?,
      size: json['size'] as int?,
      sort: json['sort'] as String?,
      filter: json['filter'] as String?,
    );

Map<String, dynamic> _$FilterByIndexParamsToJson(
        FilterByIndexParams instance) =>
    <String, dynamic>{
      'index': instance.index,
      'page': instance.page,
      'size': instance.size,
      'sort': instance.sort,
      'filter': instance.filter,
    };
