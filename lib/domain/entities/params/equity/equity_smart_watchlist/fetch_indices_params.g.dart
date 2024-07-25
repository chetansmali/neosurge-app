// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_indices_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchIndicesParams _$FetchIndicesParamsFromJson(Map<String, dynamic> json) =>
    FetchIndicesParams(
      page: json['page'] as String,
      size: json['size'] as String,
      sort: json['sort'] as String,
      category: json['category'] as String,
      searchString: json['searchString'] as String,
    );

Map<String, dynamic> _$FetchIndicesParamsToJson(FetchIndicesParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'sort': instance.sort,
      'category': instance.category,
      'searchString': instance.searchString,
    };
