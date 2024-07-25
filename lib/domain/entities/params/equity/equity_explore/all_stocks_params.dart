import 'package:json_annotation/json_annotation.dart';
part 'all_stocks_params.g.dart';

@JsonSerializable(
  includeIfNull: false,
)
class AllStocksParams {
  final String? sortBy;
  final String? direction;
  final String? filter;
  final String? industries;
  final String size;
  final String page;

  AllStocksParams(
      {required this.sortBy,
      required this.direction,
      required this.filter,
      required this.industries,
      required this.size,
      required this.page});

  factory AllStocksParams.fromJson(Map<String, dynamic> json) =>
      _$AllStocksParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AllStocksParamsToJson(this);
}
