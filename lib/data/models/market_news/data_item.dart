import 'package:json_annotation/json_annotation.dart';

import 'article.dart';
import 'featured_highlight.dart';

part 'data_item.g.dart';
@JsonSerializable()
class DataItem {
  Article article;
  FeaturedHighlight featuredHighlight;

  DataItem({required this.article, required this.featuredHighlight});

  factory DataItem.fromJson(Map<String, dynamic> json) => _$DataItemFromJson(json);

  Map<String,dynamic>toJson()=>_$DataItemToJson(this);
}
