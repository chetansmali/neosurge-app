// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggested_fund.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestedFund _$SuggestedFundFromJson(Map<String, dynamic> json) =>
    SuggestedFund(
      fundHouseId: json['fundHouseId'] as int,
      type: json['type'] as String,
      id: json['id'] as int,
      fundId: json['fundId'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      isin: json['isin'] as String,
      isThematic: json['isThematic'] as bool,
      performance:
          Performance.fromJson(json['performance'] as Map<String, dynamic>),
      imgUrl: json['img_url'] as String,
    );

Map<String, dynamic> _$SuggestedFundToJson(SuggestedFund instance) =>
    <String, dynamic>{
      'fundHouseId': instance.fundHouseId,
      'type': instance.type,
      'id': instance.id,
      'fundId': instance.fundId,
      'name': instance.name,
      'amount': instance.amount,
      'isin': instance.isin,
      'isThematic': instance.isThematic,
      'performance': instance.performance,
      'img_url': instance.imgUrl,
    };
