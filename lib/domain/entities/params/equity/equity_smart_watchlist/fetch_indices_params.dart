import 'package:json_annotation/json_annotation.dart';

part 'fetch_indices_params.g.dart';

@JsonSerializable()
class FetchIndicesParams {
  final String page;
  final String size;
  final String sort;
  final String category;
  final String searchString;

  FetchIndicesParams(
      {required this.page,
      required this.size,
      required this.sort,
      required this.category,
      required this.searchString});

  factory FetchIndicesParams.fromJson(Map<String, dynamic> json) =>
      _$FetchIndicesParamsFromJson(json);
  Map<String, dynamic> toJson() => _$FetchIndicesParamsToJson(this);
}
