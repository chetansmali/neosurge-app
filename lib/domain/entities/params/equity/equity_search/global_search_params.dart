import 'package:json_annotation/json_annotation.dart';
part 'global_search_params.g.dart';
@JsonSerializable()
class GlobalSearchParams{
  final String symbol;

  GlobalSearchParams({
    required this.symbol,
});
  factory GlobalSearchParams.fromJson(Map<String, dynamic> json) =>
      _$GlobalSearchParamsFromJson(json);

  Map<String,dynamic> toJson() =>
      _$GlobalSearchParamsToJson(this);
}