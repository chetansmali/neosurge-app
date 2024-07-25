// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_payment_delivery_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostPaymentDeliveryParams _$PostPaymentDeliveryParamsFromJson(
        Map<String, dynamic> json) =>
    PostPaymentDeliveryParams(
      orderId: json['orderId'] as String,
      paymentId: json['paymentId'] as String,
      status: json['status'] as String,
      shippingUserAddressId: json['shippingUserAddressId'] as String,
      billingUserAddressId: json['billingUserAddressId'] as String,
      isShippingSameAsBilling: json['isShippingSameAsBilling'] as bool,
      products: (json['product'] as List<dynamic>)
          .map((e) => DeliveryProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostPaymentDeliveryParamsToJson(
        PostPaymentDeliveryParams instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'paymentId': instance.paymentId,
      'status': instance.status,
      'shippingUserAddressId': instance.shippingUserAddressId,
      'billingUserAddressId': instance.billingUserAddressId,
      'isShippingSameAsBilling': instance.isShippingSameAsBilling,
      'product': instance.products.map((e) => e.toJson()).toList(),
    };
