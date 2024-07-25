// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assisted_service_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssistedServiceDetailsResponse _$AssistedServiceDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    AssistedServiceDetailsResponse(
      id: json['id'] as int,
      amount: (json['amount'] as num).toDouble(),
      tenure: json['tenure'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AssistedServiceDetailsResponseToJson(
        AssistedServiceDetailsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'tenure': instance.tenure,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
