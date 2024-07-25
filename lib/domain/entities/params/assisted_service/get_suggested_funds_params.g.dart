// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_suggested_funds_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSuggestedFundsParams _$GetSuggestedFundsParamsFromJson(
        Map<String, dynamic> json) =>
    GetSuggestedFundsParams(
      amount: (json['amount'] as num).toDouble(),
      tenure: json['tenure'] as int,
      userId: json['userId'] as int,
      suggestCount: json['suggestCount'] as int? ?? 0,
    );

Map<String, dynamic> _$GetSuggestedFundsParamsToJson(
        GetSuggestedFundsParams instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'tenure': instance.tenure,
      'userId': instance.userId,
      'suggestCount': instance.suggestCount,
    };
