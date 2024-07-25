// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_swp_order_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateSwpOrderParams _$CreateSwpOrderParamsFromJson(
        Map<String, dynamic> json) =>
    CreateSwpOrderParams(
      userId: json['userId'] as int,
      transactionType: $enumDecodeNullable(
              _$MFTransactionTypesEnumMap, json['transactionTypeId']) ??
          MFTransactionTypes.swp,
      fundAmount: (json['fundAmount'] as num).toDouble(),
      folioNumber: json['folioNumber'] as String,
      isin: json['isin'] as String,
      fundPlanId: json['fundPlanId'] as String,
      schemeName: json['schemeName'] as String,
      imgUrl: json['imgUrl'] as String,
      minSwpAmount: (json['minSwpAmount'] as num).toDouble(),
      maxSwpAmount: (json['maxSwpAmount'] as num).toDouble(),
      numberOfInstallments: json['numberOfInstallments'] as int,
      frequency: json['frequency'] as String? ?? 'MONTHLY',
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      swpAllowed: json['swpAllowed'] as bool,
    );

Map<String, dynamic> _$CreateSwpOrderParamsToJson(
        CreateSwpOrderParams instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'transactionTypeId':
          _$MFTransactionTypesEnumMap[instance.transactionType]!,
      'fundAmount': instance.fundAmount,
      'folioNumber': instance.folioNumber,
      'isin': instance.isin,
      'fundPlanId': instance.fundPlanId,
      'schemeName': instance.schemeName,
      'imgUrl': instance.imgUrl,
      'minSwpAmount': instance.minSwpAmount,
      'maxSwpAmount': instance.maxSwpAmount,
      'numberOfInstallments': instance.numberOfInstallments,
      'frequency': instance.frequency,
      'startDate': CreateSwpOrderParams._dateTimeToString(instance.startDate),
      'endDate': instance.endDate?.toIso8601String(),
      'swpAllowed': instance.swpAllowed,
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
