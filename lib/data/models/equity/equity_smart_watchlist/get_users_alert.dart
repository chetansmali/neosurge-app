import 'package:json_annotation/json_annotation.dart';
part 'get_users_alert.g.dart';

@JsonSerializable()
class GetUserAlertModel {
  final List<Content> content;
  final bool? last;
  final int? totalElements;
  final int? totalPages;
  final int? numberOfElements;
  final bool? first;
  final int? size;
  final int? number;
  final bool? empty;

  GetUserAlertModel({
    required this.content,
    required this.last,
    required this.totalElements,
    required this.totalPages,
    required this.numberOfElements,
    required this.first,
    required this.size,
    required this.number,
    required this.empty,
  });

  factory GetUserAlertModel.fromJson(Map<String, dynamic> json) =>
      _$GetUserAlertModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserAlertModelToJson(this);
}

@JsonSerializable()
class Content {
  final String? id;
  final String? symbol;
  final String? icon;
  final String? companyName;
  final double? price;
  final String? lastSevenDaysMovingAverageTrend;
  final String? userEmail;
  final String? comparisonMetric;
  final String? lastTriggeredAt;
  final String? industry;
  final String? sector;
  final double? close;
  final double? change;
  final double? percentChange;
  final String? createdAt;
  final int? quantity;
  final String? updatedAt;
  final bool? triggered;

  Content({
    required this.id,
    required this.symbol,
    required this.icon,
    required this.companyName,
    required this.price,
    required this.lastSevenDaysMovingAverageTrend,
    required this.userEmail,
    required this.comparisonMetric,
    required this.lastTriggeredAt,
    required this.industry,
    required this.sector,
    required this.close,
    required this.change,
    required this.percentChange,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.triggered,
  });
  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);

  static List<Content> listFromJson(List<dynamic> json) =>
      json.map((e) => Content.fromJson(e)).toList();
}
