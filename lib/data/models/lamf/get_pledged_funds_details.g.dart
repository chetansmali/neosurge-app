// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pledged_funds_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPledgedFundsDetails _$GetPledgedFundsDetailsFromJson(
        Map<String, dynamic> json) =>
    GetPledgedFundsDetails(
      (json['pledgedHoldings'] as List<dynamic>)
          .map((e) => PledgedHolding.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPledgedFundsDetailsToJson(
        GetPledgedFundsDetails instance) =>
    <String, dynamic>{
      'pledgedHoldings': instance.pledgedHoldings,
    };

PledgedHolding _$PledgedHoldingFromJson(Map<String, dynamic> json) =>
    PledgedHolding(
      creditLimit: (json['creditLimit'] as num).toDouble(),
      scripName: json['scripName'] as String,
    );

Map<String, dynamic> _$PledgedHoldingToJson(PledgedHolding instance) =>
    <String, dynamic>{
      'creditLimit': instance.creditLimit,
      'scripName': instance.scripName,
    };
