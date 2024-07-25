// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_delivery_order_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutDeliveryOrderParams _$CheckoutDeliveryOrderParamsFromJson(
        Map<String, dynamic> json) =>
    CheckoutDeliveryOrderParams(
      shippingUserAddressId: json['shippingUserAddressId'] as String,
      billingUserAddressId: json['billingUserAddressId'] as String,
      isShippingSameAsBilling: json['isShippingSameAsBilling'] as bool,
      products: (json['product'] as List<dynamic>)
          .map((e) => DeliveryProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckoutDeliveryOrderParamsToJson(
        CheckoutDeliveryOrderParams instance) =>
    <String, dynamic>{
      'shippingUserAddressId': instance.shippingUserAddressId,
      'billingUserAddressId': instance.billingUserAddressId,
      'isShippingSameAsBilling': instance.isShippingSameAsBilling,
      'product': instance.products.map((e) => e.toJson()).toList(),
    };

DeliveryProduct _$DeliveryProductFromJson(Map<String, dynamic> json) =>
    DeliveryProduct(
      sku: json['sku'] as String,
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$DeliveryProductToJson(DeliveryProduct instance) =>
    <String, dynamic>{
      'sku': instance.sku,
      'quantity': instance.quantity,
    };
