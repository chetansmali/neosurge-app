import 'package:json_annotation/json_annotation.dart';

part 'filter_by_index_params.g.dart';

@JsonSerializable()
class FilterByIndexParams {
  final String index;
  final int? page;
  final int? size;
  final String? sort;
  final String? filter;

  FilterByIndexParams({
    required this.index,
    required this.page,
    required this.size,
    required this.sort,
    required this.filter,
  });

  factory FilterByIndexParams.fromJson(Map<String, dynamic> json) =>
      _$FilterByIndexParamsFromJson(json);

  Map<String, dynamic> toJson() => _$FilterByIndexParamsToJson(this);
}
