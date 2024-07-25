// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_delivery_order_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateDeliveryOrderParams _$CreateDeliveryOrderParamsFromJson(
        Map<String, dynamic> json) =>
    CreateDeliveryOrderParams(
      metalType: $enumDecode(_$MetalTypeEnumMap, json['metalType']),
      transactionType: $enumDecode(_$DGTransactionTypeEnumMap, json['type']),
      shippingUserAddressId: json['shippingUserAddressId'] as String,
      billingUserAddressId: json['billingUserAddressId'] as String,
      isShippingSameAsBilling: json['isShippingSameAsBilling'] as bool,
      products: (json['product'] as List<dynamic>)
          .map((e) => DeliveryProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateDeliveryOrderParamsToJson(
        CreateDeliveryOrderParams instance) =>
    <String, dynamic>{
      'metalType': _$MetalTypeEnumMap[instance.metalType]!,
      'type': _$DGTransactionTypeEnumMap[instance.transactionType]!,
      'shippingUserAddressId': instance.shippingUserAddressId,
      'billingUserAddressId': instance.billingUserAddressId,
      'isShippingSameAsBilling': instance.isShippingSameAsBilling,
      'product': instance.products.map((e) => e.toJson()).toList(),
    };

const _$MetalTypeEnumMap = {
  MetalType.gold: 'gold',
  MetalType.silver: 'silver',
};

const _$DGTransactionTypeEnumMap = {
  DGTransactionType.buy: 'buy',
  DGTransactionType.sell: 'sell',
  DGTransactionType.delivery: 'delivery',
  DGTransactionType.buySell: 'buy/sell',
};
