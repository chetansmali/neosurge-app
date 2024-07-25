// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dg_delivery_transaction_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DgDeliveryTransactionResponseModel _$DgDeliveryTransactionResponseModelFromJson(
        Map<String, dynamic> json) =>
    DgDeliveryTransactionResponseModel(
      id: json['id'] as int,
      billingUserAddressDetail: DeliveryAddressDetailsModel.fromJson(
          json['billingUserAddressDetail'] as Map<String, dynamic>),
      shippingUserAddressDetail: DeliveryAddressDetailsModel.fromJson(
          json['shippingUserAddressDetail'] as Map<String, dynamic>),
      deliveryGoldSilverProduct:
          (json['deliveryGoldSilverProduct'] as List<dynamic>)
              .map((e) =>
                  DeliveryGoldSilverProduct.fromJson(e as Map<String, dynamic>))
              .toList(),
      transactionId: json['transactionId'] as String,
      merchantTransactionId: json['merchantTransactionId'] as String,
      shippingCharges: (json['shippingCharges'] as num).toDouble(),
      totalAmountPaid: (json['totalAmountPaid'] as num).toDouble(),
      totalWeight: (json['totalWeight'] as num).toDouble(),
      isGoldExist: json['isGoldExist'] as bool,
      isSilverExist: json['isSilverExist'] as bool,
      modeOfPayment: json['modeOfPayment'] as String?,
      status: $enumDecode(_$DgTransactionStatusEnumMap, json['status']),
      augmontStatus: json['augmontStatus'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DgDeliveryTransactionResponseModelToJson(
        DgDeliveryTransactionResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'billingUserAddressDetail': instance.billingUserAddressDetail,
      'shippingUserAddressDetail': instance.shippingUserAddressDetail,
      'deliveryGoldSilverProduct': instance.deliveryGoldSilverProduct,
      'transactionId': instance.transactionId,
      'merchantTransactionId': instance.merchantTransactionId,
      'shippingCharges': instance.shippingCharges,
      'totalAmountPaid': instance.totalAmountPaid,
      'totalWeight': instance.totalWeight,
      'isGoldExist': instance.isGoldExist,
      'isSilverExist': instance.isSilverExist,
      'modeOfPayment': instance.modeOfPayment,
      'status': _$DgTransactionStatusEnumMap[instance.status]!,
      'augmontStatus': instance.augmontStatus,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$DgTransactionStatusEnumMap = {
  DgTransactionStatus.success: 'SUCCESS',
  DgTransactionStatus.processing: 'PROCESSING',
  DgTransactionStatus.failure: 'FAILED',
  DgTransactionStatus.all: 'ALL',
};

DeliveryGoldSilverProduct _$DeliveryGoldSilverProductFromJson(
        Map<String, dynamic> json) =>
    DeliveryGoldSilverProduct(
      id: json['id'] as int,
      sku: DeliveryProductModel.fromJson(json['sku'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$DeliveryGoldSilverProductToJson(
        DeliveryGoldSilverProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'quantity': instance.quantity,
      'totalAmount': instance.totalAmount,
    };
