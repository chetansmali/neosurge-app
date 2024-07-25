// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unlock_assisted_service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnlockAssistedServiceResponse _$UnlockAssistedServiceResponseFromJson(
        Map<String, dynamic> json) =>
    UnlockAssistedServiceResponse(
      key: json['key'] as String,
      amount: json['amount'] as String,
      orderId: json['orderId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      contact: json['contact'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$UnlockAssistedServiceResponseToJson(
        UnlockAssistedServiceResponse instance) =>
    <String, dynamic>{
      'key': instance.key,
      'amount': instance.amount,
      'orderId': instance.orderId,
      'name': instance.name,
      'description': instance.description,
      'contact': instance.contact,
      'email': instance.email,
    };
