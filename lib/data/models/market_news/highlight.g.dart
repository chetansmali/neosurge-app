// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'highlight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Highlight _$HighlightFromJson(Map<String, dynamic> json) => Highlight(
      highlight: json['highlight'] as String,
      sentiment: (json['sentiment'] as num).toDouble(),
    );

Map<String, dynamic> _$HighlightToJson(Highlight instance) => <String, dynamic>{
      'highlight': instance.highlight,
      'sentiment': instance.sentiment,
    };
