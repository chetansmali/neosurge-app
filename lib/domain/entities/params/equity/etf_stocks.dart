import 'package:json_annotation/json_annotation.dart';
part 'etf_stocks.g.dart';

@JsonSerializable()
class ETFStocksParams {
  final String? sort;
  final String? filter;
  final String? size;
  final String? page;

  ETFStocksParams({
    this.sort,
    this.filter,
    this.size,
    this.page,
  });

  factory ETFStocksParams.fromJson(Map<String, dynamic> json) =>
      _$ETFStocksParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ETFStocksParamsToJson(this);
}
