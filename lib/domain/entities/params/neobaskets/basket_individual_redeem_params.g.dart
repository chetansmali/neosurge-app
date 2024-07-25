// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_individual_redeem_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketIndividualRedeemParams _$BasketIndividualRedeemParamsFromJson(
        Map<String, dynamic> json) =>
    BasketIndividualRedeemParams(
      basketId: json['basketID'] as String,
      schemeId: json['schemeID'] as String,
      amount: (json['amount'] as num?)?.toDouble(),
      units: (json['units'] as num?)?.toDouble(),
      fullRedeem: json['fullRedeem'] as bool,
    );

Map<String, dynamic> _$BasketIndividualRedeemParamsToJson(
        BasketIndividualRedeemParams instance) =>
    <String, dynamic>{
      'basketID': instance.basketId,
      'schemeID': instance.schemeId,
      'amount': instance.amount,
      'units': instance.units,
      'fullRedeem': instance.fullRedeem,
    };
