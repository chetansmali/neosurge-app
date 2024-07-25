// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retirement_corpus_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetirementCorpusParams _$RetirementCorpusParamsFromJson(
        Map<String, dynamic> json) =>
    RetirementCorpusParams(
      monthlyIncome: json['monthlyIncome'] as int,
      monthlyExpense: json['monthlyExpense'] as int,
      existingSavings: json['existingSavings'] as int,
      investmentStyle: json['investmentStyle'] as String,
      postRetirementStyle: json['postRetirementStyle'] as String,
      retirementAge: json['retirementAge'] as int,
    );

Map<String, dynamic> _$RetirementCorpusParamsToJson(
        RetirementCorpusParams instance) =>
    <String, dynamic>{
      'monthlyIncome': instance.monthlyIncome,
      'monthlyExpense': instance.monthlyExpense,
      'existingSavings': instance.existingSavings,
      'investmentStyle': instance.investmentStyle,
      'postRetirementStyle': instance.postRetirementStyle,
      'retirementAge': instance.retirementAge,
    };
