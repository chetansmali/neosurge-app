// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_diy_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExploreDIYDataResponse _$ExploreDIYDataResponseFromJson(
        Map<String, dynamic> json) =>
    ExploreDIYDataResponse(
      categoryAndSubCategory: CategoryAndSubCategory.fromJson(
          json['categoryAndSubCategory'] as Map<String, dynamic>),
      currentAssetCategory: json['currentAssetCategory'] as String,
      popularMutualFunds: _popularMutualFundsFromJson(
          json['popularMutualFunds'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExploreDIYDataResponseToJson(
        ExploreDIYDataResponse instance) =>
    <String, dynamic>{
      'categoryAndSubCategory': instance.categoryAndSubCategory,
      'currentAssetCategory': instance.currentAssetCategory,
      'popularMutualFunds': instance.popularMutualFunds,
    };

CategoryAndSubCategory _$CategoryAndSubCategoryFromJson(
        Map<String, dynamic> json) =>
    CategoryAndSubCategory(
      assetCategory: json['assetCategory'] as String,
      assetSubCategories: (json['assetSubCategories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CategoryAndSubCategoryToJson(
        CategoryAndSubCategory instance) =>
    <String, dynamic>{
      'assetCategory': instance.assetCategory,
      'assetSubCategories': instance.assetSubCategories,
    };
