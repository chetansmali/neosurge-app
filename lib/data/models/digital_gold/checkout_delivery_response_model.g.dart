// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_delivery_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutDeliveryResponseModel _$CheckoutDeliveryResponseModelFromJson(
        Map<String, dynamic> json) =>
    CheckoutDeliveryResponseModel(
      billingUserAddressDetail: DeliveryAddressDetailsModel.fromJson(
          json['billingUserAddressDetail'] as Map<String, dynamic>),
      shippingUserAddressDetail: DeliveryAddressDetailsModel.fromJson(
          json['shippingUserAddressDetail'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      paidfromWallet: (json['paidfromWallet'] as num).toDouble(),
      amountPayable: (json['amountPayable'] as num).toDouble(),
    );

Map<String, dynamic> _$CheckoutDeliveryResponseModelToJson(
        CheckoutDeliveryResponseModel instance) =>
    <String, dynamic>{
      'billingUserAddressDetail': instance.billingUserAddressDetail,
      'shippingUserAddressDetail': instance.shippingUserAddressDetail,
      'quantity': instance.quantity,
      'amount': instance.amount,
      'tax': instance.tax,
      'totalAmount': instance.totalAmount,
      'paidfromWallet': instance.paidfromWallet,
      'amountPayable': instance.amountPayable,
    };
