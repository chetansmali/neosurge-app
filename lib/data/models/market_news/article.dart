import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';
@JsonSerializable()
class Article {
  String id;
  String uuid;
  String description;
  String imageUrl;
  String keywords;
  String language;
  int publishedAt;
  double sentimentGreaterThan;
  double sentimentLessThan;
  String snippet;
  String source;
  int timestamp;
  String title;
  String url;

  Article({
    required this.id,
    required this.uuid,
    required this.description,
    required this.imageUrl,
    required this.keywords,
    required this.language,
    required this.publishedAt,
    required this.sentimentGreaterThan,
    required this.sentimentLessThan,
    required this.snippet,
    required this.source,
    required this.timestamp,
    required this.title,
    required this.url,
  });


  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  Map<String,dynamic>toJson()=>_$ArticleToJson(this);
}
