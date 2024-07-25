// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_highlight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeaturedHighlight _$FeaturedHighlightFromJson(Map<String, dynamic> json) =>
    FeaturedHighlight(
      entity: Entity.fromJson(json['entity'] as Map<String, dynamic>),
      highlight: Highlight.fromJson(json['highlight'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeaturedHighlightToJson(FeaturedHighlight instance) =>
    <String, dynamic>{
      'entity': instance.entity,
      'highlight': instance.highlight,
    };
