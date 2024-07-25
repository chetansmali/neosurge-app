// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invest_suggested_funds_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvestSuggestedFundsParams _$InvestSuggestedFundsParamsFromJson(
        Map<String, dynamic> json) =>
    InvestSuggestedFundsParams(
      userId: json['userId'] as int,
      mfLumpsumConsentId: json['mfLumpsumConsentId'] as int,
      suggestionList: (json['suggestionList'] as List<dynamic>)
          .map((e) => SuggestedFundDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InvestSuggestedFundsParamsToJson(
        InvestSuggestedFundsParams instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'mfLumpsumConsentId': instance.mfLumpsumConsentId,
      'suggestionList': instance.suggestionList.map((e) => e.toJson()).toList(),
    };

SuggestedFundDetail _$SuggestedFundDetailFromJson(Map<String, dynamic> json) =>
    SuggestedFundDetail(
      id: json['id'] as int,
      amount: (json['amount'] as num).toDouble(),
      fundId: json['fundId'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      isThematic: json['isThematic'] as bool,
    );

Map<String, dynamic> _$SuggestedFundDetailToJson(
        SuggestedFundDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fundId': instance.fundId,
      'name': instance.name,
      'type': instance.type,
      'amount': instance.amount,
      'isThematic': instance.isThematic,
    };
