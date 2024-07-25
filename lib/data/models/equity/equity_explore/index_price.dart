import 'package:json_annotation/json_annotation.dart';
part 'index_price.g.dart';

@JsonSerializable()
class IndexPriceModel {
  final String symbolName;
  @JsonKey(fromJson: double.parse)
  final double close;
  @JsonKey(fromJson: double.parse)
  final double? oneDayChange;
  @JsonKey(fromJson: double.parse)
  final double? oneDayPercentChange;
  @JsonKey(fromJson: double.parse)
  final double? oneWeekChange;
  @JsonKey(fromJson: double.parse)
  final double? oneWeekPercentChange;
  @JsonKey(fromJson: double.parse)
  final double? oneMonthChange;
  @JsonKey(fromJson: double.parse)
  final double? oneMonthPercentChange;
  @JsonKey(fromJson: double.parse)
  final double? oneYearChange;
  @JsonKey(fromJson: double.parse)
  final double? oneYearPercentChange;

  IndexPriceModel({
    required this.symbolName,
    required this.close,
    required this.oneDayChange,
    required this.oneDayPercentChange,
    required this.oneWeekChange,
    required this.oneWeekPercentChange,
    required this.oneMonthChange,
    required this.oneMonthPercentChange,
    required this.oneYearChange,
    required this.oneYearPercentChange,
  });

  factory IndexPriceModel.fromJson(Map<String, dynamic> json) =>
      _$IndexPriceModelFromJson(json);

  Map<String, dynamic> toJson() => _$IndexPriceModelToJson(this);

  static List<IndexPriceModel> listFromJson(List<dynamic> json) =>
      json.map((e) => IndexPriceModel.fromJson(e)).toList();
}
