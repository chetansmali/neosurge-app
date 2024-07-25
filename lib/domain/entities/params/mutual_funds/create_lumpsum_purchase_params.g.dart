// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_lumpsum_purchase_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateLumpsumPurchaseParams _$CreateLumpsumPurchaseParamsFromJson(
        Map<String, dynamic> json) =>
    CreateLumpsumPurchaseParams(
      userId: json['userId'] as String,
      fundPlanId: json['fundPlanId'] as String,
      fundAmount: (json['fundAmount'] as num).toDouble(),
      fundFolioNumber: json['fundFolioNumber'] as String?,
      isin: json['isin'] as String,
      nav: (json['nav'] as num).toDouble(),
      amcId: json['amcId'] as String,
      planName: json['planName'] as String,
      mfLumpsumConsentId: json['mfLumpsumConsentId'] as int,
      transactionType: $enumDecodeNullable(
              _$MFTransactionTypesEnumMap, json['transactionTypeId']) ??
          MFTransactionTypes.lumpsum,
    );

Map<String, dynamic> _$CreateLumpsumPurchaseParamsToJson(
        CreateLumpsumPurchaseParams instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'transactionTypeId':
          _$MFTransactionTypesEnumMap[instance.transactionType]!,
      'fundPlanId': instance.fundPlanId,
      'fundAmount': instance.fundAmount,
      'fundFolioNumber': instance.fundFolioNumber,
      'isin': instance.isin,
      'nav': instance.nav,
      'amcId': instance.amcId,
      'planName': instance.planName,
      'mfLumpsumConsentId': instance.mfLumpsumConsentId,
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
