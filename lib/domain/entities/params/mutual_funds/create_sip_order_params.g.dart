// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_sip_order_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateSipOrderParams _$CreateSipOrderParamsFromJson(
        Map<String, dynamic> json) =>
    CreateSipOrderParams(
      userId: json['userId'] as int,
      fundPlanId: json['fundPlanId'] as String,
      fundAmount: (json['fundAmount'] as num).toDouble(),
      fundSubPlanId: json['fundSubPlanId'] as String?,
      fundFolioNumber: json['fundFolioNumber'] as String?,
      numberOfInstallments: json['numberOfInstallments'] as int,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String?,
      isin: json['isin'] as String,
      nav: (json['nav'] as num).toDouble(),
      frequency: json['frequency'] as String? ?? "MONTHLY",
      transactionType: $enumDecodeNullable(
              _$MFTransactionTypesEnumMap, json['transactionTypeId']) ??
          MFTransactionTypes.sip,
      isWeb: json['isWeb'] as bool? ?? false,
      amcId: json['amcId'] as String,
      planName: json['planName'] as String,
      mfSipConsentId: json['mfSipConsentId'] as int,
    );

Map<String, dynamic> _$CreateSipOrderParamsToJson(
        CreateSipOrderParams instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'transactionTypeId':
          _$MFTransactionTypesEnumMap[instance.transactionType]!,
      'fundPlanId': instance.fundPlanId,
      'fundAmount': instance.fundAmount,
      'fundSubPlanId': instance.fundSubPlanId,
      'fundFolioNumber': instance.fundFolioNumber,
      'numberOfInstallments': instance.numberOfInstallments,
      'frequency': instance.frequency,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'isin': instance.isin,
      'nav': instance.nav,
      'isWeb': instance.isWeb,
      'amcId': instance.amcId,
      'planName': instance.planName,
      'mfSipConsentId': instance.mfSipConsentId,
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
