// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_redeem_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketRedeemOrderResponse _$BasketRedeemOrderResponseFromJson(
        Map<String, dynamic> json) =>
    BasketRedeemOrderResponse(
      redemptionRef: json['redemptionRef'] as String,
      name: json['name'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      exitLoad: (json['exitLoad'] as num?)?.toDouble(),
      redeemableAmount: (json['redeemableAmount'] as num?)?.toDouble(),
      bankDetails: (json['bankDetails'] as List<dynamic>)
          .map((e) => BankDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BasketRedeemOrderResponseToJson(
        BasketRedeemOrderResponse instance) =>
    <String, dynamic>{
      'redemptionRef': instance.redemptionRef,
      'name': instance.name,
      'amount': instance.amount,
      'exitLoad': instance.exitLoad,
      'redeemableAmount': instance.redeemableAmount,
      'bankDetails': instance.bankDetails,
    };

BankDetails _$BankDetailsFromJson(Map<String, dynamic> json) => BankDetails(
      bankName: json['bankName'] as String?,
      accountNumber: json['accountNumber'] as String?,
    );

Map<String, dynamic> _$BankDetailsToJson(BankDetails instance) =>
    <String, dynamic>{
      'bankName': instance.bankName,
      'accountNumber': instance.accountNumber,
    };
