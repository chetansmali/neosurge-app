// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_sell_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuySellTransationModel _$BuySellTransationModelFromJson(
        Map<String, dynamic> json) =>
    BuySellTransationModel(
      transactionId: json['transactionId'] as String,
      success: json['success'] as bool,
    );

Map<String, dynamic> _$BuySellTransationModelToJson(
        BuySellTransationModel instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'success': instance.success,
    };
