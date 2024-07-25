import 'package:json_annotation/json_annotation.dart';

part 'global_search_model.g.dart';

@JsonSerializable()
class GlobalSearchModel{
  final String symbol;
  final String exchange;
  final String country;
  final String currency;
  final String? instrumentName;
  final String? micCode;
  final String? exchangeTimezone;
  final String? instrumentType;

  GlobalSearchModel({
    required this.symbol,
    required this.exchange,
    required this.country,
    required this.currency,
    required this.instrumentName,
    required this.micCode,
    required this.exchangeTimezone,
    required this.instrumentType,
  });

  factory GlobalSearchModel.fromJson(Map<String, dynamic> json) =>
      _$GlobalSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$GlobalSearchModelToJson(this);

  static List<GlobalSearchModel> listFromJson(List<dynamic> json) =>
      json.map((e) => GlobalSearchModel.fromJson(e)).toList();

}
