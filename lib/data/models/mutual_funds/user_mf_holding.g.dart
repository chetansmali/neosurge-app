// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_mf_holding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMfHoldings _$UserMfHoldingsFromJson(Map<String, dynamic> json) =>
    UserMfHoldings(
      investedValue: (json['investedValue'] as num).toDouble(),
      currentValue: (json['currentValue'] as num).toDouble(),
      totalReturns: (json['totalReturns'] as num).toDouble(),
      returnsPercentage: (json['returnsPercentage'] as num).toDouble(),
      schemes: (json['schemes'] as List<dynamic>)
          .map((e) => UserMfScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserMfHoldingsToJson(UserMfHoldings instance) =>
    <String, dynamic>{
      'investedValue': instance.investedValue,
      'currentValue': instance.currentValue,
      'totalReturns': instance.totalReturns,
      'returnsPercentage': instance.returnsPercentage,
      'schemes': instance.schemes,
    };
