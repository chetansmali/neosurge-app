// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      id: json['id'] as String,
      uuid: json['uuid'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      keywords: json['keywords'] as String,
      language: json['language'] as String,
      publishedAt: json['publishedAt'] as int,
      sentimentGreaterThan: (json['sentimentGreaterThan'] as num).toDouble(),
      sentimentLessThan: (json['sentimentLessThan'] as num).toDouble(),
      snippet: json['snippet'] as String,
      source: json['source'] as String,
      timestamp: json['timestamp'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'keywords': instance.keywords,
      'language': instance.language,
      'publishedAt': instance.publishedAt,
      'sentimentGreaterThan': instance.sentimentGreaterThan,
      'sentimentLessThan': instance.sentimentLessThan,
      'snippet': instance.snippet,
      'source': instance.source,
      'timestamp': instance.timestamp,
      'title': instance.title,
      'url': instance.url,
    };
