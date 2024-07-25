// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataItem _$DataItemFromJson(Map<String, dynamic> json) => DataItem(
      article: Article.fromJson(json['article'] as Map<String, dynamic>),
      featuredHighlight: FeaturedHighlight.fromJson(
          json['featuredHighlight'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataItemToJson(DataItem instance) => <String, dynamic>{
      'article': instance.article,
      'featuredHighlight': instance.featuredHighlight,
    };
