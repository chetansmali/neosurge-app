// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_stp_order_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateStpOrderParams _$CreateStpOrderParamsFromJson(
        Map<String, dynamic> json) =>
    CreateStpOrderParams(
      userId: json['userId'] as int,
      transactionType: $enumDecodeNullable(
              _$MFTransactionTypesEnumMap, json['transactionTypeId']) ??
          MFTransactionTypes.stp,
      fundAmount: (json['fundAmount'] as num).toDouble(),
      folioNumber: json['folioNumber'] as String,
      frequency: json['frequency'] as String? ?? "MONTHLY",
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      fpMaxStpInAmount: (json['fpMaxStpInAmount'] as num).toDouble(),
      fpMinStpInAmount: (json['fpMinStpInAmount'] as num).toDouble(),
      numberOfInstallments: json['numberOfInstallments'] as int,
      switchInPlan: json['switchInPlan'] as String,
      switchOutPlan: json['switchOutPlan'] as String,
      fpStpInAllowed: json['fpStpInAllowed'] as bool,
      switchInisin: json['switchInisin'] as String,
      switchOutisin: json['switchOutisin'] as String,
      switchInSchemeName: json['switchInSchemeName'] as String,
      switchOutSchemeName: json['switchOutSchemeName'] as String,
      switchInImgUrl: json['switchInImgUrl'] as String,
      switchOutImgUrl: json['switchOutImgUrl'] as String,
    );

Map<String, dynamic> _$CreateStpOrderParamsToJson(
        CreateStpOrderParams instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'transactionTypeId':
          _$MFTransactionTypesEnumMap[instance.transactionType]!,
      'fundAmount': instance.fundAmount,
      'folioNumber': instance.folioNumber,
      'frequency': instance.frequency,
      'startDate': CreateStpOrderParams._dateTimeToString(instance.startDate),
      'endDate': instance.endDate?.toIso8601String(),
      'fpMaxStpInAmount': instance.fpMaxStpInAmount,
      'fpMinStpInAmount': instance.fpMinStpInAmount,
      'numberOfInstallments': instance.numberOfInstallments,
      'switchInPlan': instance.switchInPlan,
      'switchOutPlan': instance.switchOutPlan,
      'fpStpInAllowed': instance.fpStpInAllowed,
      'switchInisin': instance.switchInisin,
      'switchOutisin': instance.switchOutisin,
      'switchInSchemeName': instance.switchInSchemeName,
      'switchOutSchemeName': instance.switchOutSchemeName,
      'switchInImgUrl': instance.switchInImgUrl,
      'switchOutImgUrl': instance.switchOutImgUrl,
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
