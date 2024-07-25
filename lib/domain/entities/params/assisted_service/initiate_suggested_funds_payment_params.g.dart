// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initiate_suggested_funds_payment_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitiateSuggestedFundsPaymentParams
    _$InitiateSuggestedFundsPaymentParamsFromJson(Map<String, dynamic> json) =>
        InitiateSuggestedFundsPaymentParams(
          userId: json['userId'] as int,
          paymentType: json['paymentType'] as String? ?? "NETBANKING",
          euin: json['euin'] as String?,
          referenceCode: json['referenceCode'] as String?,
          ids: (json['ids'] as List<dynamic>).map((e) => e as int).toList(),
          isWeb: json['isWeb'] as bool? ?? false,
        );

Map<String, dynamic> _$InitiateSuggestedFundsPaymentParamsToJson(
        InitiateSuggestedFundsPaymentParams instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'paymentType': instance.paymentType,
      'euin': instance.euin,
      'referenceCode': instance.referenceCode,
      'ids': instance.ids,
      'isWeb': instance.isWeb,
    };
