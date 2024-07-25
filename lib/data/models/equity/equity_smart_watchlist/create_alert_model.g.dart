// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_alert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAlertModel _$CreateAlertModelFromJson(Map<String, dynamic> json) =>
    CreateAlertModel(
      id: json['id'] as String?,
      symbol: json['symbol'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      lastSevenDaysMovingAverageTrend:
          json['lastSevenDaysMovingAverageTrend'] as String?,
      userEmail: json['userEmail'] as String?,
      comparisonMetric: json['comparisonMetric'] as String?,
      lastTriggeredAt: json['lastTriggeredAt'] == null
          ? null
          : DateTime.parse(json['lastTriggeredAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      triggered: json['triggered'] as bool?,
    );

Map<String, dynamic> _$CreateAlertModelToJson(CreateAlertModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'price': instance.price,
      'lastSevenDaysMovingAverageTrend':
          instance.lastSevenDaysMovingAverageTrend,
      'userEmail': instance.userEmail,
      'comparisonMetric': instance.comparisonMetric,
      'lastTriggeredAt': instance.lastTriggeredAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'triggered': instance.triggered,
    };
