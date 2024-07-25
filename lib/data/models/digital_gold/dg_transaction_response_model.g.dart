// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dg_transaction_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DgTransactionResponseModel _$DgTransactionResponseModelFromJson(
        Map<String, dynamic> json) =>
    DgTransactionResponseModel(
      id: json['id'] as int,
      quantity: (json['quantity'] as num?)?.toDouble(),
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      metalType: $enumDecode(_$MetalTypeEnumMap, json['metalType']),
      rate: (json['rate'] as num).toDouble(),
      transactionId: json['transactionId'] as String?,
      status: $enumDecode(_$DgTransactionStatusEnumMap, json['status']),
      augmontStatus: json['augmontStatus'] as String,
      orderType: $enumDecode(_$DGOrderTypeEnumMap, json['orderType']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DgTransactionResponseModelToJson(
        DgTransactionResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'totalAmount': instance.totalAmount,
      'metalType': _$MetalTypeEnumMap[instance.metalType]!,
      'rate': instance.rate,
      'transactionId': instance.transactionId,
      'status': _$DgTransactionStatusEnumMap[instance.status]!,
      'augmontStatus': instance.augmontStatus,
      'orderType': _$DGOrderTypeEnumMap[instance.orderType]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$MetalTypeEnumMap = {
  MetalType.gold: 'gold',
  MetalType.silver: 'silver',
};

const _$DgTransactionStatusEnumMap = {
  DgTransactionStatus.success: 'SUCCESS',
  DgTransactionStatus.processing: 'PROCESSING',
  DgTransactionStatus.failure: 'FAILED',
  DgTransactionStatus.all: 'ALL',
};

const _$DGOrderTypeEnumMap = {
  DGOrderType.buy: 'BUY',
  DGOrderType.sell: 'SELL',
  DGOrderType.delivery: 'DELIVERY',
};
