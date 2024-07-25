import 'package:json_annotation/json_annotation.dart';
part 'add_stock_watchlist.g.dart';
@JsonSerializable()
class AddStockWatchlistParams{
  final int watchlistId;
  final String symbol;

  AddStockWatchlistParams({
    required this.watchlistId,
    required this.symbol,
});
  factory AddStockWatchlistParams.fromJson(Map<String, dynamic> json) =>
      _$AddStockWatchlistParamsFromJson(json);

  Map<String,dynamic> toJson() =>
      _$AddStockWatchlistParamsToJson(this);
}