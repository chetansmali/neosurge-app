import 'package:json_annotation/json_annotation.dart';

part 'nav_history.g.dart';

@JsonSerializable()
class NavHistory {
  final DateTime date;
  final double nav;

  NavHistory({required this.date, required this.nav});

  factory NavHistory.fromJson(Map<String, dynamic> json) =>
      _$NavHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$NavHistoryToJson(this);

  static List<NavHistory> listFromJson(List<dynamic> json) =>
      json.map((e) => NavHistory.fromJson(e)).toList();
}
