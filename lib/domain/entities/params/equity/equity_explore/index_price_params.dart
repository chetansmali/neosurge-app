import 'package:json_annotation/json_annotation.dart';
part 'index_price_params.g.dart';

@JsonSerializable()
class IndexPriceParams {
  final List<String> indexes;

  IndexPriceParams(this.indexes);

  factory IndexPriceParams.fromJson(Map<String,dynamic>json) =>
      _$IndexPriceParamsFromJson(json);

  Map<String,dynamic> toJson() => _$IndexPriceParamsToJson(this);

  static List<IndexPriceParams> listFromJson(List<dynamic> json) =>
      json.map((e) => IndexPriceParams.fromJson(e)).toList();
}