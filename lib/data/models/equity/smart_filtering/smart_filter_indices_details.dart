import 'package:json_annotation/json_annotation.dart';

part 'smart_filter_indices_details.g.dart';

@JsonSerializable()
class SmartFilterIndicesDetails {
  List<IndexDetails> indices;
  List<String> availableCategories;

  SmartFilterIndicesDetails(
      {required this.indices, required this.availableCategories});

  factory SmartFilterIndicesDetails.fromJson(Map<String, dynamic> json) =>
      _$SmartFilterIndicesDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$SmartFilterIndicesDetailsToJson(this);
}

@JsonSerializable()
class IndexDetails {
  String id;
  String symbol;
  @JsonKey(fromJson: double.parse)
  double close;
  String name;
  String category;
  @JsonKey(fromJson: double.parse)
  double oneDayChange;
  @JsonKey(fromJson: double.parse)
  double oneDayPercentChange;
  @JsonKey(fromJson: double.parse)
  double oneWeekChange;
  @JsonKey(fromJson: double.parse)
  double oneWeekPercentChange;
  @JsonKey(fromJson: double.parse)
  double oneMonthChange;
  @JsonKey(fromJson: double.parse)
  double oneMonthPercentChange;
  @JsonKey(fromJson: double.parse)
  double oneYearChange;
  @JsonKey(fromJson: double.parse)
  double oneYearPercentChange;
  bool active;

  IndexDetails({
    required this.id,
    required this.symbol,
    required this.close,
    required this.name,
    required this.category,
    required this.oneDayChange,
    required this.oneDayPercentChange,
    required this.oneWeekChange,
    required this.oneWeekPercentChange,
    required this.oneMonthChange,
    required this.oneMonthPercentChange,
    required this.oneYearChange,
    required this.oneYearPercentChange,
    required this.active,
  });

  factory IndexDetails.fromJson(Map<String, dynamic> json) =>
      _$IndexDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$IndexDetailsToJson(this);
}
