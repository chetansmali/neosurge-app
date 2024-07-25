import 'package:json_annotation/json_annotation.dart';

part 'stock_details_params.g.dart';

@JsonSerializable()
class StockDetailsParams {
  final String symbol;


  StockDetailsParams({required this.symbol});

  factory StockDetailsParams.fromJson(Map<String,dynamic> json) => _$StockDetailsParamsFromJson(json);

  Map<String,dynamic> toJson() => _$StockDetailsParamsToJson(this);
}