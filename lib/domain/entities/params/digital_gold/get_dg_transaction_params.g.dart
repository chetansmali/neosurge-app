// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_dg_transaction_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDGTransactionParams _$GetDGTransactionParamsFromJson(
        Map<String, dynamic> json) =>
    GetDGTransactionParams(
      status: $enumDecode(_$DgTransactionStatusEnumMap, json['status']),
      limit: json['limit'] as int? ?? 10,
      from: json['from'] as int? ?? 1,
      type: $enumDecodeNullable(_$DGTransactionTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$GetDGTransactionParamsToJson(
        GetDGTransactionParams instance) =>
    <String, dynamic>{
      'status': _$DgTransactionStatusEnumMap[instance.status]!,
      'limit': instance.limit,
      'from': instance.from,
      'type': _$DGTransactionTypeEnumMap[instance.type],
    };

const _$DgTransactionStatusEnumMap = {
  DgTransactionStatus.success: 'SUCCESS',
  DgTransactionStatus.processing: 'PROCESSING',
  DgTransactionStatus.failure: 'FAILED',
  DgTransactionStatus.all: 'ALL',
};

const _$DGTransactionTypeEnumMap = {
  DGTransactionType.buy: 'buy',
  DGTransactionType.sell: 'sell',
  DGTransactionType.delivery: 'delivery',
  DGTransactionType.buySell: 'buy/sell',
};
