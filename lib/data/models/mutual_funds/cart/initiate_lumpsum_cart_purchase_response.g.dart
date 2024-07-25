// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initiate_lumpsum_cart_purchase_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitiateCartPurchaseResponse _$InitiateCartPurchaseResponseFromJson(
        Map<String, dynamic> json) =>
    InitiateCartPurchaseResponse(
      cartPurchaseId: json['cartPurchaseID'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$InitiateCartPurchaseResponseToJson(
        InitiateCartPurchaseResponse instance) =>
    <String, dynamic>{
      'cartPurchaseID': instance.cartPurchaseId,
      'status': instance.status,
    };
