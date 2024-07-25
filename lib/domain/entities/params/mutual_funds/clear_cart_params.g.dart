// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clear_cart_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClearCartParams _$ClearCartParamsFromJson(Map<String, dynamic> json) =>
    ClearCartParams(
      purchaseType: $enumDecode(_$InvestmentTypeEnumMap, json['purchaseType']),
    );

Map<String, dynamic> _$ClearCartParamsToJson(ClearCartParams instance) =>
    <String, dynamic>{
      'purchaseType':
          ClearCartParams.investmentTypeToJson(instance.purchaseType),
    };

const _$InvestmentTypeEnumMap = {
  InvestmentType.monthlySip: 'monthlySip',
  InvestmentType.lumpsum: 'lumpsum',
};
