import 'package:json_annotation/json_annotation.dart';
part 'highlight.g.dart';

@JsonSerializable()
class Highlight {
  String highlight;
  double sentiment;

  Highlight({required this.highlight, required this.sentiment});

  factory Highlight.fromJson(Map<String, dynamic> json) => _$HighlightFromJson(json);

  Map<String,dynamic>toJson()=>_$HighlightToJson(this);
}
