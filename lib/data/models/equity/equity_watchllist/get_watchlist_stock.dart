import 'package:json_annotation/json_annotation.dart';
part 'get_watchlist_stock.g.dart';

@JsonSerializable()
class WatchlistStocksModel {
  final int? watchlistId;
  final int? watchlistContentId;
  final String? symbol;
  final String? companyName;
  final double? close;
  final double? change;
  final double? percentChange;
  final String? icon;
  final int? quantity;

  WatchlistStocksModel({
    required this.watchlistId,
    required this.watchlistContentId,
    required this.symbol,
    required this.companyName,
    required this.close,
    required this.change,
    required this.percentChange,
    required this.icon,
    required this.quantity,
  });
  factory WatchlistStocksModel.fromJson(Map<String, dynamic> json) =>
      _$WatchlistStocksModelFromJson(json);

  Map<String, dynamic> toJson() => _$WatchlistStocksModelToJson(this);

  static List<WatchlistStocksModel> listFromJson(List<dynamic> json) =>
      json.map((e) => WatchlistStocksModel.fromJson(e)).toList();
}
