import 'package:json_annotation/json_annotation.dart';

import 'entity.dart';
import 'highlight.dart';
part 'featured_highlight.g.dart';
@JsonSerializable()
class FeaturedHighlight {
  Entity entity;
  Highlight highlight;

  FeaturedHighlight({required this.entity, required this.highlight});


  factory FeaturedHighlight.fromJson(Map<String, dynamic> json) => _$FeaturedHighlightFromJson(json);

  Map<String,dynamic>toJson()=>_$FeaturedHighlightToJson(this);
}
