// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionParams _$TransactionParamsFromJson(Map<String, dynamic> json) =>
    TransactionParams(
      email: json['email'] as String,
      broker: json['broker'] as String,
    );

Map<String, dynamic> _$TransactionParamsToJson(TransactionParams instance) =>
    <String, dynamic>{
      'email': instance.email,
      'broker': instance.broker,
    };
