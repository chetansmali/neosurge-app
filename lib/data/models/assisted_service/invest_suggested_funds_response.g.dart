// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invest_suggested_funds_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvestSuggestedFundsResponse _$InvestSuggestedFundsResponseFromJson(
        Map<String, dynamic> json) =>
    InvestSuggestedFundsResponse(
      ids: (json['ids'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$InvestSuggestedFundsResponseToJson(
        InvestSuggestedFundsResponse instance) =>
    <String, dynamic>{
      'ids': instance.ids,
    };
