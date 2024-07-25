// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_switch_order_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateSwitchOrderParams _$CreateSwitchOrderParamsFromJson(
        Map<String, dynamic> json) =>
    CreateSwitchOrderParams(
      userId: json['userId'] as int,
      fundAmount: (json['fundAmount'] as num?)?.toDouble(),
      units: (json['units'] as num?)?.toDouble(),
      folioNumber: json['folioNumber'] as String,
      nav: (json['nav'] as num).toDouble(),
      schemeOutIsin: json['schemeOutIsin'] as String,
      schemeInIsin: json['schemeInIsin'] as String,
      schemeOutFundPlanId: json['schemeOutFundPlanId'] as String,
      schemeInFundPlanId: json['schemeInFundPlanId'] as String,
      switchOutMinAmt: (json['switchOutMinAmt'] as num).toDouble(),
      switchInAllowed: json['switchInAllowed'] as bool,
      switchInSchemeName: json['switchInSchemeName'] as String,
      switchOutSchemeName: json['switchOutSchemeName'] as String,
      switchInImgUrl: json['switchInImgUrl'] as String,
      switchOutImgUrl: json['switchOutImgUrl'] as String,
      transactionType: $enumDecodeNullable(
              _$MFTransactionTypesEnumMap, json['transactionTypeId']) ??
          MFTransactionTypes.switchTransaction,
      isAssisted: json['isAssisted'] as bool? ?? false,
    );

Map<String, dynamic> _$CreateSwitchOrderParamsToJson(
        CreateSwitchOrderParams instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'transactionTypeId':
          _$MFTransactionTypesEnumMap[instance.transactionType]!,
      'fundAmount': instance.fundAmount,
      'units': instance.units,
      'folioNumber': instance.folioNumber,
      'nav': instance.nav,
      'schemeOutIsin': instance.schemeOutIsin,
      'schemeInIsin': instance.schemeInIsin,
      'schemeOutFundPlanId': instance.schemeOutFundPlanId,
      'schemeInFundPlanId': instance.schemeInFundPlanId,
      'switchOutMinAmt': instance.switchOutMinAmt,
      'switchInAllowed': instance.switchInAllowed,
      'switchInSchemeName': instance.switchInSchemeName,
      'switchOutSchemeName': instance.switchOutSchemeName,
      'switchInImgUrl': instance.switchInImgUrl,
      'switchOutImgUrl': instance.switchOutImgUrl,
      'isAssisted': instance.isAssisted,
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
