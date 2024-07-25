import 'package:json_annotation/json_annotation.dart';

part 'all_stocks.g.dart';

@JsonSerializable()
class AllStocksModel {
  final String? id;
  final String? symbol;
  final String? companyName;
  final String? industry;
  final double? close;
  final double? change;
  final double? percentChange;
  final String? isinCode;
  final String? icon;

  AllStocksModel({
    required this.id,
    required this.symbol,
    required this.companyName,
    required this.industry,
    required this.close,
    required this.change,
    required this.percentChange,
    required this.icon,
    required this.isinCode,
  });

  factory AllStocksModel.fromJson(Map<String, dynamic> json) =>
      _$AllStocksModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllStocksModelToJson(this);

  static List<AllStocksModel> listFromJson(List<dynamic> json) =>
      json.map((e) => AllStocksModel.fromJson(e)).toList();
}
