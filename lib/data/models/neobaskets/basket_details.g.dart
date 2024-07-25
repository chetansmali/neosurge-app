// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketDetailsModel _$BasketDetailsModelFromJson(Map<String, dynamic> json) =>
    BasketDetailsModel(
      name: json['name'] as String,
      cagr: (json['cagr'] as num).toDouble(),
      minSip: (json['minSIP'] as num?)?.toDouble(),
      minLumpsum: (json['minLumpsum'] as num?)?.toDouble(),
      aum: (json['aum'] as num?)?.toDouble(),
      aboutBasket: json['aboutBasket'] as String?,
      whyInvest:
          (json['whyInvest'] as List<dynamic>).map((e) => e as String).toList(),
      basketFunds: (json['basketFunds'] as List<dynamic>)
          .map((e) => BasketFund.fromJson(e as Map<String, dynamic>))
          .toList(),
      basketId: json['basketID'] as String?,
      sixM: json['sixM'] as bool,
      oneY: json['oneY'] as bool,
      threeY: json['threeY'] as bool,
      fiveY: json['fiveY'] as bool,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$BasketDetailsModelToJson(BasketDetailsModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'cagr': instance.cagr,
      'minSIP': instance.minSip,
      'minLumpsum': instance.minLumpsum,
      'aum': instance.aum,
      'aboutBasket': instance.aboutBasket,
      'whyInvest': instance.whyInvest,
      'basketFunds': instance.basketFunds,
      'basketID': instance.basketId,
      'sixM': instance.sixM,
      'oneY': instance.oneY,
      'threeY': instance.threeY,
      'fiveY': instance.fiveY,
      'imageUrl': instance.imageUrl,
    };
