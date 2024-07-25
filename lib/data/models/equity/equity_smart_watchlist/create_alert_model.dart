import 'package:json_annotation/json_annotation.dart';
part 'create_alert_model.g.dart';

@JsonSerializable()
class CreateAlertModel {
  final String? id;
  final String? symbol;
  final double? price;
  final String? lastSevenDaysMovingAverageTrend;
  final String? userEmail;
  final String? comparisonMetric;
  final DateTime? lastTriggeredAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? triggered;

  CreateAlertModel({
    required this.id,
    required this.symbol,
    required this.price,
    required this.lastSevenDaysMovingAverageTrend,
    required this.userEmail,
    required this.comparisonMetric,
    required this.lastTriggeredAt,
    required this.createdAt,
    required this.updatedAt,
    required this.triggered,
  });

  factory CreateAlertModel.fromJson(Map<String, dynamic> json) =>
      _$CreateAlertModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAlertModelToJson(this);
}
