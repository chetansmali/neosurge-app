// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equity_brokers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrokersModel _$BrokersModelFromJson(Map<String, dynamic> json) => BrokersModel(
      id: json['id'] as String,
      broker: json['broker'] as String,
      icon: json['icon'] as String,
      key: json['key'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$BrokersModelToJson(BrokersModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'broker': instance.broker,
      'icon': instance.icon,
      'key': instance.key,
      'name': instance.name,
    };
