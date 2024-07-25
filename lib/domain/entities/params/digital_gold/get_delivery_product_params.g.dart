// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_delivery_product_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDeliveryProductParams _$GetDeliveryProductParamsFromJson(
        Map<String, dynamic> json) =>
    GetDeliveryProductParams(
      metalType: $enumDecode(_$MetalTypeEnumMap, json['metalType']),
    );

Map<String, dynamic> _$GetDeliveryProductParamsToJson(
        GetDeliveryProductParams instance) =>
    <String, dynamic>{
      'metalType': _$MetalTypeEnumMap[instance.metalType]!,
    };

const _$MetalTypeEnumMap = {
  MetalType.gold: 'gold',
  MetalType.silver: 'silver',
};
