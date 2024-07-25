import 'package:json_annotation/json_annotation.dart';
part 'get_watchlist_symbol.g.dart';
@JsonSerializable()
class GetWatchlistSymbolParams{
  final String id;

  GetWatchlistSymbolParams({
    required this.id,
});
  factory GetWatchlistSymbolParams.fromJson(Map<String, dynamic> json) =>
      _$GetWatchlistSymbolParamsFromJson(json);

  Map<String,dynamic> toJson() =>
      _$GetWatchlistSymbolParamsToJson(this);
}