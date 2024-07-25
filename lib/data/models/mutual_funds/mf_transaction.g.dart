// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mf_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MfTransaction _$MfTransactionFromJson(Map<String, dynamic> json) =>
    MfTransaction(
      cagr: (json['cagr'] as num).toDouble(),
      avgNav: (json['avgNav'] as num).toDouble(),
      transactionHistory: (json['transactionHistory'] as List<dynamic>)
          .map((e) => TransactionHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MfTransactionToJson(MfTransaction instance) =>
    <String, dynamic>{
      'cagr': instance.cagr,
      'avgNav': instance.avgNav,
      'transactionHistory': instance.transactionHistory,
    };

TransactionHistory _$TransactionHistoryFromJson(Map<String, dynamic> json) =>
    TransactionHistory(
      object: json['object'] as String,
      folioNumber: json['folioNumber'] as String,
      isin: json['isin'] as String,
      type: $enumDecode(_$FundTransactionTypeStringEnumMap, json['type']),
      amount: (json['amount'] as num).toDouble(),
      units: (json['units'] as num).toDouble(),
      tradedOn: DateTime.parse(json['tradedOn'] as String),
      tradedAt: (json['tradedAt'] as num).toDouble(),
      order: json['order'] as String,
      corporateAction: json['corporateAction'] as String?,
      relatedTransactionId: json['relatedTransactionId'] as String?,
      rtaOrderReference: json['rtaOrderReference'] as String,
      rtaProductCode: json['rtaProductCode'] as String,
      rtaInvestmentOption: json['rtaInvestmentOption'] as String,
      rtaSchemeName: json['rtaSchemeName'] as String,
      sources: json['sources'] as List<dynamic>,
    );

Map<String, dynamic> _$TransactionHistoryToJson(TransactionHistory instance) =>
    <String, dynamic>{
      'object': instance.object,
      'folioNumber': instance.folioNumber,
      'isin': instance.isin,
      'type': _$FundTransactionTypeStringEnumMap[instance.type]!,
      'amount': instance.amount,
      'units': instance.units,
      'tradedOn': instance.tradedOn.toIso8601String(),
      'tradedAt': instance.tradedAt,
      'order': instance.order,
      'corporateAction': instance.corporateAction,
      'relatedTransactionId': instance.relatedTransactionId,
      'rtaOrderReference': instance.rtaOrderReference,
      'rtaProductCode': instance.rtaProductCode,
      'rtaInvestmentOption': instance.rtaInvestmentOption,
      'rtaSchemeName': instance.rtaSchemeName,
      'sources': instance.sources,
    };

const _$FundTransactionTypeStringEnumMap = {
  FundTransactionTypeString.invest: 'purchase',
  FundTransactionTypeString.redemption: 'redemption',
};
