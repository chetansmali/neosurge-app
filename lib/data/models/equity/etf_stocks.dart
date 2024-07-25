import 'package:json_annotation/json_annotation.dart';
part 'etf_stocks.g.dart';

@JsonSerializable()
class ETFStocksModel {
  final String? id;
  final String? symbol;
  final String? name;
  final String? icon;
  final DateTime? updatedAt;
  final double? change;
  final double? close;
  final double? percentChange;

  ETFStocksModel({
    this.id,
    this.symbol,
    this.name,
    this.icon,
    this.updatedAt,
    this.change,
    this.close,
    this.percentChange,
  });

  factory ETFStocksModel.fromJson(Map<String, dynamic> json) =>
      _$ETFStocksModelFromJson(json);

  Map<String, dynamic> toJson() => _$ETFStocksModelToJson(this);

  static List<ETFStocksModel> listFromJson(List<dynamic> json) =>
      json.map((e) => ETFStocksModel.fromJson(e)).toList();
}
