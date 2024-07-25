// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mutual_fund_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MutualFundCart _$MutualFundCartFromJson(Map<String, dynamic> json) =>
    MutualFundCart(
      purchaseType: json['purchaseType'] as String,
      cartValue: (json['cartValue'] as num).toDouble(),
      cartMutualFunds: (json['cartItems'] as List<dynamic>)
          .map((e) => CartMutualFund.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MutualFundCartToJson(MutualFundCart instance) =>
    <String, dynamic>{
      'purchaseType': instance.purchaseType,
      'cartValue': instance.cartValue,
      'cartItems': instance.cartMutualFunds,
    };

CartMutualFund _$CartMutualFundFromJson(Map<String, dynamic> json) =>
    CartMutualFund(
      schemeName: json['schemeName'] as String,
      purchaseAmount: (json['purchaseAmount'] as num).toDouble(),
      installments: json['installments'] as int?,
      invDate: json['invDate'] as String?,
      schemeLogo: json['schemeLogo'] as String,
      cartId: json['cartID'] as int,
      folioNumber: json['folioNumber'] as String?,
    );

Map<String, dynamic> _$CartMutualFundToJson(CartMutualFund instance) =>
    <String, dynamic>{
      'schemeName': instance.schemeName,
      'purchaseAmount': instance.purchaseAmount,
      'schemeLogo': instance.schemeLogo,
      'installments': instance.installments,
      'invDate': instance.invDate,
      'folioNumber': instance.folioNumber,
      'cartID': instance.cartId,
    };
