// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_funds_by_subcategory_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFundsBySubCategoryParams _$GetFundsBySubCategoryParamsFromJson(
        Map<String, dynamic> json) =>
    GetFundsBySubCategoryParams(
      subCategory: json['assetSubCategory'] as String,
      page: json['page'] as int,
      size: json['size'] as int,
      sort: json['sort'] as String,
      category: json['assetCategory'] as String,
    );

Map<String, dynamic> _$GetFundsBySubCategoryParamsToJson(
        GetFundsBySubCategoryParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'sort': instance.sort,
      'assetCategory': instance.category,
      'assetSubCategory': instance.subCategory,
    };
