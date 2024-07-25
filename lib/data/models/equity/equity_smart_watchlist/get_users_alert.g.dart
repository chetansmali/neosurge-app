// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_users_alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserAlertModel _$GetUserAlertModelFromJson(Map<String, dynamic> json) =>
    GetUserAlertModel(
      content: (json['content'] as List<dynamic>)
          .map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList(),
      last: json['last'] as bool?,
      totalElements: json['totalElements'] as int?,
      totalPages: json['totalPages'] as int?,
      numberOfElements: json['numberOfElements'] as int?,
      first: json['first'] as bool?,
      size: json['size'] as int?,
      number: json['number'] as int?,
      empty: json['empty'] as bool?,
    );

Map<String, dynamic> _$GetUserAlertModelToJson(GetUserAlertModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'last': instance.last,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'numberOfElements': instance.numberOfElements,
      'first': instance.first,
      'size': instance.size,
      'number': instance.number,
      'empty': instance.empty,
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      id: json['id'] as String?,
      symbol: json['symbol'] as String?,
      icon: json['icon'] as String?,
      companyName: json['companyName'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      lastSevenDaysMovingAverageTrend:
          json['lastSevenDaysMovingAverageTrend'] as String?,
      userEmail: json['userEmail'] as String?,
      comparisonMetric: json['comparisonMetric'] as String?,
      lastTriggeredAt: json['lastTriggeredAt'] as String?,
      industry: json['industry'] as String?,
      sector: json['sector'] as String?,
      close: (json['close'] as num?)?.toDouble(),
      change: (json['change'] as num?)?.toDouble(),
      percentChange: (json['percentChange'] as num?)?.toDouble(),
      quantity: json['quantity'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      triggered: json['triggered'] as bool?,
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'icon': instance.icon,
      'companyName': instance.companyName,
      'price': instance.price,
      'lastSevenDaysMovingAverageTrend':
          instance.lastSevenDaysMovingAverageTrend,
      'userEmail': instance.userEmail,
      'comparisonMetric': instance.comparisonMetric,
      'lastTriggeredAt': instance.lastTriggeredAt,
      'industry': instance.industry,
      'sector': instance.sector,
      'close': instance.close,
      'change': instance.change,
      'percentChange': instance.percentChange,
      'createdAt': instance.createdAt,
      'quantity': instance.quantity,
      'updatedAt': instance.updatedAt,
      'triggered': instance.triggered,
    };
