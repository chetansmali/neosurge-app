import 'package:json_annotation/json_annotation.dart';
part 'smart_watchlist_search_model.g.dart';

@JsonSerializable()
class SmartWatchlistSearchModel {
  final String? id;
  final String? symbol;
  final String? companyName;
  final String? industry;
  final double? close;
  final double? change;
  final double? percentChange;
  final String? icon;

  SmartWatchlistSearchModel({
    required this.id,
    required this.symbol,
    required this.companyName,
    required this.industry,
    required this.close,
    required this.change,
    required this.percentChange,
    required this.icon,
  });

  factory SmartWatchlistSearchModel.fromJson(Map<String, dynamic> json) =>
      _$SmartWatchlistSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$SmartWatchlistSearchModelToJson(this);

  static List<SmartWatchlistSearchModel> listFromJson(List<dynamic> json) =>
      json.map((e) => SmartWatchlistSearchModel.fromJson(e)).toList();
}
