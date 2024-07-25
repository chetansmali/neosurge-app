// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mf_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MfOrder _$MfOrderFromJson(Map<String, dynamic> json) => MfOrder(
      orderType: $enumDecode(_$MFTransactionTypesEnumMap, json['orderType']),
      fundName: json['fundName'] as String?,
      folioNumber: json['folioNumber'] as String?,
      isin: json['isin'] as String,
      amount: (json['amount'] as num?)?.toDouble(),
      units: (json['units'] as num?)?.toDouble() ?? 0.0,
      orderId: json['orderId'] as String?,
      submittedAt: json['submittedAt'] == null
          ? null
          : DateTime.parse(json['submittedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      investedDate: json['investedDate'] == null
          ? null
          : DateTime.parse(json['investedDate'] as String),
      succeededAt: json['succeededAt'] == null
          ? null
          : DateTime.parse(json['succeededAt'] as String),
      failedAt: json['failedAt'] == null
          ? null
          : DateTime.parse(json['failedAt'] as String),
      status: $enumDecode(_$MFOrderStatusEnumMap, json['status']),
      mfOldId: json['mfOldId'] as int?,
      inFundName: json['inFundName'] as String?,
      outFundName: json['outFundName'] as String?,
    );

Map<String, dynamic> _$MfOrderToJson(MfOrder instance) => <String, dynamic>{
      'orderType': _$MFTransactionTypesEnumMap[instance.orderType]!,
      'fundName': instance.fundName,
      'folioNumber': instance.folioNumber,
      'isin': instance.isin,
      'amount': instance.amount,
      'units': instance.units,
      'orderId': instance.orderId,
      'submittedAt': instance.submittedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'investedDate': instance.investedDate?.toIso8601String(),
      'succeededAt': instance.succeededAt?.toIso8601String(),
      'failedAt': instance.failedAt?.toIso8601String(),
      'status': _$MFOrderStatusEnumMap[instance.status]!,
      'mfOldId': instance.mfOldId,
      'inFundName': instance.inFundName,
      'outFundName': instance.outFundName,
    };

const _$MFTransactionTypesEnumMap = {
  MFTransactionTypes.lumpsum: 1,
  MFTransactionTypes.sip: 2,
  MFTransactionTypes.redemption: 3,
  MFTransactionTypes.switchTransaction: 4,
  MFTransactionTypes.stp: 5,
  MFTransactionTypes.swp: 6,
  MFTransactionTypes.stopSip: 7,
  MFTransactionTypes.stopSwp: 8,
  MFTransactionTypes.assistedService: 9,
  MFTransactionTypes.basket: 10,
  MFTransactionTypes.cart: 11,
};

const _$MFOrderStatusEnumMap = {
  MFOrderStatus.pending: 'Pending',
  MFOrderStatus.success: 'Successful',
  MFOrderStatus.failed: 'Failed',
};
