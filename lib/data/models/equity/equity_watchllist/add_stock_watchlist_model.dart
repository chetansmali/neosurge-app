import 'package:json_annotation/json_annotation.dart';
part 'add_stock_watchlist_model.g.dart';
@JsonSerializable()
class AddStockWatchModel{
  final int id;
  final String symbol;

  AddStockWatchModel({
    required this.id,
    required this.symbol,
});
  factory AddStockWatchModel.fromJson(Map<String, dynamic> json) =>
      _$AddStockWatchModelFromJson(json);

  Map<String,dynamic> toJson() =>
      _$AddStockWatchModelToJson(this);
}