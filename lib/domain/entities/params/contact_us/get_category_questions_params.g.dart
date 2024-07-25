// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_category_questions_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCategoryQuestionsParams _$GetCategoryQuestionsParamsFromJson(
        Map<String, dynamic> json) =>
    GetCategoryQuestionsParams(
      page: json['page'] as String?,
      size: json['size'] as String?,
      sort: json['sort'] as String?,
      query: json['query'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$GetCategoryQuestionsParamsToJson(
        GetCategoryQuestionsParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'sort': instance.sort,
      'query': instance.query,
      'category': instance.category,
    };
