// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initiate_lumpsum_purchase_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitiateLumpsumPurchaseParams _$InitiateLumpsumPurchaseParamsFromJson(
        Map<String, dynamic> json) =>
    InitiateLumpsumPurchaseParams(
      userId: json['userId'] as int,
      paymentType: $enumDecode(_$MFPaymentTypesEnumMap, json['paymentType']),
      id: json['id'] as int,
      euin: json['euin'] as String?,
      referenceCode: json['referenceCode'] as String?,
      isWeb: json['isWeb'] as bool? ?? false,
    );

Map<String, dynamic> _$InitiateLumpsumPurchaseParamsToJson(
        InitiateLumpsumPurchaseParams instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'paymentType': _$MFPaymentTypesEnumMap[instance.paymentType]!,
      'euin': instance.euin,
      'referenceCode': instance.referenceCode,
      'id': instance.id,
      'isWeb': instance.isWeb,
    };

const _$MFPaymentTypesEnumMap = {
  MFPaymentTypes.netbanking: 'NETBANKING',
  MFPaymentTypes.upi: 'UPI',
};
