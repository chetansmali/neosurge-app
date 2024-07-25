// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_cart_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToCartParams _$AddToCartParamsFromJson(Map<String, dynamic> json) =>
    AddToCartParams(
      purchaseType: $enumDecode(_$InvestmentTypeEnumMap, json['purchaseType']),
      schemeCode: json['schemeCode'] as String,
      amount: (json['amount'] as num).toDouble(),
      sipParams: json['sipObject'] == null
          ? null
          : SipParams.fromJson(json['sipObject'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddToCartParamsToJson(AddToCartParams instance) =>
    <String, dynamic>{
      'purchaseType':
          AddToCartParams.investmentTypeToJson(instance.purchaseType),
      'schemeCode': instance.schemeCode,
      'amount': instance.amount,
      'sipObject': instance.sipParams,
    };

const _$InvestmentTypeEnumMap = {
  InvestmentType.monthlySip: 'monthlySip',
  InvestmentType.lumpsum: 'lumpsum',
};

SipParams _$SipParamsFromJson(Map<String, dynamic> json) => SipParams(
      installments: json['installments'] as int,
      invDate: json['invDate'] as int,
    );

Map<String, dynamic> _$SipParamsToJson(SipParams instance) => <String, dynamic>{
      'installments': instance.installments,
      'invDate': instance.invDate,
    };
