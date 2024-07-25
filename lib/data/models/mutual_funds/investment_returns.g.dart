// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investment_returns.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvestmentReturns _$InvestmentReturnsFromJson(Map<String, dynamic> json) =>
    InvestmentReturns(
      investedAmount: (json['investedAmount'] as num).toDouble(),
      currentValue: (json['currentValue'] as num).toDouble(),
      unrealizedGain: (json['unrealizedGain'] as num).toDouble(),
      absoluteReturn: (json['absoluteReturn'] as num).toDouble(),
      xirr: (json['xirr'] as num).toDouble(),
    );

Map<String, dynamic> _$InvestmentReturnsToJson(InvestmentReturns instance) =>
    <String, dynamic>{
      'investedAmount': instance.investedAmount,
      'currentValue': instance.currentValue,
      'unrealizedGain': instance.unrealizedGain,
      'absoluteReturn': instance.absoluteReturn,
      'xirr': instance.xirr,
    };
