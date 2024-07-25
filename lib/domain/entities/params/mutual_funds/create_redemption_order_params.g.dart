// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_redemption_order_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRedemptionOrderParams _$CreateRedemptionOrderParamsFromJson(
        Map<String, dynamic> json) =>
    CreateRedemptionOrderParams(
      userId: json['userId'] as int,
      paymentType: $enumDecode(_$MFPaymentTypesEnumMap, json['paymentType']),
      euin: json['euin'] as String?,
      isinCode: json['isinCode'] as String,
      fundName: json['fundName'] as String,
      fundAmount: (json['fundAmount'] as num?)?.toDouble(),
      fundUnits: (json['fundUnits'] as num?)?.toDouble(),
      folioNumber: json['folioNumber'] as String?,
      sourceRefId: json['sourceRefId'] as String?,
      userIp: json['userIp'] as String?,
      serverIp: json['serverIp'] as String?,
      isAssisted: json['isAssisted'] as bool? ?? false,
      isRedeemAll: json['isRedeemAll'] as bool? ?? false,
      transactionType: $enumDecodeNullable(
              _$MFTransactionTypesEnumMap, json['transactionTypeId']) ??
          MFTransactionTypes.redemption,
    );

Map<String, dynamic> _$CreateRedemptionOrderParamsToJson(
        CreateRedemptionOrderParams instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'transactionTypeId':
          _$MFTransactionTypesEnumMap[instance.transactionType]!,
      'paymentType': _$MFPaymentTypesEnumMap[instance.paymentType]!,
      'euin': instance.euin,
      'isinCode': instance.isinCode,
      'fundAmount': instance.fundAmount,
      'fundName': instance.fundName,
      'fundUnits': instance.fundUnits,
      'folioNumber': instance.folioNumber,
      'sourceRefId': instance.sourceRefId,
      'userIp': instance.userIp,
      'serverIp': instance.serverIp,
      'isAssisted': instance.isAssisted,
      'isRedeemAll': instance.isRedeemAll,
    };

const _$MFPaymentTypesEnumMap = {
  MFPaymentTypes.netbanking: 'NETBANKING',
  MFPaymentTypes.upi: 'UPI',
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
